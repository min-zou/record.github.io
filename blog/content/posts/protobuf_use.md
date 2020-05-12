---
author:
  name: "Xiaox Liu"
title: "Protobuf_use"
date: 2020-05-12T08:41:11+08:00
draft: false
toc: false
images:
tags:
  - protobuf
  - data serial
---

### proto生成头文件路径修改
多proto文件c++生成的过程中，头文件路径容易出错，同时cmake中给出的--cpp-out生成c++文件的路径配置选项所生成的头文件和源文件是在同一目录，这造成如果不是相对路径的话就必须使用最上层有包名的路径或者同一文件夹下直接不包含路径。
当前使用的方法即是生成文件至同一文件夹下从而直接包含头文件。
CMake配置如下：
```
file(GLOB_RECURSE ALL_PROTOS "include/proto/*.proto")
# TODO(cschuet): Move proto compilation to separate function.
set(ALL_PROTO_SRCS)
set(ALL_PROTO_HDRS)
foreach(ABS_FIL ${ALL_PROTOS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR} ${ABS_FIL})
  # file(RELATIVE_PATH variable directory file)
  # RELATIVE_PAT推断出指定文件相对于特定目录的路径。
  get_filename_component(DIR ${REL_FIL} DIRECTORY)
  get_filename_component(FIL_WE ${REL_FIL} NAME_WE)

  list(APPEND ALL_PROTO_SRCS "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc")
  list(APPEND ALL_PROTO_HDRS "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h")
  #实际头文件的路径

  add_custom_command(
    OUTPUT "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc"
           "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h"
    COMMAND  mkdir ARGS -p ${PROJECT_BINARY_DIR}/${DIR}
    #路径可能不存在，因此需要在proto生成前预先建立

    COMMAND  ${PROTOBUF_PROTOC_EXECUTABLE}
    ARGS 
    -I  ${PROJECT_SOURCE_DIR}/${DIR} #源文件中对应头文件的路径为此路径与绝对路径的差值，此处设置可以使得头文件路径直接为文件名
    --cpp_out  ${PROJECT_BINARY_DIR}/${DIR} #源文件和头文件的输出路径
    ${ABS_FIL} #绝对路径
    DEPENDS ${ABS_FIL}
    COMMENT "Running C++ protocol buffer compiler on ${ABS_FIL} ,${REL_FIL}  ,${DIR}"
    VERBATIM
  )
endforeach()
set_source_files_properties(${ALL_PROTO_SRCS} ${ALL_PROTO_HDRS} PROPERTIES GENERATED TRUE)
```
以上。


