# Multimodal deep-learning for object recognition combining camera and LIDAR data

Link: https://ieeexplore.ieee.org/document/9096138

Object detection and recognition is a key component of autonomous robotic vehicles, as evidenced by the continuous efforts made by the robotic community on areas related to object detection and sensory perception systems. This paper presents a study on multisensor (camera and LIDAR) late fusion strategies for object recognition. In this work, LIDAR data is processed as 3D points and also by means of a 2D representation in the form of depth map (DM), which is obtained by projecting the LIDAR 3D point cloud into a 2D image plane followed by an upsampling strategy which generates a high-resolution 2D range view. A CNN network (Inception V3) is used as classification method on the RGB images, and on the DMs (LIDAR modality). A 3D-network (the PointNet), which directly performs classification on the 3D point clouds, is also considered in the experiments. One of the motivations of this work consists of incorporating the distance to the objects, as measured by the LIDAR, as a relevant cue to improve the classification performance. A new range-based average weighting strategy is proposed, which considers the relationship between the deep-models' performance and the distance of objects. A classification dataset, based on the KITTI database, is used to evaluate the deep-models, and to support the experimental part. We report extensive results in terms of single modality i.e., using RGB and LIDAR models individually, and late fusion multimodality approaches.

Cropping the 3D point clouds.

![Crop_Point_Clouds](https://github.com/gledsonmelotti/Multimodal-deep-learning-combining-camera-LIDAR-data-/blob/main/Images/frame_114_juntos.png)

3D point clouds:

![3D_Point_Cloud](https://github.com/gledsonmelotti/Multimodal-deep-learning-combining-camera-LIDAR-data-/blob/main/Images/Cropping_Examples.png)
