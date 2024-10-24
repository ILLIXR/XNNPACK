// Copyright 2024 Google LLC
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.

#ifndef __XNNPACK_BENCH_F16_VUNARY_BENCHMARK_H_
#define __XNNPACK_BENCH_F16_VUNARY_BENCHMARK_H_

#include <tfl-xnnpack.h>
#include <xnnpack/aligned-allocator.h>
#include <xnnpack/common.h>
#include <xnnpack/microfnptr.h>
#include <xnnpack/microparams-init.h>
#include <xnnpack/vunary.h>

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <functional>
#include <random>
#include <vector>

#include <fp16/fp16.h>
#include "bench/utils.h"
#include <benchmark/benchmark.h>

// Parameter initialization function, templated on the `UKernelParams` type,
// used in `f16_vunary_benchmark` below.
template <typename UKernelParams>
using InitParamsFunction = std::function<size_t(UKernelParams*)>;

// Microkernel function, templated on the `params` type.
template <typename UKernelParams>
using UKernelFunction = void (*)(size_t, const void*, void*,
                                 const UKernelParams* params);

// Template function to generate unary benchmarks. Creates a vector of size
// `state.range(0)` containing uniformly distributed random numbers in the range
// [`range_min`, `range_max`) and calls `ukernel` on it.
//
// The `init_params` and `isa_check` parameters may be `nullptr`.
//
// To use this template for benchmarking a kernel with a unary `init_params`
// function, create a wrapper e.g. for `vsqrt`:
//
//   void f16_vsqrt(benchmark::State& state, xnn_f16_vsqrt_ukernel_fn vsqrt,
//                 xnn_init_f16_sqrt_params_fn init_params = nullptr,
//                 benchmark::utils::IsaCheckFunction isa_check = nullptr) {
//     f16_vunary_benchmark<xnn_f16_sqrt_params>(state, vsqrt, init_params,
//                                               isa_check,
//                                               /*range_min=*/0.0f,
//                                               /*range_max=*/10.0f);
//   }
//
// For initialization functions with additional parameters, e.g. for `velu`:
//
//   void f16_velu(benchmark::State& state, xnn_f16_velu_ukernel_fn velu,
//                 xnn_init_f16_elu_params_fn init_params = nullptr,
//                 benchmark::utils::IsaCheckFunction isa_check = nullptr) {
//     f16_vunary_benchmark<xnn_f16_elu_params>(
//         state, velu,
//         [init_params](xnn_f16_elu_params* params) -> size_t {
//           init_params(params, 1.0f /* prescale */, 1.0f /* alpha */,
//                       1.0f /* beta */);
//           return sizeof(*params);
//         },
//         isa_check,
//         /*range_min=*/-20.0f,
//         /*range_max=*/10.0f);
//   }
//
// And add the appropriate `BENCHMARK_CAPTURE`s, e.g. for `vsqrt`:
//
//   BENCHMARK_CAPTURE(f16_vsqrt, scalar_sqrt_u1,
//                     xnn_f16_vsqrt_ukernel__scalar_sqrt_u1)
//     ->Apply(benchmark::utils::UnaryElementwiseParameters<float, float>)
//     ->UseRealTime();
//
template <typename UKernelParams>
void f16_vunary_benchmark(benchmark::State& state,
                          UKernelFunction<UKernelParams> ukernel,
                          InitParamsFunction<UKernelParams> init_params,
                          benchmark::utils::IsaCheckFunction isa_check,
                          float range_min, float range_max) {
  if (isa_check != nullptr && !isa_check(state)) {
    return;
  }

  const size_t num_elements = state.range(0);

  std::random_device random_device;
  auto rng = std::mt19937(random_device());
  auto f32rng =
      std::bind(std::uniform_real_distribution<float>(range_min, range_max),
                std::ref(rng));
  auto f16rng = std::bind(fp16_ieee_from_fp32_value, f32rng);

  std::vector<uint16_t, AlignedAllocator<uint16_t, 64>> x(num_elements);
  std::vector<uint16_t, AlignedAllocator<uint16_t, 64>> y(num_elements);
  std::generate(x.begin(), x.end(), std::ref(f16rng));
  std::fill(y.begin(), y.end(), UINT16_C(0x7E00) /* NaN */);

  UKernelParams params;
  if (init_params != nullptr) {
    init_params(&params);
  }
  for (auto _ : state) {
    ukernel(num_elements * sizeof(uint16_t), x.data(), y.data(), &params);
  }

  const uint64_t cpu_frequency = benchmark::utils::GetCurrentCpuFrequency();
  if (cpu_frequency != 0) {
    state.counters["cpufreq"] = cpu_frequency;
  }

  const size_t elements_per_iteration = num_elements;
  state.counters["elements"] = benchmark::Counter(
      static_cast<uint64_t>(state.iterations()) * elements_per_iteration,
      benchmark::Counter::kIsRate);

  const size_t bytes_per_iteration = 2 * num_elements * sizeof(uint16_t);
  state.counters["bytes"] = benchmark::Counter(
      static_cast<uint64_t>(state.iterations()) * bytes_per_iteration,
      benchmark::Counter::kIsRate);
}

#endif  // __XNNPACK_BENCH_F16_VUNARY_BENCHMARK_H_
