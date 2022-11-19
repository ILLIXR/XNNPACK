// Auto-generated file. Do not edit!
//   Template: src/f32-spmm/neon.c.in
//   Generator: tools/xngen
//
// Copyright 2019 Google LLC
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.

#include <assert.h>

#include <arm_neon.h>

#include <xnnpack/prefetch.h>
#include <xnnpack/spmm.h>


void xnn_f32_spmm_minmax_ukernel_16x1__neonfma_x2(
    size_t mc,
    size_t nc,
    const float*restrict input,
    const float*restrict weights,
    const int32_t*restrict widx_dmap,
    const uint32_t*restrict nidx_nnzmap,
    float*restrict output,
    size_t output_stride,
    const union xnn_f32_minmax_params params[restrict XNN_MIN_ELEMENTS(1)])
{
  assert(mc != 0);
  assert(mc % sizeof(float) == 0);
  assert(nc != 0);

  #if XNN_ARCH_ARM64
    const float32x4x2_t vminmax = vld2q_dup_f32(&params->scalar.min);
    const float32x4_t vmin = vminmax.val[0];
    const float32x4_t vmax = vminmax.val[1];
  #else
    const float32x2x2_t vminmax = vld2_dup_f32(&params->scalar.min);
    const float32x4_t vmin = vcombine_f32(vminmax.val[0],vminmax.val[0]);
    const float32x4_t vmax = vcombine_f32(vminmax.val[1],vminmax.val[1]);
  #endif

  size_t output_decrement = output_stride * nc - 16 * sizeof(float);
  while XNN_LIKELY(mc >= 16 * sizeof(float)) {
    const float*restrict w = weights;
    const int32_t* dmap = widx_dmap;
    const uint32_t* nnzmap = nidx_nnzmap;
    size_t n = nc;
    do {
      uint32_t nnz = *nnzmap++;
      float32x4_t vacc0123x0 = vld1q_dup_f32(w); w += 1;
      float32x4_t vacc0123x1 = vmovq_n_f32(0.0f);
      float32x4_t vacc4567x0 = vacc0123x0;
      float32x4_t vacc4567x1 = vmovq_n_f32(0.0f);
      float32x4_t vacc89ABx0 = vacc0123x0;
      float32x4_t vacc89ABx1 = vmovq_n_f32(0.0f);
      float32x4_t vaccCDEFx0 = vacc0123x0;
      float32x4_t vaccCDEFx1 = vmovq_n_f32(0.0f);
      for (; nnz >= 2; nnz -= 2) {
        const intptr_t diff0 = dmap[0];
        const intptr_t diff1 = dmap[1];
        dmap += 2;
        const float32x4_t vi0123x0 = vld1q_f32(input);
        const float32x4_t vi4567x0 = vld1q_f32(input + 4);
        const float32x4_t vi89ABx0 = vld1q_f32(input + 8);
        const float32x4_t viCDEFx0 = vld1q_f32(input + 12);
        input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff0);
        xnn_prefetch_to_l1(input + 16);
        const float32x4_t vw0 = vld1q_dup_f32(w); w += 1;
        xnn_prefetch_to_l1(w + 32);
        vacc0123x0 = vfmaq_f32(vacc0123x0, vi0123x0, vw0);
        vacc4567x0 = vfmaq_f32(vacc4567x0, vi4567x0, vw0);
        vacc89ABx0 = vfmaq_f32(vacc89ABx0, vi89ABx0, vw0);
        vaccCDEFx0 = vfmaq_f32(vaccCDEFx0, viCDEFx0, vw0);
        const float32x4_t vi0123x1 = vld1q_f32(input);
        const float32x4_t vi4567x1 = vld1q_f32(input + 4);
        const float32x4_t vi89ABx1 = vld1q_f32(input + 8);
        const float32x4_t viCDEFx1 = vld1q_f32(input + 12);
        input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff1);
        xnn_prefetch_to_l1(input + 16);
        const float32x4_t vw1 = vld1q_dup_f32(w); w += 1;
        xnn_prefetch_to_l1(w + 32);
        vacc0123x1 = vfmaq_f32(vacc0123x1, vi0123x1, vw1);
        vacc4567x1 = vfmaq_f32(vacc4567x1, vi4567x1, vw1);
        vacc89ABx1 = vfmaq_f32(vacc89ABx1, vi89ABx1, vw1);
        vaccCDEFx1 = vfmaq_f32(vaccCDEFx1, viCDEFx1, vw1);
      }
      float32x4_t vacc0123 = vacc0123x0;
      float32x4_t vacc4567 = vacc4567x0;
      float32x4_t vacc89AB = vacc89ABx0;
      float32x4_t vaccCDEF = vaccCDEFx0;
      vacc0123 = vaddq_f32(vacc0123, vacc0123x1);
      vacc4567 = vaddq_f32(vacc4567, vacc4567x1);
      vacc89AB = vaddq_f32(vacc89AB, vacc89ABx1);
      vaccCDEF = vaddq_f32(vaccCDEF, vaccCDEFx1);
      if XNN_LIKELY(nnz != 0) {
        do {
          const intptr_t diff = *dmap++;
          const float32x4_t vi0123 = vld1q_f32(input);
          const float32x4_t vi4567 = vld1q_f32(input + 4);
          const float32x4_t vi89AB = vld1q_f32(input + 8);
          const float32x4_t viCDEF = vld1q_f32(input + 12);
          input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff);
          xnn_prefetch_to_l1(input + 16);
          const float32x4_t vw = vld1q_dup_f32(w); w += 1;
          xnn_prefetch_to_l1(w + 32);
          vacc0123 = vfmaq_f32(vacc0123, vi0123, vw);
          vacc4567 = vfmaq_f32(vacc4567, vi4567, vw);
          vacc89AB = vfmaq_f32(vacc89AB, vi89AB, vw);
          vaccCDEF = vfmaq_f32(vaccCDEF, viCDEF, vw);
        } while (--nnz != 0);
      }
      float32x4_t vout0123 = vminq_f32(vacc0123, vmax);
      float32x4_t vout4567 = vminq_f32(vacc4567, vmax);
      float32x4_t vout89AB = vminq_f32(vacc89AB, vmax);
      float32x4_t voutCDEF = vminq_f32(vaccCDEF, vmax);
      vout0123 = vmaxq_f32(vout0123, vmin);
      vout4567 = vmaxq_f32(vout4567, vmin);
      vout89AB = vmaxq_f32(vout89AB, vmin);
      voutCDEF = vmaxq_f32(voutCDEF, vmin);
      vst1q_f32(output, vout0123);
      vst1q_f32(output + 4, vout4567);
      vst1q_f32(output + 8, vout89AB);
      vst1q_f32(output + 12, voutCDEF);
      output = (float*restrict) ((uintptr_t) output + output_stride);
    } while (--n != 0);
    output = (float*restrict) ((uintptr_t) output - output_decrement);
    input += 16;
    mc -= 16 * sizeof(float);
  }
  if XNN_UNLIKELY(mc != 0) {
    output_decrement += 8 * sizeof(float);
    if (mc & (8 * sizeof(float))) {
      const float*restrict w = weights;
      const int32_t* dmap = widx_dmap;
      const uint32_t* nnzmap = nidx_nnzmap;
      size_t n = nc;
      do {
        uint32_t nnz = *nnzmap++;
        float32x4_t vacc0123 = vld1q_dup_f32(w); w += 1;
        float32x4_t vacc4567 = vacc0123;
        if XNN_LIKELY(nnz != 0) {
          do {
            const intptr_t diff = *dmap++;
            const float32x4_t vi0123 = vld1q_f32(input);
            const float32x4_t vi4567 = vld1q_f32(input + 4);
            input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff);
            const float32x4_t vw = vld1q_dup_f32(w); w += 1;
            vacc0123 = vfmaq_f32(vacc0123, vi0123, vw);
            vacc4567 = vfmaq_f32(vacc4567, vi4567, vw);
          } while (--nnz != 0);
        }
        float32x4_t vout0123 = vminq_f32(vacc0123, vmax);
        float32x4_t vout4567 = vminq_f32(vacc4567, vmax);
        vout0123 = vmaxq_f32(vout0123, vmin);
        vout4567 = vmaxq_f32(vout4567, vmin);
        vst1q_f32(output, vout0123);
        vst1q_f32(output + 4, vout4567);
        output = (float*restrict) ((uintptr_t) output + output_stride);
      } while (--n != 0);
      output = (float*restrict) ((uintptr_t) output - output_decrement);
      input += 8;
    }
    output_decrement += 4 * sizeof(float);
    if (mc & (4 * sizeof(float))) {
      const float*restrict w = weights;
      const int32_t* dmap = widx_dmap;
      const uint32_t* nnzmap = nidx_nnzmap;
      size_t n = nc;
      do {
        uint32_t nnz = *nnzmap++;
        float32x4_t vacc0123 = vld1q_dup_f32(w); w += 1;
        if XNN_LIKELY(nnz != 0) {
          do {
            const intptr_t diff = *dmap++;
            const float32x4_t vi0123 = vld1q_f32(input);
            input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff);
            const float32x4_t vw = vld1q_dup_f32(w); w += 1;
            vacc0123 = vfmaq_f32(vacc0123, vi0123, vw);
          } while (--nnz != 0);
        }
        float32x4_t vout0123 = vminq_f32(vacc0123, vmax);
        vout0123 = vmaxq_f32(vout0123, vmin);
        vst1q_f32(output, vout0123);
        output = (float*restrict) ((uintptr_t) output + output_stride);
      } while (--n != 0);
      output = (float*restrict) ((uintptr_t) output - output_decrement);
      input += 4;
    }
    output_decrement += 2 * sizeof(float);
    if (mc & (2 * sizeof(float))) {
      const float*restrict w = weights;
      const int32_t* dmap = widx_dmap;
      const uint32_t* nnzmap = nidx_nnzmap;
      size_t n = nc;
      do {
        uint32_t nnz = *nnzmap++;
        float32x2_t vacc01 = vld1_dup_f32(w); w += 1;
        if XNN_LIKELY(nnz != 0) {
          do {
            const intptr_t diff = *dmap++;
            const float32x2_t vi01 = vld1_f32(input);
            input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff);
            const float32x2_t vw = vld1_dup_f32(w); w += 1;
            vacc01 = vfma_f32(vacc01, vi01, vw);
          } while (--nnz != 0);
        }
        float32x2_t vout01 = vmin_f32(vacc01, vget_low_f32(vmax));
        vout01 = vmax_f32(vout01, vget_low_f32(vmin));
        vst1_f32(output, vout01);
        output = (float*restrict) ((uintptr_t) output + output_stride);
      } while (--n != 0);
      output = (float*restrict) ((uintptr_t) output - output_decrement);
      input += 2;
    }
    output_decrement += 1 * sizeof(float);
    if (mc & (1 * sizeof(float))) {
      const float*restrict w = weights;
      const int32_t* dmap = widx_dmap;
      const uint32_t* nnzmap = nidx_nnzmap;
      size_t n = nc;
      do {
        uint32_t nnz = *nnzmap++;
        float32x2_t vacc0 = vld1_dup_f32(w); w += 1;
        if XNN_LIKELY(nnz != 0) {
          do {
            const intptr_t diff = *dmap++;
            const float32x2_t vi0 = vld1_dup_f32(input);
            input = (const float*restrict) ((uintptr_t) input + (uintptr_t) diff);
            const float32x2_t vw = vld1_dup_f32(w); w += 1;
            vacc0 = vfma_f32(vacc0, vi0, vw);
          } while (--nnz != 0);
        }
        float32x2_t vout0 = vmin_f32(vacc0, vget_low_f32(vmax));
        vout0 = vmax_f32(vout0, vget_low_f32(vmin));
        vst1_lane_f32(output, vout0, 0);
        output = (float*restrict) ((uintptr_t) output + output_stride);
      } while (--n != 0);
      output = (float*restrict) ((uintptr_t) output - output_decrement);
      input += 1;
    }
  }
}
