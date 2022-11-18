// Copyright 2022 Google LLC
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.

#pragma once

#include <stddef.h>
#include <stdint.h>

#include <xnnpack/params.h>

struct xnn_transpose_subconfig {
  union {
    xnn_transposec_ukernel_fn const_size_ukernel;
    xnn_transposev_ukernel_fn variable_size_ukernel;
  };
  union {
    xnn_init_x24_transpose_params_fn x24;
    xnn_init_x32_transpose_params_fn x32;
    xnn_init_x64_transpose_params_fn x64;
  } init;
  // Maximum number of elements to process per ukernel call.
  size_t tile_size;
};

struct xnn_transpose_config {
  struct xnn_transpose_subconfig x8;
  struct xnn_transpose_subconfig x16;
  struct xnn_transpose_subconfig x32;
  struct xnn_transpose_subconfig xx;
  xnn_vunary_ukernel_fn copy;
};

XNN_INTERNAL const struct xnn_transpose_config* xnn_init_transpose_config();

struct xnn_hardware_config {
  char _; // Dummy member variable to comply with the C standard
#if XNN_ARCH_ARM || XNN_ARCH_ARM64
  bool use_arm_neon_dot;
  bool use_arm_neon_fp16_arith;
#endif
#if XNN_ARCH_ARM
  bool use_arm_neon;
  bool use_arm_neon_fma;
  bool use_arm_neon_fp16;
  bool use_arm_v6;
  bool use_arm_v8;
  bool use_arm_vfpv2;
  bool use_arm_vfpv3;
#elif XNN_ARCH_X86 || XNN_ARCH_X86_64
  bool use_x86_avx;
  bool use_x86_avx2;
  bool use_x86_avx512f;
  bool use_x86_avx512vbmi;
  bool use_x86_avx512skx;
#endif
};

XNN_INTERNAL const struct xnn_hardware_config* xnn_init_hardware_config();
