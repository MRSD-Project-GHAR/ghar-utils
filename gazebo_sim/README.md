# This is the documentation for running the full pipeline in Gazebo Sim

## 1. Make sure all the packages are installed. 
```
sudo apt-get install ros-$ROS_DISTRO-turtlebot3-* ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-elevation-mapping ros-$ROS_DISTRO-move-base ros-$ROS_DISTRO-move-base-*
```

Clone the `ha_planner` package in your workspace
```
git clone https://github.com/MRSD-Project-GHAR/ha_planner.git
```
Checkout the branch `madhu/integration` in the `ha_planner` package
```
cd ha_planner && git checkout madhu/integration
```

Clone the `elevation_mapping` package in your workspace
```
git clone https://github.com/MRSD-Project-GHAR/elevation_mapping.git
```
Checkout the branch `madhu/debug` in the `elevation_mapping` package
```
cd elevation_mapping && git checkout madhu/debug
```

Download the ply file from google drive [link](https://drive.google.com/file/d/1ZrOw8SfwccUNrXqf0yST2roXz4NNKSjW/view?usp=sharing) and place it in the `ha_planner` package
```
mv ~/Downloads/rtab_house_gazebo_cloud.ply <your_ws>/src/elevation_mapping/elevation_mapping_demos/sample_data/rtab_house_gazebo_cloud.ply
```

## 2. Launch the Gazebo sim with elevation mapping and turtlebot3
```
export TURTLEBOT3_MODEL=waffle
roslaunch elevation_mapping_demos turtlesim3_waffle_demo_rtab_nav.launch 
```

## 3. Launch the move_base_flex planner
```
roslaunch mbf_rrts_planner planner_move_base.launch 
```

## 4. Give start and goal points

### Give start point

```
rostopic pub /start_topic geometry_msgs/PoseStamped "header:
  seq: 0
  stamp:
    secs: 0
    nsecs: 0
  frame_id: 'map'
pose:
  position:
    x: 3.88
    y: 0.988
    z: 0.0
  orientation:
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0" -r 5
```

### Give Goal point
```
rostopic pub /goal_topic geometry_msgs/PoseStamped "header:
  seq: 0
  stamp:
    secs: 0
    nsecs: 0
  frame_id: 'map'
pose:
  position:
    x: 6.93
    y: 3.93
    z: 0.0
  orientation:
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0" -r 5
```


## Generate plan

```
rosservice call /generate_plan "{}" 
```

```
rosservice call /execute_plan "{}" 
```


