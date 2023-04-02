#!/usr/bin/env bash

cd ~/ghar/kimera_ws && source devel/setup.bash

roslaunch kimera_vio_ros kimera_vio_ros_realsense_IR.launch should_use_sim_time:=true &

sleep 5 

roslaunch kimera_semantics_ros kimera_metric_realsense.launch should_use_sim_time:=true &

sleep 2

roslaunch semantic_segmentation_ros segmenter.launch &

sleep 2

rosbag play ../mrsd-lab-mar-31-more-light.bag --clock &

