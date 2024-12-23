#!/bin/sh
# Copyright 2024 Google LLC
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

#################################### Scalar ###################################
tools/xngen src/qs8-rsum/scalar.c.in -D CHANNEL_TILE=1  -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -D VARIANT=IMAGIC -D WASM=0 -o src/qs8-rsum/gen/qs8-rdsum-minmax-fp32-scalar-imagic-u1-acc1.c &
tools/xngen src/qs8-rsum/scalar.c.in -D CHANNEL_TILE=2  -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -D VARIANT=IMAGIC -D WASM=0 -o src/qs8-rsum/gen/qs8-rdsum-minmax-fp32-scalar-imagic-u2-acc1.c &
tools/xngen src/qs8-rsum/scalar.c.in -D CHANNEL_TILE=4  -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -D VARIANT=IMAGIC -D WASM=0 -o src/qs8-rsum/gen/qs8-rdsum-minmax-fp32-scalar-imagic-u4-acc1.c &

################################## ARM NEON ###################################
tools/xngen src/qs8-rsum/neon.c.in   -D CHANNEL_TILE=16 -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -D ARMV8=0 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neon-u16.c &
tools/xngen src/qs8-rsum/neon.c.in   -D CHANNEL_TILE=32 -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -D ARMV8=0 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neon-u32.c &
tools/xngen src/qs8-rsum/neon.c.in   -D CHANNEL_TILE=32 -D ACCUMULATORS=2 -D REQUANTIZATION=FP32 -D ARMV8=0 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neon-u32-acc2.c &
tools/xngen src/qs8-rsum/neon.c.in   -D CHANNEL_TILE=64 -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -D ARMV8=0 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neon-u64.c &
tools/xngen src/qs8-rsum/neon.c.in   -D CHANNEL_TILE=64 -D ACCUMULATORS=2 -D REQUANTIZATION=FP32 -D ARMV8=0 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neon-u64-acc2.c &
tools/xngen src/qs8-rsum/neon.c.in   -D CHANNEL_TILE=64 -D ACCUMULATORS=4 -D REQUANTIZATION=FP32 -D ARMV8=0 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neon-u64-acc4.c &

################################## ARM NEONDOT #################################
tools/xngen src/qs8-rsum/neondot.c.in -D CHANNEL_TILE=16 -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neondot-u16.c &
tools/xngen src/qs8-rsum/neondot.c.in -D CHANNEL_TILE=32 -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neondot-u32.c &
tools/xngen src/qs8-rsum/neondot.c.in -D CHANNEL_TILE=32 -D ACCUMULATORS=2 -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neondot-u32-acc2.c &
tools/xngen src/qs8-rsum/neondot.c.in -D CHANNEL_TILE=64 -D ACCUMULATORS=1 -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neondot-u64.c &
tools/xngen src/qs8-rsum/neondot.c.in -D CHANNEL_TILE=64 -D ACCUMULATORS=2 -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neondot-u64-acc2.c &
tools/xngen src/qs8-rsum/neondot.c.in -D CHANNEL_TILE=64 -D ACCUMULATORS=4 -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-neondot-u64-acc4.c &

################################### x86 SSE ###################################
tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=16  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u16.c &
tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=32  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u32.c &
tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u64.c &

tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=2 -D CHANNEL_TILE=16  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u16-acc2.c &
tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=2 -D CHANNEL_TILE=32  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u32-acc2.c &
tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=2 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u64-acc2.c &

tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=4 -D CHANNEL_TILE=32  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u32-acc4.c &
tools/xngen src/qs8-rsum/sse41.c.in -D ACCUMULATORS=4 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-sse41-u64-acc4.c &

################################### x86 AVX2 ##################################
tools/xngen src/qs8-rsum/avx2.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=16  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx2-u16.c &
tools/xngen src/qs8-rsum/avx2.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=32  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx2-u32.c &
tools/xngen src/qs8-rsum/avx2.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx2-u64.c &

tools/xngen src/qs8-rsum/avx2.c.in -D ACCUMULATORS=2 -D CHANNEL_TILE=32  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx2-u32-acc2.c &
tools/xngen src/qs8-rsum/avx2.c.in -D ACCUMULATORS=2 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx2-u64-acc2.c &

tools/xngen src/qs8-rsum/avx2.c.in -D ACCUMULATORS=4 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx2-u64-acc4.c &

################################### x86 AVX2 ##################################
tools/xngen src/qs8-rsum/avx512skx.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=32  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx512skx-u32.c &
tools/xngen src/qs8-rsum/avx512skx.c.in -D ACCUMULATORS=1 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx512skx-u64.c &
tools/xngen src/qs8-rsum/avx512skx.c.in -D ACCUMULATORS=2 -D CHANNEL_TILE=64  -D REQUANTIZATION=FP32 -o src/qs8-rsum/gen/qs8-rsum-minmax-fp32-avx512skx-u64-acc2.c &

wait