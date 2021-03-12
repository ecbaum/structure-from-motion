clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data('boat');

img_hom = homography_estimation_images(imgs, 0.5, 4);

origin_TF = homography_to_origin(img_hom);

vis_pts(origin_TF)

sparse_map(origin_TF)



