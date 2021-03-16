clear all; close all; clc
addpath('Functions'); addpath('sift')

data_set = 'wall';

imgs = read_data(data_set);

ransac_iterations = 5000;
ransac_threshold = 1;
correspondance_threshold = 0.6;

img_hom = homography_estimation_images(imgs, correspondance_threshold, ransac_threshold, ransac_iterations);

%%

ground_truth = parse_ground_truth(data_set);

origin_TF = homography_to_origin(img_hom);
origin_TF_GT = origin_TF_ground_truth(origin_TF, ground_truth);


sparse_map(origin_TF)
title('estimated')
sparse_map(origin_TF_GT)
title('ground truth')

vis_pts(origin_TF,origin_TF_GT)

averages = zeros(1,length(origin_TF)-1);
for i = 2:length(origin_TF)
    
    pts = origin_TF{i}.pts;
    H = origin_TF{i}.H;
    H_GT = origin_TF_GT{i}.H;
    
    averages(i-1) = reprojection_error(pts, H, H_GT);
end
averages

