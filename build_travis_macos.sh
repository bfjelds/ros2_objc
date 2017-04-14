#!/bin/sh

set -e

mkdir -p ~/ros2_objc_ws/src
cd ~/ros2_objc_ws
wget https://raw.githubusercontent.com/esteve/ros2_objc/master/ros2_objc_macos.repos
vcs import ~/ros2_objc_ws/src < ros2_objc_macos.repos
cd ~/ros2_objc_ws/src/ros2/rosidl_typesupport
patch -p1 < ../../ros2_objc/ros2_objc/rosidl_typesupport_ros2_objc.patch
cd ~/ros2_objc_ws
src/ament/ament_tools/scripts/ament.py build --use-xcode --symlink-install --isolated
