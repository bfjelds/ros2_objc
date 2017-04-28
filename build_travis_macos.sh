#!/bin/bash

set -euf -o pipefail

git checkout $TRAVIS_BRANCH

mkdir -p ~/ros2_objc_ws/src
cd ~/ros2_objc_ws
vcs import ~/ros2_objc_ws/src < $TRAVIS_BUILD_DIR/ros2_objc_macos_travis.repos
cd ~/ros2_objc_ws/src/ros2_objc/ros2_objc
git checkout $TRAVIS_BRANCH
cd ~/ros2_objc_ws/src/ros2/rosidl_typesupport
patch -p1 < ../../ros2_objc/ros2_objc/rosidl_typesupport_ros2_objc_travis.patch
cd ~/ros2_objc_ws
src/ament/ament_tools/scripts/ament.py build --parallel --use-xcode --symlink-install --isolated --make-flags -quiet | tee /tmp/ament_build.log | xcpretty
tail /tmp/ament_build.log
