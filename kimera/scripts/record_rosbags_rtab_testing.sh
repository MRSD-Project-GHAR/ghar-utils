#!/bin/bash

gnome-termial

# Kill previous session
tmux kill-session

# Create a new tmux session
session_name="record_bag_$(date +%s)"
tmux new-session -d -s $session_name

# Split the window into three panes
tmux selectp -t 0    # select the first (0) pane
tmux splitw -v -p 50 # split it into two halves
tmux selectp -t 0    # go back to the first pane
tmux splitw -h -p 50 # split it into two halves
tmux selectp -t 2    # go back to the first pane
tmux splitw -h -p 50 # split it into two halves

# Run the roslaunch command in the first pane
tmux select-pane -t 0
tmux send-keys "roslaunch realsense2_camera rs_camera.launch enable_pointcloud:=true enable_infra1:=true enable_infra2:=true" Enter
# tmux send-keys "rosrun dynamic_reconfigure dynparam set /camera/stereo_module emitter_enabled 0" Enter

# Run the teleop.py script in the second pane
tmux select-pane -t 1
tmux send-keys 'sleep 10 && rosbag record -a -x "/(.*)/theora/(.*)|(.*)/theora|/(.*)/compressed/(.*)|(.*)/compressed|/(.*)/compressedDepth/(.*)|(.*)/compressedDepth"' Enter

# Run the control script in the third pane
tmux select-pane -t 2
tmux send-keys "roslaunch interbotix_xslocobot_control xslocobot_control.launch robot_model:=locobot_wx200 use_base:=true use_camera:=false use_lidar:=false" Enter

# Run the keyop script in the fourth pane
tmux select-pane -t 3
tmux send-keys "roslaunch kobuki_keyop keyop.launch __ns:=locobot" Enter

# Attach to the tmux session
tmux -2 attach-session -t $session_name