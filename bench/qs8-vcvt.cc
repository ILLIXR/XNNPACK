// Copyright 2023 Google LLC
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//
// Auto-generated file. Do not edit!
//   Specification: test/qs8-vcvt.yaml
//   Generator: tools/generate-vcvt-test.py


#include <benchmark/benchmark.h>
#include "bench/utils.h"
#include "bench/vcvt-benchmark.h"

#include <tfl-xnnpack.h>
#include <xnnpack/common.h>
#include <xnnpack/microfnptr.h>
#include <xnnpack/microparams-init.h>
#include <xnnpack/vcvt.h>


#if XNN_ARCH_WASMRELAXEDSIMD
  BENCHMARK_CAPTURE(qs8_vcvt, wasmrelaxedsimd_u8,
                    xnn_qs8_vcvt_ukernel__wasmrelaxedsimd_u8,
                    xnn_init_qs8_cvt_wasmsimd_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_WASMRELAXEDSIMD


#if XNN_ARCH_WASMRELAXEDSIMD
  BENCHMARK_CAPTURE(qs8_vcvt, wasmrelaxedsimd_u16,
                    xnn_qs8_vcvt_ukernel__wasmrelaxedsimd_u16,
                    xnn_init_qs8_cvt_wasmsimd_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_WASMRELAXEDSIMD


#if XNN_ARCH_WASMRELAXEDSIMD
  BENCHMARK_CAPTURE(qs8_vcvt, wasmrelaxedsimd_u32,
                    xnn_qs8_vcvt_ukernel__wasmrelaxedsimd_u32,
                    xnn_init_qs8_cvt_wasmsimd_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_WASMRELAXEDSIMD


#if XNN_ARCH_WASMSIMD || XNN_ARCH_WASMRELAXEDSIMD
  BENCHMARK_CAPTURE(qs8_vcvt, wasmsimd_u8,
                    xnn_qs8_vcvt_ukernel__wasmsimd_u8,
                    xnn_init_qs8_cvt_wasmsimd_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_WASMSIMD || XNN_ARCH_WASMRELAXEDSIMD


#if XNN_ARCH_WASMSIMD || XNN_ARCH_WASMRELAXEDSIMD
  BENCHMARK_CAPTURE(qs8_vcvt, wasmsimd_u16,
                    xnn_qs8_vcvt_ukernel__wasmsimd_u16,
                    xnn_init_qs8_cvt_wasmsimd_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_WASMSIMD || XNN_ARCH_WASMRELAXEDSIMD


#if XNN_ARCH_WASMSIMD || XNN_ARCH_WASMRELAXEDSIMD
  BENCHMARK_CAPTURE(qs8_vcvt, wasmsimd_u32,
                    xnn_qs8_vcvt_ukernel__wasmsimd_u32,
                    xnn_init_qs8_cvt_wasmsimd_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_WASMSIMD || XNN_ARCH_WASMRELAXEDSIMD


#if XNN_ARCH_ARM || XNN_ARCH_ARM64
  BENCHMARK_CAPTURE(qs8_vcvt, neon_u8,
                    xnn_qs8_vcvt_ukernel__neon_u8,
                    xnn_init_qs8_cvt_neon_params,
                    benchmark::utils::CheckNEON)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_ARM || XNN_ARCH_ARM64


#if XNN_ARCH_ARM || XNN_ARCH_ARM64
  BENCHMARK_CAPTURE(qs8_vcvt, neon_u16,
                    xnn_qs8_vcvt_ukernel__neon_u16,
                    xnn_init_qs8_cvt_neon_params,
                    benchmark::utils::CheckNEON)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_ARM || XNN_ARCH_ARM64


#if XNN_ARCH_ARM || XNN_ARCH_ARM64
  BENCHMARK_CAPTURE(qs8_vcvt, neon_u32,
                    xnn_qs8_vcvt_ukernel__neon_u32,
                    xnn_init_qs8_cvt_neon_params,
                    benchmark::utils::CheckNEON)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_ARM || XNN_ARCH_ARM64


#if XNN_ARCH_ARM
  BENCHMARK_CAPTURE(qs8_vcvt, armsimd32_u4,
                    xnn_qs8_vcvt_ukernel__armsimd32_u4,
                    xnn_init_qs8_cvt_armsimd32_params,
                    benchmark::utils::CheckARMV6)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_ARM


#if XNN_ARCH_ARM
  BENCHMARK_CAPTURE(qs8_vcvt, armsimd32_u8,
                    xnn_qs8_vcvt_ukernel__armsimd32_u8,
                    xnn_init_qs8_cvt_armsimd32_params,
                    benchmark::utils::CheckARMV6)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_ARM


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, avx2_u16,
                    xnn_qs8_vcvt_ukernel__avx2_u16,
                    xnn_init_qs8_cvt_avx2_params,
                    benchmark::utils::CheckAVX2)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, avx2_u32,
                    xnn_qs8_vcvt_ukernel__avx2_u32,
                    xnn_init_qs8_cvt_avx2_params,
                    benchmark::utils::CheckAVX2)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, avx2_u64,
                    xnn_qs8_vcvt_ukernel__avx2_u64,
                    xnn_init_qs8_cvt_avx2_params,
                    benchmark::utils::CheckAVX2)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, avx_u8,
                    xnn_qs8_vcvt_ukernel__avx_u8,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckAVX)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, avx_u16,
                    xnn_qs8_vcvt_ukernel__avx_u16,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckAVX)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, avx_u32,
                    xnn_qs8_vcvt_ukernel__avx_u32,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckAVX)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, sse41_u8,
                    xnn_qs8_vcvt_ukernel__sse41_u8,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckSSE41)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, sse41_u16,
                    xnn_qs8_vcvt_ukernel__sse41_u16,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckSSE41)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, sse41_u32,
                    xnn_qs8_vcvt_ukernel__sse41_u32,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckSSE41)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, ssse3_u16,
                    xnn_qs8_vcvt_ukernel__ssse3_u16,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckSSSE3)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, ssse3_u32,
                    xnn_qs8_vcvt_ukernel__ssse3_u32,
                    xnn_init_qs8_cvt_ssse3_params,
                    benchmark::utils::CheckSSSE3)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, sse2_u16,
                    xnn_qs8_vcvt_ukernel__sse2_u16,
                    xnn_init_qs8_cvt_sse2_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


