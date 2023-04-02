#!/usr/bin/env bash

gnome-termial
cd ~/ghar/kimera_ws

# Kill previous session
tmux kill-session

# Create a tmux session
session_name="kimera_$(date +%s)"
tmux new-session -d -s $session_name 

# Split the window into three panes
tmux selectp -t 0    # select the first (0) pane
tmux splitw -v -p 50 # split it into two halves

tmux selectp -t 0    # go back to the first pane
tmux splitw -h -p 33 # split it into two halves
tmux selectp -t 0    # select the first (0) pane
tmux splitw -h -p 40 # split it into two halves
# tmux splitw -h -p 33 # split it into two halves

tmux selectp -t 3    # go back to the first pane
tmux splitw -h -p 33 # split it into two halves
tmux selectp -t 3    # select the first (0) pane
tmux splitw -h -p 40 # split it into two halves
# tmux splitw -h -p 33 # split it into two halves

# Run the kimera_vio
tmux select-pane -t 0
tmux send-keys "roslaunch kimera_vio_ros kimera_vio_ros_realsense_IR.launch run_stereo_dense:=true should_use_sim_time:=true" Enter

# Run the kimera_semantics
tmux select-pane -t 1
tmux send-keys "sleep 3 && roslaunch kimera_semantics_ros kimera_metric_realsense.launch should_use_sim_time:=true" Enter

# Run the segmentation 
tmux select-pane -t 2
tmux send-keys "roslaunch semantic_segmentation_ros segmenter.launch" Enter

# Run the rosbag
tmux select-pane -t 3
tmux send-keys "sleep 6 && rosbag play mrsd-lab-back.bag --clock" Enter

# Run rviz
tmux select-pane -t 4
tmux send-keys "sleep 8 && rviz -d $(rospack find kimera_semantics_ros)/rviz/kimera_realsense_metric.rviz" Enter

# Open RQT
tmux select-pane -t 5
tmux send-keys "sleep 9 && rqt" Enter

# Attach to the tmux session
tmux -2 attach-session -t $session_name -c /home/madhu/work/ros1/ghar/kimera_ws
