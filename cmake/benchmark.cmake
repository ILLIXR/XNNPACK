# ---[ XNNPACK microbenchmarks
IF(XNNPACK_BUILD_BENCHMARKS)
    # ---[ Build google benchmark
    IF(NOT TARGET benchmark)
        IF(XNNPACK_USE_SYSTEM_LIBS)
            FIND_PACKAGE(benchmark REQUIRED)
        ELSE()
            IF(NOT DEFINED GOOGLEBENCHMARK_SOURCE_DIR)
                MESSAGE(STATUS "Downloading Google Benchmark to ${CMAKE_BINARY_DIR}/googlebenchmark-source (define GOOGLEBENCHMARK_SOURCE_DIR to avoid it)")
                CONFIGURE_FILE(cmake/DownloadGoogleBenchmark.cmake "${CMAKE_BINARY_DIR}/googlebenchmark-download/CMakeLists.txt")
                EXECUTE_PROCESS(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
                                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/googlebenchmark-download")
                EXECUTE_PROCESS(COMMAND "${CMAKE_COMMAND}" --build .
                                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/googlebenchmark-download")
                SET(GOOGLEBENCHMARK_SOURCE_DIR "${CMAKE_BINARY_DIR}/googlebenchmark-source" CACHE STRING "Google Benchmark source directory")
            ENDIF()
            SET(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "")
            ADD_SUBDIRECTORY(
                    "${GOOGLEBENCHMARK_SOURCE_DIR}"
                    "${CONFU_DEPENDENCIES_BINARY_DIR}/googlebenchmark")
        ENDIF()
    ENDIF()

    ADD_LIBRARY(bench-utils STATIC bench/utils.cc)
    TARGET_INCLUDE_DIRECTORIES(bench-utils PRIVATE .)
    TARGET_INCLUDE_DIRECTORIES(bench-utils PUBLIC include src)
    TARGET_LINK_LIBRARIES(bench-utils PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(bench-utils PRIVATE hardware-config)
    IF(XNNPACK_BUILD_LIBRARY)
        TARGET_LINK_LIBRARIES(bench-utils PRIVATE logging xnn-memory)
    ENDIF()

    # ---[ Build accuracy microbenchmarks
    ADD_EXECUTABLE(f16-exp-ulp-eval eval/f16-exp-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-exp-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f16-exp-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-exp-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-expminus-ulp-eval eval/f16-expminus-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-expminus-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f16-expminus-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-expminus-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-expm1minus-ulp-eval eval/f16-expm1minus-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-expm1minus-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f16-expm1minus-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-expm1minus-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-sigmoid-ulp-eval eval/f16-sigmoid-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-sigmoid-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f16-sigmoid-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-sigmoid-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-sqrt-ulp-eval eval/f16-sqrt-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-sqrt-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f16-sqrt-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-sqrt-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-tanh-ulp-eval eval/f16-tanh-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-tanh-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f16-tanh-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-tanh-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-exp-ulp-eval eval/f32-exp-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-exp-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-exp-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-exp-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-expminus-ulp-eval eval/f32-expminus-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-expminus-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-expminus-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-expminus-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-expm1minus-ulp-eval eval/f32-expm1minus-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-expm1minus-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-expm1minus-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-expm1minus-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-extexp-ulp-eval eval/f32-extexp-ulp.cc)
    SET_TARGET_PROPERTIES(f32-extexp-ulp-eval PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(f32-extexp-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-extexp-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-extexp-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-sigmoid-ulp-eval eval/f32-sigmoid-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-sigmoid-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-sigmoid-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-sigmoid-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-sqrt-ulp-eval eval/f32-sqrt-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-sqrt-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-sqrt-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-sqrt-ulp-eval PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f32-tanh-ulp-eval eval/f32-tanh-ulp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-tanh-ulp-eval PRIVATE . src)
    TARGET_LINK_LIBRARIES(f32-tanh-ulp-eval PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-tanh-ulp-eval PRIVATE bench-utils microkernels-all)

    # ---[ Build accuracy tests
    ADD_LIBRARY(math-evaluation-tester STATIC eval/math-evaluation-tester.cc)
    TARGET_INCLUDE_DIRECTORIES(math-evaluation-tester PRIVATE . include src)
    TARGET_LINK_LIBRARIES(math-evaluation-tester PRIVATE fp16 pthreadpool::pthreadpool GTest::gtest)

    ADD_EXECUTABLE(f16-sqrt-eval eval/f16-sqrt.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-sqrt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f16-sqrt-eval PRIVATE fp16 pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f16-sqrt-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f16-tanh-eval eval/f16-tanh.cc)
    SET_TARGET_PROPERTIES(f16-tanh-eval PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(f16-tanh-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f16-tanh-eval PRIVATE fp16 pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f16-tanh-eval PRIVATE hardware-config logging math-evaluation-tester microkernels-all)

    ADD_EXECUTABLE(f16-f32-cvt-eval eval/f16-f32-cvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-f32-cvt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f16-f32-cvt-eval PRIVATE fp16 pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f16-f32-cvt-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-f16-cvt-eval eval/f32-f16-cvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-f16-cvt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-f16-cvt-eval PRIVATE fp16 pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-f16-cvt-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-qs8-cvt-eval eval/f32-qs8-cvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-qs8-cvt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-qs8-cvt-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-qs8-cvt-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-qu8-cvt-eval eval/f32-qu8-cvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-qu8-cvt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-qu8-cvt-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-qu8-cvt-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-exp-eval eval/f32-exp.cc)
    SET_TARGET_PROPERTIES(f32-exp-eval PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(f32-exp-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-exp-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-exp-eval PRIVATE hardware-config logging math-evaluation-tester microkernels-all)

    ADD_EXECUTABLE(f32-expm1minus-eval eval/f32-expm1minus.cc)
    SET_TARGET_PROPERTIES(f32-expm1minus-eval PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(f32-expm1minus-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-expm1minus-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-expm1minus-eval PRIVATE hardware-config logging math-evaluation-tester microkernels-all)

    ADD_EXECUTABLE(f32-expminus-eval eval/f32-expminus.cc)
    SET_TARGET_PROPERTIES(f32-expminus-eval PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(f32-expminus-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-expminus-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-expminus-eval PRIVATE hardware-config logging math-evaluation-tester microkernels-all)

    ADD_EXECUTABLE(f32-roundne-eval eval/f32-roundne.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-roundne-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-roundne-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-roundne-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-roundd-eval eval/f32-roundd.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-roundd-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-roundd-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-roundd-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-roundu-eval eval/f32-roundu.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-roundu-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-roundu-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-roundu-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-roundz-eval eval/f32-roundz.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-roundz-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-roundz-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-roundz-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(f32-tanh-eval eval/f32-tanh.cc)
    SET_TARGET_PROPERTIES(f32-tanh-eval PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(f32-tanh-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(f32-tanh-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(f32-tanh-eval PRIVATE hardware-config logging math-evaluation-tester microkernels-all)

    ADD_EXECUTABLE(u32-sqrt-eval eval/u32-sqrt.cc)
    TARGET_INCLUDE_DIRECTORIES(u32-sqrt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(u32-sqrt-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(u32-sqrt-eval PRIVATE hardware-config logging microkernels-all)

    ADD_EXECUTABLE(u64-sqrt-eval eval/u64-sqrt.cc)
    TARGET_INCLUDE_DIRECTORIES(u64-sqrt-eval PRIVATE include src)
    TARGET_LINK_LIBRARIES(u64-sqrt-eval PRIVATE pthreadpool::pthreadpool GTest::gtest GTest::gtest_main)
    TARGET_LINK_LIBRARIES(u64-sqrt-eval PRIVATE hardware-config logging microkernels-all)

    IF(XNNPACK_BUILD_LIBRARY)
        # ---[ Build end-to-end microbenchmarks
        ADD_LIBRARY(bench-models STATIC
                    models/fp16-mobilenet-v1.cc
                    models/fp16-mobilenet-v2.cc
                    models/fp16-mobilenet-v3-large.cc
                    models/fp16-mobilenet-v3-small.cc
                    models/fp16-sparse-mobilenet-v1.cc
                    models/fp16-sparse-mobilenet-v2.cc
                    models/fp16-sparse-mobilenet-v3-large.cc
                    models/fp16-sparse-mobilenet-v3-small.cc
                    models/fp32-mobilenet-v1.cc
                    models/fp32-mobilenet-v1-jit.cc
                    models/fp32-mobilenet-v2.cc
                    models/fp32-mobilenet-v2-jit.cc
                    models/fp32-mobilenet-v3-large.cc
                    models/fp32-mobilenet-v3-large-jit.cc
                    models/fp32-mobilenet-v3-small.cc
                    models/fp32-mobilenet-v3-small-fused.cc
                    models/fp32-mobilenet-v3-small-jit.cc
                    models/fp32-sparse-mobilenet-v1.cc
                    models/fp32-sparse-mobilenet-v2.cc
                    models/fp32-sparse-mobilenet-v3-large.cc
                    models/fp32-sparse-mobilenet-v3-small.cc
                    models/qs8-qc8w-mobilenet-v1.cc
                    models/qs8-qc8w-mobilenet-v2.cc
                    models/qs8-mobilenet-v1.cc
                    models/qs8-mobilenet-v2.cc
                    models/qu8-mobilenet-v1.cc
                    models/qu8-mobilenet-v2.cc
                    models/qu8-mobilenet-v3-large.cc
                    models/qu8-mobilenet-v3-small.cc)
        SET_TARGET_PROPERTIES(bench-models PROPERTIES CXX_EXTENSIONS YES)
        TARGET_INCLUDE_DIRECTORIES(bench-models PRIVATE .)
        TARGET_LINK_LIBRARIES(bench-models PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(bench-models PRIVATE tfl-XNNPACK bench-utils)

        ADD_EXECUTABLE(end2end-bench bench/end2end.cc)
        TARGET_INCLUDE_DIRECTORIES(end2end-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(end2end-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-models bench-utils)

        ADD_EXECUTABLE(f16-gemm-e2e-bench bench/f16-gemm-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(f16-gemm-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(f16-gemm-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(f16-gemm-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(f16-dwconv-e2e-bench bench/f16-dwconv-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(f16-dwconv-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(f16-dwconv-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(f16-dwconv-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(f32-dwconv-e2e-bench bench/f32-dwconv-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(f32-dwconv-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(f32-dwconv-e2e-bench PRIVATE benchmark::benchmark)
        TARGET_LINK_LIBRARIES(f32-dwconv-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(f32-gemm-e2e-bench bench/f32-gemm-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(f32-gemm-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(f32-gemm-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(f32-gemm-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(qs8-dwconv-e2e-bench bench/qs8-dwconv-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(qs8-dwconv-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(qs8-dwconv-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(qs8-dwconv-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(qs8-gemm-e2e-bench bench/qs8-gemm-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(qs8-gemm-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(qs8-gemm-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(qs8-gemm-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(qu8-gemm-e2e-bench bench/qu8-gemm-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(qu8-gemm-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(qu8-gemm-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(qu8-gemm-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        ADD_EXECUTABLE(qu8-dwconv-e2e-bench bench/qu8-dwconv-e2e.cc)
        TARGET_INCLUDE_DIRECTORIES(qu8-dwconv-e2e-bench PRIVATE . src)
        TARGET_LINK_LIBRARIES(qu8-dwconv-e2e-bench PRIVATE fp16 benchmark::benchmark)
        TARGET_LINK_LIBRARIES(qu8-dwconv-e2e-bench PRIVATE tfl-XNNPACK bench-models bench-utils hardware-config logging microkernels-all microparams-init)

        # ---[ Build operator-level microbenchmarks
        ADD_EXECUTABLE(abs-bench bench/abs.cc)
        TARGET_INCLUDE_DIRECTORIES(abs-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(abs-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(average-pooling-bench bench/average-pooling.cc)
        TARGET_INCLUDE_DIRECTORIES(average-pooling-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(average-pooling-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(bankers-rounding-bench bench/bankers-rounding.cc)
        TARGET_INCLUDE_DIRECTORIES(bankers-rounding-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(bankers-rounding-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(ceiling-bench bench/ceiling.cc)
        TARGET_INCLUDE_DIRECTORIES(ceiling-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(ceiling-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(channel-shuffle-bench bench/channel-shuffle.cc)
        TARGET_INCLUDE_DIRECTORIES(channel-shuffle-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(channel-shuffle-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(convert-bench bench/convert.cc)
        TARGET_INCLUDE_DIRECTORIES(convert-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(convert-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(convolution-bench bench/convolution.cc)
        TARGET_INCLUDE_DIRECTORIES(convolution-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(convolution-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(deconvolution-bench bench/deconvolution.cc)
        TARGET_INCLUDE_DIRECTORIES(deconvolution-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(deconvolution-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(elu-bench bench/elu.cc)
        TARGET_INCLUDE_DIRECTORIES(elu-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(elu-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(floor-bench bench/floor.cc)
        TARGET_INCLUDE_DIRECTORIES(floor-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(floor-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(global-average-pooling-bench bench/global-average-pooling.cc)
        TARGET_INCLUDE_DIRECTORIES(global-average-pooling-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(global-average-pooling-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(hardswish-bench bench/hardswish.cc)
        TARGET_INCLUDE_DIRECTORIES(hardswish-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(hardswish-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(leaky-relu-bench bench/leaky-relu.cc)
        TARGET_INCLUDE_DIRECTORIES(leaky-relu-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(leaky-relu-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(max-pooling-bench bench/max-pooling.cc)
        TARGET_INCLUDE_DIRECTORIES(max-pooling-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(max-pooling-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(negate-bench bench/negate.cc)
        TARGET_INCLUDE_DIRECTORIES(negate-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(negate-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(prelu-bench bench/prelu.cc)
        TARGET_INCLUDE_DIRECTORIES(prelu-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(prelu-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(reciprocal-square-root-bench bench/reciprocal-square-root.cc)
        TARGET_INCLUDE_DIRECTORIES(reciprocal-square-root-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(reciprocal-square-root-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(sigmoid-bench bench/sigmoid.cc)
        TARGET_INCLUDE_DIRECTORIES(sigmoid-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(sigmoid-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(softmax-bench bench/softmax.cc)
        TARGET_INCLUDE_DIRECTORIES(softmax-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(softmax-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(square-bench bench/square.cc)
        TARGET_INCLUDE_DIRECTORIES(square-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(square-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(square-root-bench bench/square-root.cc)
        TARGET_INCLUDE_DIRECTORIES(square-root-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(square-root-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(truncation-bench bench/truncation.cc)
        TARGET_INCLUDE_DIRECTORIES(truncation-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(truncation-bench PRIVATE tfl-XNNPACK benchmark::benchmark bench-utils)

        ADD_EXECUTABLE(tanh-bench bench/tanh.cc)
        TARGET_INCLUDE_DIRECTORIES(tanh-bench PRIVATE .)
        TARGET_LINK_LIBRARIES(tanh-bench PRIVATE tfl-XNNPACK fp16 benchmark::benchmark bench-utils)
    ENDIF()

    # ---[ Build microkernel-level microbenchmarks
    ADD_EXECUTABLE(bf16-gemm-bench bench/bf16-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(bf16-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(bf16-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(bf16-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-conv-hwc2chw-bench bench/f16-conv-hwc2chw.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-conv-hwc2chw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-conv-hwc2chw-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-conv-hwc2chw-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-dwconv-bench bench/f16-dwconv.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-dwconv-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-dwconv-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-dwconv-bench PRIVATE bench-utils indirection hardware-config logging microkernel-utils microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-dwconv2d-chw-bench bench/f16-dwconv2d-chw.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-dwconv2d-chw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-dwconv2d-chw-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-dwconv2d-chw-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-gavgpool-cw-bench bench/f16-gavgpool-cw.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-gavgpool-cw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-gavgpool-cw-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-gavgpool-cw-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-f32acc-gemm-bench bench/f16-f32acc-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-f32acc-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-f32acc-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-f32acc-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-gemm-bench bench/f16-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-gemm-bench PRIVATE bench-utils hardware-config jit logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-f32acc-igemm-bench bench/f16-f32acc-igemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-f32acc-igemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-f32acc-igemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-f32acc-igemm-bench PRIVATE bench-utils indirection hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-igemm-bench bench/f16-igemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-igemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-igemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-igemm-bench PRIVATE bench-utils hardware-config indirection jit logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f16-raddstoreexpminusmax-bench bench/f16-raddstoreexpminusmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-raddstoreexpminusmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-raddstoreexpminusmax-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-raddstoreexpminusmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-rsum-bench bench/f16-rsum.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-rsum-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-rsum-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-rsum-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-f32acc-rsum-bench bench/f16-f32acc-rsum.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-f32acc-rsum-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-f32acc-rsum-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-f32acc-rsum-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-rmax-bench bench/f16-rmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-rmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-rmax-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-rmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-rminmax-bench bench/f16-rminmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-rminmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-rminmax-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-rminmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-rmin-bench bench/f16-rmin.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-rmin-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-rmin-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-rmin-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-spmm-bench bench/f16-spmm.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-spmm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-spmm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-spmm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vabs-bench bench/f16-vabs.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vabs-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vabs-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vabs-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vclamp-bench bench/f16-vclamp.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vclamp-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vclamp-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vclamp-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-velu-bench bench/f16-velu.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-velu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-velu-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-velu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vhswish-bench bench/f16-vhswish.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vhswish-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vhswish-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vhswish-bench PRIVATE bench-utils microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vlrelu-bench bench/f16-vlrelu.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vlrelu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vlrelu-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vlrelu-bench PRIVATE bench-utils microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vneg-bench bench/f16-vneg.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vneg-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vneg-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vneg-bench PRIVATE bench-utils microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vrndd-bench bench/f16-vrndd.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vrndd-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vrndd-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vrndd-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vrndne-bench bench/f16-vrndne.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vrndne-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vrndne-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vrndne-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vrndu-bench bench/f16-vrndu.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vrndu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vrndu-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vrndu-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vrndz-bench bench/f16-vrndz.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vrndz-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vrndz-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vrndz-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vrsqrt-bench bench/f16-vrsqrt.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vrsqrt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vrsqrt-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vrsqrt-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vsigmoid-bench bench/f16-vsigmoid.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vsigmoid-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vsigmoid-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vsigmoid-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-vsqr-bench bench/f16-vsqr.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vsqr-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vsqr-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vsqr-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vsqrt-bench bench/f16-vsqrt.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vsqrt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vsqrt-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vsqrt-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(f16-vtanh-bench bench/f16-vtanh.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-vtanh-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-vtanh-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-vtanh-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f16-f32-vcvt-bench bench/f16-f32-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f16-f32-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f16-f32-vcvt-bench PRIVATE fp16 benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f16-f32-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-bgemm-bench bench/f32-bgemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-bgemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-bgemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-bgemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-conv-hwc-bench bench/f32-conv-hwc.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-conv-hwc-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-conv-hwc-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-conv-hwc-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-conv-hwc2chw-bench bench/f32-conv-hwc2chw.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-conv-hwc2chw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-conv-hwc2chw-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-conv-hwc2chw-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-dwconv-bench bench/f32-dwconv.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-dwconv-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-dwconv-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-dwconv-bench PRIVATE bench-utils indirection hardware-config logging microkernel-utils microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-dwconv2d-chw-bench bench/f32-dwconv2d-chw.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-dwconv2d-chw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-dwconv2d-chw-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-dwconv2d-chw-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-f16-vcvt-bench bench/f32-f16-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-f16-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-f16-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-f16-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-gavgpool-cw-bench bench/f32-gavgpool-cw.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-gavgpool-cw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-gavgpool-cw-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-gavgpool-cw-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-gemm-bench bench/f32-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-gemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-gemm-bench PRIVATE jit bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-gemm-minmax-bench bench/f32-gemm-minmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-gemm-minmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-gemm-minmax-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-gemm-minmax-bench PRIVATE jit bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-gemm-goi-minmax-bench bench/f32-gemm-goi-minmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-gemm-goi-minmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-gemm-goi-minmax-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-gemm-goi-minmax-bench PRIVATE jit bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(qd8-f16-qc4w-gemm-bench bench/qd8-f16-qc4w-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(qd8-f16-qc4w-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qd8-f16-qc4w-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qd8-f16-qc4w-gemm-bench PRIVATE jit bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-qc4w-gemm-bench bench/f32-qc4w-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-qc4w-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-qc4w-gemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-qc4w-gemm-bench PRIVATE jit bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-qc8w-gemm-bench bench/f32-qc8w-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-qc8w-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-qc8w-gemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-qc8w-gemm-bench PRIVATE jit bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-igemm-bench bench/f32-igemm.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-igemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-igemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-igemm-bench PRIVATE jit bench-utils indirection hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-im2col-gemm-bench bench/f32-im2col-gemm.cc src/im2col.c)
    TARGET_INCLUDE_DIRECTORIES(f32-im2col-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-im2col-gemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-im2col-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(f32-qs8-vcvt-bench bench/f32-qs8-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-qs8-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-qs8-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-qs8-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-qu8-vcvt-bench bench/f32-qu8-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-qu8-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-qu8-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-qu8-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-raddstoreexpminusmax-bench bench/f32-raddstoreexpminusmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-raddstoreexpminusmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-raddstoreexpminusmax-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-raddstoreexpminusmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-raddexpminusmax-bench bench/f32-raddexpminusmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-raddexpminusmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-raddexpminusmax-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-raddexpminusmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-raddextexp-bench bench/f32-raddextexp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-raddextexp-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-raddextexp-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-raddextexp-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vscaleexpminusmax-bench bench/f32-vscaleexpminusmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vscaleexpminusmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vscaleexpminusmax-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vscaleexpminusmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vscaleextexp-bench bench/f32-vscaleextexp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vscaleextexp-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vscaleextexp-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vscaleextexp-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-rmax-bench bench/f32-rmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-rmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-rmax-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-rmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-rminmax-bench bench/f32-rminmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-rminmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-rminmax-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-rminmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-rmin-bench bench/f32-rmin.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-rmin-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-rmin-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-rmin-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-round-bench bench/f32-round.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-round-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-round-bench PRIVATE benchmark::benchmark ${libcpuinfo_LIBRARIES} pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-round-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-rsum-bench bench/f32-rsum.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-rsum-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-rsum-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-rsum-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-spmm-bench bench/f32-spmm.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-spmm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-spmm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-spmm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-softmax-bench bench/f32-softmax.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-softmax-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-softmax-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-softmax-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vcmul-bench bench/f32-vcmul.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vcmul-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vcmul-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vcmul-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qd8-f16-qc8w-gemm-bench bench/qd8-f16-qc8w-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(qd8-f16-qc8w-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qd8-f16-qc8w-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool packing)
    TARGET_LINK_LIBRARIES(qd8-f16-qc8w-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qd8-f32-qc8w-gemm-bench bench/qd8-f32-qc8w-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(qd8-f32-qc8w-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qd8-f32-qc8w-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool packing)
    TARGET_LINK_LIBRARIES(qd8-f32-qc8w-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qd8-f32-qc4w-gemm-bench bench/qd8-f32-qc4w-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(qd8-f32-qc4w-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qd8-f32-qc4w-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool packing)
    TARGET_LINK_LIBRARIES(qd8-f32-qc4w-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vabs-bench bench/f32-vabs.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vabs-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vabs-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vabs-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-velu-bench bench/f32-velu.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-velu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-velu-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-velu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vhswish-bench bench/f32-vhswish.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vhswish-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vhswish-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vhswish-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vlrelu-bench bench/f32-vlrelu.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vlrelu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vlrelu-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vlrelu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vneg-bench bench/f32-vneg.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vneg-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vneg-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vneg-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vrelu-bench bench/f32-vrelu.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vrelu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vrelu-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vrelu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vrndd-bench bench/f32-vrndd.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vrndd-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vrndd-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vrndd-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vrndne-bench bench/f32-vrndne.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vrndne-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vrndne-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vrndne-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vrndu-bench bench/f32-vrndu.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vrndu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vrndu-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vrndu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vrndz-bench bench/f32-vrndz.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vrndz-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vrndz-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vrndz-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vsigmoid-bench bench/f32-vsigmoid.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vsigmoid-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vsigmoid-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vsigmoid-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vsqr-bench bench/f32-vsqr.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vsqr-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vsqr-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vsqr-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vsqrt-bench bench/f32-vsqrt.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vsqrt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vsqrt-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vsqrt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vclamp-bench bench/f32-vclamp.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vclamp-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vclamp-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vclamp-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(f32-vtanh-bench bench/f32-vtanh.cc)
    TARGET_INCLUDE_DIRECTORIES(f32-vtanh-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(f32-vtanh-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(f32-vtanh-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-dwconv-bench bench/qs8-dwconv.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-dwconv-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-dwconv-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-dwconv-bench PRIVATE bench-utils indirection hardware-config logging microkernels-all microkernel-utils microparams-init packing)

    ADD_EXECUTABLE(qs8-f16-vcvt-bench bench/qs8-f16-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-f16-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-f16-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-f16-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-f32-vcvt-bench bench/qs8-f32-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-f32-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-f32-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-f32-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-gemm-bench bench/qs8-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-gemm-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool jit microparams-init)
    TARGET_LINK_LIBRARIES(qs8-gemm-bench PRIVATE bench-utils jit hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(qs8-qc8w-gemm-fp32-bench bench/qs8-qc8w-gemm-fp32.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-qc8w-gemm-fp32-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-qc8w-gemm-fp32-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool jit microparams-init)
    TARGET_LINK_LIBRARIES(qs8-qc8w-gemm-fp32-bench PRIVATE bench-utils jit hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(qu8-gemm-fp32-bench bench/qu8-gemm-fp32.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-gemm-fp32-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-gemm-fp32-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool jit microparams-init)
    TARGET_LINK_LIBRARIES(qu8-gemm-fp32-bench PRIVATE bench-utils jit hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(qu8-gemm-rndnu-bench bench/qu8-gemm-rndnu.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-gemm-rndnu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-gemm-rndnu-bench PRIVATE benchmark::benchmark fp16 pthreadpool::pthreadpool jit microparams-init)
    TARGET_LINK_LIBRARIES(qu8-gemm-rndnu-bench PRIVATE bench-utils jit hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(qs8-requantization-bench bench/qs8-requantization.cc)
    SET_TARGET_PROPERTIES(qs8-requantization-bench PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(qs8-requantization-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-requantization-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-requantization-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(qs8-vadd-bench bench/qs8-vadd.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vadd-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vadd-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vadd-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-vaddc-bench bench/qs8-vaddc.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vaddc-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vaddc-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vaddc-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-vcvt-bench bench/qs8-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs16-qs8-vcvt-bench bench/qs16-qs8-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(qs16-qs8-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs16-qs8-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs16-qs8-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-vhswish-bench bench/qs8-vhswish.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vhswish-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vhswish-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vhswish-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-vlrelu-bench bench/qs8-vlrelu.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vlrelu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vlrelu-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vlrelu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-vmul-bench bench/qs8-vmul.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vmul-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vmul-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vmul-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qs8-vmulc-bench bench/qs8-vmulc.cc)
    TARGET_INCLUDE_DIRECTORIES(qs8-vmulc-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qs8-vmulc-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qs8-vmulc-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-f32-vcvt-bench bench/qu8-f32-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-f32-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-f32-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-f32-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-gemm-bench bench/qu8-gemm.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-gemm-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-gemm-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-gemm-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init packing)

    ADD_EXECUTABLE(qu8-requantization-bench bench/qu8-requantization.cc)
    SET_TARGET_PROPERTIES(qu8-requantization-bench PROPERTIES CXX_EXTENSIONS YES)
    TARGET_INCLUDE_DIRECTORIES(qu8-requantization-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-requantization-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-requantization-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(qu8-vadd-bench bench/qu8-vadd.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vadd-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vadd-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vadd-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-vaddc-bench bench/qu8-vaddc.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vaddc-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vaddc-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vaddc-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-vcvt-bench bench/qu8-vcvt.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vcvt-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vcvt-bench PRIVATE fp16 benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vcvt-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-vhswish-bench bench/qu8-vhswish.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vhswish-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vhswish-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vhswish-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-vlrelu-bench bench/qu8-vlrelu.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vlrelu-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vlrelu-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vlrelu-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-vmul-bench bench/qu8-vmul.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vmul-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vmul-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vmul-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(qu8-vmulc-bench bench/qu8-vmulc.cc)
    TARGET_INCLUDE_DIRECTORIES(qu8-vmulc-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(qu8-vmulc-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(qu8-vmulc-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(s16-rmaxabs-bench bench/s16-rmaxabs.cc)
    TARGET_INCLUDE_DIRECTORIES(s16-rmaxabs-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(s16-rmaxabs-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(s16-rmaxabs-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(s16-window-bench bench/s16-window.cc)
    TARGET_INCLUDE_DIRECTORIES(s16-window-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(s16-window-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(s16-window-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(u32-filterbank-accumulate-bench bench/u32-filterbank-accumulate.cc)
    TARGET_INCLUDE_DIRECTORIES(u32-filterbank-accumulate-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(u32-filterbank-accumulate-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(u32-filterbank-accumulate-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(u32-filterbank-subtract-bench bench/u32-filterbank-subtract.cc)
    TARGET_INCLUDE_DIRECTORIES(u32-filterbank-subtract-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(u32-filterbank-subtract-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(u32-filterbank-subtract-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(u32-vlog-bench bench/u32-vlog.cc)
    TARGET_INCLUDE_DIRECTORIES(u32-vlog-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(u32-vlog-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(u32-vlog-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(u64-u32-vsqrtshift-bench bench/u64-u32-vsqrtshift.cc)
    TARGET_INCLUDE_DIRECTORIES(u64-u32-vsqrtshift-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(u64-u32-vsqrtshift-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(u64-u32-vsqrtshift-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(i16-vlshift-bench bench/i16-vlshift.cc)
    TARGET_INCLUDE_DIRECTORIES(i16-vlshift-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(i16-vlshift-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(i16-vlshift-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(cs16-vsquareabs-bench bench/cs16-vsquareabs.cc)
    TARGET_INCLUDE_DIRECTORIES(cs16-vsquareabs-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(cs16-vsquareabs-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(cs16-vsquareabs-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(cs16-bfly4-bench bench/cs16-bfly4.cc)
    TARGET_INCLUDE_DIRECTORIES(cs16-bfly4-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(cs16-bfly4-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(cs16-bfly4-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(cs16-fftr-bench bench/cs16-fftr.cc)
    TARGET_INCLUDE_DIRECTORIES(cs16-fftr-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(cs16-fftr-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(cs16-fftr-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(xx-transposev-bench bench/xx-transposev.cc)
    TARGET_INCLUDE_DIRECTORIES(xx-transposev-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(xx-transposev-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(xx-transposev-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(x8-lut-bench bench/x8-lut.cc)
    TARGET_INCLUDE_DIRECTORIES(x8-lut-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x8-lut-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x8-lut-bench PRIVATE bench-utils microkernels-all)

    ADD_EXECUTABLE(x8-transpose-bench bench/x32-transpose.cc)
    TARGET_INCLUDE_DIRECTORIES(x8-transpose-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x8-transpose-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x8-transpose-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(x16-transpose-bench bench/x16-transpose.cc)
    TARGET_INCLUDE_DIRECTORIES(x16-transpose-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x16-transpose-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x16-transpose-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(x24-transpose-bench bench/x16-transpose.cc)
    TARGET_INCLUDE_DIRECTORIES(x24-transpose-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x24-transpose-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x24-transpose-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(x8-packw-bench bench/x8-packw.cc)
    TARGET_INCLUDE_DIRECTORIES(x8-packw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x8-packw-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x8-packw-bench PRIVATE bench-utils hardware-config logging microkernels-all packing)

    ADD_EXECUTABLE(x16-packw-bench bench/x16-packw.cc)
    TARGET_INCLUDE_DIRECTORIES(x16-packw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x16-packw-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x16-packw-bench PRIVATE bench-utils hardware-config logging microkernels-all packing)

    ADD_EXECUTABLE(x32-packw-bench bench/x32-packw.cc)
    TARGET_INCLUDE_DIRECTORIES(x32-packw-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x32-packw-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x32-packw-bench PRIVATE bench-utils hardware-config logging microkernels-all packing)

    ADD_EXECUTABLE(x32-transpose-bench bench/x32-transpose.cc)
    TARGET_INCLUDE_DIRECTORIES(x32-transpose-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x32-transpose-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x32-transpose-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    ADD_EXECUTABLE(x64-transpose-bench bench/x64-transpose.cc)
    TARGET_INCLUDE_DIRECTORIES(x64-transpose-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(x64-transpose-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(x64-transpose-bench PRIVATE bench-utils hardware-config logging microkernels-all microparams-init)

    # ---[ Other microbenchmarks
    ADD_EXECUTABLE(jit-bench bench/jit.cc)
    TARGET_INCLUDE_DIRECTORIES(jit-bench PRIVATE . include src)
    TARGET_LINK_LIBRARIES(jit-bench PRIVATE benchmark::benchmark pthreadpool::pthreadpool)
    TARGET_LINK_LIBRARIES(jit-bench PRIVATE jit logging xnn-memory microkernels-all)
ENDIF()