#if XNN_ARCH_X86 || XNN_ARCH_X86_64
  BENCHMARK_CAPTURE(qs8_vcvt, sse2_u32,
                    xnn_qs8_vcvt_ukernel__sse2_u32,
                    xnn_init_qs8_cvt_sse2_params)
    ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
    ->UseRealTime();
#endif  // XNN_ARCH_X86 || XNN_ARCH_X86_64


BENCHMARK_CAPTURE(qs8_vcvt, scalar_u1,
                  xnn_qs8_vcvt_ukernel__scalar_u1,
                  xnn_init_qs8_cvt_scalar_params)
  ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
  ->UseRealTime();

BENCHMARK_CAPTURE(qs8_vcvt, scalar_u2,
                  xnn_qs8_vcvt_ukernel__scalar_u2,
                  xnn_init_qs8_cvt_scalar_params)
  ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
  ->UseRealTime();

BENCHMARK_CAPTURE(qs8_vcvt, scalar_u4,
                  xnn_qs8_vcvt_ukernel__scalar_u4,
                  xnn_init_qs8_cvt_scalar_params)
  ->Apply(benchmark::utils::UnaryElementwiseParameters<int8_t, int8_t>)
  ->UseRealTime();

#ifndef XNNPACK_BENCHMARK_NO_MAIN
BENCHMARK_MAIN();
#endif
