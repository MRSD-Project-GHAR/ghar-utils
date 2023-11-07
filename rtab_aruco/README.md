# Integration of RTAB-Map and Aruco

## Launch the camera or rosbag
```bash
roslaunch realsense2_camera rs_camera.launch align_depth:=true
```

## Launch aruco detection pipeline
```bash
roslaunch aruco_ros aruco_rtab.launch 
```

## Launch RTab-Map 
```bash
roslaunch rtabmap_launch rtabmap.launch depth_topic:=/camera/aligned_depth_to_color/image_raw rgb_topic:=/camera/color/image_raw camera_info_topic:=/camera/color/camera_info rviz:=true  args:="-d -Optimizer/Strategy 1" landmark_angular_variance:=9999
```

