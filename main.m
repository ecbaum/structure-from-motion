clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data('wall');

img1 = imgs{4};
img2 = imgs{3};

[pts1, descs1] = extractSIFT(img1); 
[pts2, descs2] = extractSIFT(img2); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.5, 'MatchThreshold', 100); 
X1 = pts1(:,corrs(:,1));
X2 = pts2(:,corrs(:,2));
%%
[H, num_inliers, ratio] = ransac_homography2(X1, X2, 4);

%%
show_alignment(img1,img2,X1,X2)

%%
clf
subplot(1,2,1)
imagesc(img1);colormap gray
subplot(1,2,2)
imagesc(img2);colormap gray
figure
showMatchedFeatures(img1,img2,X1',X2')



