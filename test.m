clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data('wall');

img1 = imgs{4};
img2 = imgs{3};

[pts1, descs1] = extractSIFT(img1); 
[pts2, descs2] = extractSIFT(img2); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.5, 'MatchThreshold', 100, 'Unique', true); 
X1 = pts1(:,corrs(:,1));
X2 = pts2(:,corrs(:,2));
%%
[H, num_inliers, ratio] = ransac_homography2(X1, X2, 4);


%%
clf
subplot(1,2,1)
imagesc(img1);colormap gray
subplot(1,2,2)
imagesc(img2);colormap gray
figure
showMatchedFeatures(img1,img2,X1',X2')

%%

origin_TF{2}
origin_TF{2}.H



to_origin = ground_truth{2}.H

H2_1 = inv(ground_truth{1}.H);

to_origin*H2_1
