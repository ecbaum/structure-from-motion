clear all; clc
addpath('Functions'); addpath('sift')

data_set = 'wall';

imgs = read_data(data_set);

img_hom = homography_estimation_images(imgs, 0.5, 4);

origin_TF = homography_to_origin(img_hom);


ground_truth = parse_ground_truth(data_set);

origin_TF_GT = origin_TF_ground_truth(origin_TF, ground_truth);


%vis_pts(origin_TF)

sparse_map(origin_TF)

sparse_map(origin_TF_GT)


