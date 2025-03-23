cmake_minimum_required(VERSION 3.8)

project("launcher_assistant")

add_executable(launcher "src/launcher_assistant.cpp" "src/launcher_assistant.h")

set_target_properties(launcher PROPERTIES OUTPUT_NAME "launcher_assistant")

if (CMAKE_VERSION VERSION_GREATER 3.12)
    set_property(TARGET launcher PROPERTY CXX_STANDARD 20)
endif ()