%% Calculate homograhpies

clear all; clc
addpath('Functions'); addpath('sift')

data_set = 'wall';

imgs = read_data(data_set);

ransac_iterations = 20000;
ransac_threshold = 5;
correspondance_threshold = 0.9;

img_hom = homography_estimation_images(imgs, correspondance_threshold, ransac_threshold, ransac_iterations);



%% Homographies to common origin 

ground_truth = parse_ground_truth(data_set);

[origin_TF, corrs_links] = homography_to_origin(img_hom);
origin_TF_GT = origin_TF_ground_truth(origin_TF, ground_truth);

for i = 1:length(origin_TF)
    origin_TF{i}.H = origin_TF{i}.H/origin_TF{i}.H(3,3);
    origin_TF_GT{i}.H = origin_TF_GT{i}.H/origin_TF_GT{i}.H(3,3);
end


feat_trails = feature_trail(corrs_links, origin_TF);


%% plot
close all;
sparse_map(origin_TF)
title('estimated')

sparse_map(origin_TF_GT)
title('ground truth')

figure()
for i = 1:length(feat_trails)
scatter(feat_trails{i}.trail(1,:),feat_trails{i}.trail(2,:),'.')
hold on
end
title('feature track');

vis_pts(origin_TF,origin_TF_GT)

averages = zeros(1,length(origin_TF)-1);
for i = 2:length(origin_TF)
    
    pts = origin_TF{i}.pts;
    H = origin_TF{i}.H;
    H_GT = origin_TF_GT{i}.H;
    
    averages(i-1) = reprojection_error(pts, H, H_GT);
end
averages
