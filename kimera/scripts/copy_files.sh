#!/usr/bin/env bash

# Copy files from one directory to another
cp launch/kimera_semantics_ghar.launch ../src/Kimera-Semantics/kimera_semantics_ros/launch/
cp launch/kimera_metric_realsense.launch ../src/Kimera-Semantics/kimera_semantics_ros/launch/

cp rviz/kimera_realsense_ghar.rviz ../src/Kimera-Semantics/kimera_semantics_ros/rviz/
cp rviz/kimera_realsense_metric.rviz ../src/Kimera-Semantics/kimera_semantics_ros/rviz/

# Path: build_kimera.sh
