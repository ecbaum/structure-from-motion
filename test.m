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
%5,4,3

H45 = img_hom{4}.H;
H34 = img_hom{5}.H;
H56 = img_hom{6}.H;

H63 =inv(H34)*inv(H45)*inv(H56);

