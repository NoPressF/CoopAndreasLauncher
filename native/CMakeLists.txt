cmake_minimum_required (VERSION 3.8)

project ("launcher")

add_executable (launcher "launcher.cpp" "launcher.h")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET launcher PROPERTY CXX_STANDARD 20)
endif()