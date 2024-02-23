cmake_minimum_required(VERSION 3.15)
project(cpp-calc CXX)
set(THREADS_PREFER_PTHREAD_FLAG ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Threads REQUIRED)
find_package(Boost REQUIRED)
find_package(asio REQUIRED)

include_directories(${Boost_INCLUDE_DIRS})
include_directories("include")
set(EXECUTABLE_OUTPUT_PATH "bin")
add_executable(${PROJECT_NAME} src/calc.cpp)

# Use the global target
target_link_libraries(${PROJECT_NAME} asio::asio Threads::Threads)
add_custom_target(run
    COMMAND bin/cpp-calc
)
