#!/bin/bash

# Create a new tmux session
session_name="record_bag_$(date +%s)"
tmux new-session -d -s $session_name

# Split the window into three panes
tmux selectp -t 0    # select the first (0) pane
tmux splitw -v -p 50 # split it into two halves
tmux selectp -t 0    # go back to the first pane
tmux splitw -h -p 50 # split it into two halves

# Run the roslaunch command in the first pane
tmux select-pane -t 0
tmux send-keys "rosrun dynamic_reconfigure dynparam set /camera/stereo_module emitter_enabled 0" Enter

# Run the teleop.py script in the second pane
tmux select-pane -t 1
tmux send-keys "roslaunch realsense2_camera rs_camera_ghar.launch" Enter

# Change the directory to ../topomaps/bags and run the rosbag record command in the third pane
tmux select-pane -t 2
tmux send-keys 'rosbag record -a -O data.bag -x "/(.*)/theora/(.*)|(.*)/theora|/(.*)/compressed/(.*)|(.*)/compressed|/(.*)/compressedDepth/(.*)|(.*)/compressedDepth"' Enter

tmux select-pane -t 2


# Attach to the tmux session
tmux -2 attach-session -t $session_name