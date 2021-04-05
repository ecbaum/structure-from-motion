%% Calculate homograhpies

clear all; clc
addpath('Functions'); addpath('sift')

data_set = 'bark';

imgs = read_data(data_set);

ransac_iterations = 8000;
ransac_threshold = 3;
correspondance_threshold = 0.5;

img_hom = homography_estimation_images(imgs, correspondance_threshold, ransac_threshold, ransac_iterations);



%% Homographies to common origin 

ground_truth = parse_ground_truth(data_set);

[origin_TF, corrs_links] = homography_to_origin(img_hom);
origin_TF_GT = origin_TF_ground_truth(origin_TF, ground_truth);

for i = 1:length(origin_TF)
    origin_TF{i}.H = origin_TF{i}.H/origin_TF{i}.H(3,3);
    origin_TF_GT{i}.H = origin_TF_GT{i}.H/origin_TF_GT{i}.H(3,3);
end





%% plot
close all;
sparse_map(origin_TF)
title(['2D point cloud, ' data_set])
sparse_map(origin_TF_GT)
title('ground truth')

vis_pts(origin_TF,origin_TF_GT)
%%
averages = zeros(1,length(origin_TF)-1);
avg_desc = {};
for i = 2:length(origin_TF)
    
    pts = origin_TF{i}.pts;
    H = origin_TF{i}.H;
    H_GT = origin_TF_GT{i}.H;
    
    averages(i-1) = reprojection_error(pts, H, H_GT);
    avg_desc = [avg_desc, {[num2str(origin_TF{i}.idx_from) '->' num2str(origin_TF{1}.idx_from)]}];
end
round(averages,2)
avg_desc
%% Nonlinear optimization


feat_trails = feature_trail(corrs_links, origin_TF);

figure()
for i = 1:length(feat_trails)
scatter(feat_trails{i}.trail(1,:),feat_trails{i}.trail(2,:),'.')
hold on
end
title('feature tracks');
%%



for j = 6:-1:3
    full_feature_track = {};
    for i = 1:length(feat_trails)
        if length(feat_trails{i}.trail) == j
            full_feature_track = [full_feature_track {feat_trails{i}}];
        end
    end
    if length(full_feature_track) > 2
        break
    end
end
disp('feature length:')
disp(j)

[theta, m] = refine_estimation2(full_feature_track(1:50), origin_TF, 0.00001);
%%
TF_idx = zeros(1,6);

for i = 1:length(origin_TF)
    TF_idx(origin_TF{i}.idx_from) = i;
end


origin_TF_better = origin_TF;

for i = 1:m
    H = reshape(theta((i-1)*9+1 : i*9),[3,3]);
    H = H/H(3,3);
    origin_TF_better{TF_idx(i)}.H = H;
end

%%
sparse_map(origin_TF_better)
averages2 = zeros(1,5);
for i = 2:length(origin_TF)
    
    pts = origin_TF_better{i}.pts;
    H = origin_TF_better{i}.H;
    H_GT = origin_TF_GT{i}.H;
    
    averages2(i-1) = reprojection_error(pts, H, H_GT);
    %avg_desc = [avg_desc, {[num2str(origin_TF{i}.idx_from) '->' num2str(origin_TF{1}.idx_from)]}];
end
averages2