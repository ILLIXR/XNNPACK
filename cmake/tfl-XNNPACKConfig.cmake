# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.8)
   message(FATAL_ERROR "CMake >= 2.8.0 required")
endif()
if(CMAKE_VERSION VERSION_LESS "2.8.3")
   message(FATAL_ERROR "CMake >= 2.8.3 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.8.3...3.26)

#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

include(FindPackageHandleStandardArgs)
find_path(xnn_ROOT_DIR NAMES include/tfl-xnnpack.h)
set(tfl-XNNPACK_ROOT_DIR ${xnn_ROOT_DIR})
find_library(xnn_lib NAMES tfl-XNNPACK PATHS ${tfl-XNNPACK_ROOT_DIR}/lib ${tfl-XNNPACK_LIB_PATH} @CMAKE_INSTALL_PREFIX@/lib)
set(tfl-XNNPACK_LIBRARIES ${xnn_lib})
find_path(include_dirs NAMES tfl-xnnpack.h PATHS ${tfl-XNNPACK_ROOT_DIR}/include @CMAKE_INSTALL_PREFIX@/include)
set(tfl-XNNPACK_INCLUDE_DIRS ${include_dirs})
find_package_handle_standard_args(tfl-XNNPACK DEFAULT_MSG tfl-XNNPACK_LIBRARIES tfl-XNNPACK_INCLUDE_DIRS)

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
