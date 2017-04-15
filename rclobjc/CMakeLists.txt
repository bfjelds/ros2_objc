cmake_minimum_required(VERSION 3.5)

project(rclobjc C)

find_package(ament_cmake REQUIRED)
find_package(ament_cmake_ros REQUIRED)
find_package(rcl REQUIRED)
find_package(rcl_interfaces REQUIRED)
find_package(rmw REQUIRED)
find_package(rmw_implementation REQUIRED)
find_package(rmw_implementation_cmake REQUIRED)
find_package(rosidl_generator_c REQUIRED)

if(NOT WIN32)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra")
endif()

# Only build the library if a C typesupport exists
get_rmw_typesupport(typesupport_impls "rmw_implementation" LANGUAGE "c")
if(typesupport_impls STREQUAL "")
  message(STATUS "Skipping rclobjc because no C typesupport library was found.")
  return()
endif()

include_directories(include)

set(${PROJECT_NAME}_SRCS
  "src/ROSClient.m"
  "src/ROSNode.m"
  "src/ROSPublisher.m"
  "src/ROSRCLObjC.m"
  "src/ROSService.m"
  "src/ROSSubscription.m"
)

ament_export_dependencies(ament_cmake)
ament_export_dependencies(rcl)
ament_export_dependencies(rosidl_generator_c)

ament_export_include_directories(include)

ament_export_libraries(${PROJECT_NAME})

add_library(${PROJECT_NAME}
  ${${PROJECT_NAME}_SRCS}
)
target_link_libraries(${PROJECT_NAME} "-framework Foundation")

ament_target_dependencies(${PROJECT_NAME}
  "rcl"
)

install(
  TARGETS ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()

install(
  DIRECTORY include/
  DESTINATION include
)
