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
tmux send-keys "roslaunch kimera_vio_ros kimera_vio_ros_realsense_IR.launch" Enter

# Run the teleop.py script in the second pane
tmux select-pane -t 1
tmux send-keys "sleep 4 && rosbag play mrsd-lab-back.bag --clock" Enter

# Change the directory to ../topomaps/bags and run the rosbag record command in the third pane
tmux select-pane -t 2
tmux send-keys 'sleep 6 && rviz -d $(rospack find kimera_vio_ros)/rviz/kimera_vio_ghar.rviz' Enter

tmux select-pane -t 3
# 

# Attach to the tmux session
tmux -2 attach-session -t $session_name -c ~/ghar/kimera_ws