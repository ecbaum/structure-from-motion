
homography = homography_estimation_images(imgs);


%%

close all;


tform1 = projective2d(inv(homography{1}.H).');
tform2 = projective2d(homography{2}.H.');

%imagesc(zeros(1000,1500));
%hold on
im2to1 = imwarp(imgs{2},tform1);
%imagesc(im2W,'AlphaData', 0.5); colormap gray

%imagesc(imgs{1},'AlphaData', 0.5); colormap gray


im3to2 = imwarp(imgs{3},tform2);


%imagesc(im3W,'AlphaData', 0.5); colormap gray



%%

[H, a, ~] = ransac_homography2(X1, X2, 10);

%%
tform1 = projective2d(inv(H).');

im2to1 = imwarp(img2,tform1);


imagesc(imfuse(im2to1,img1));
%%
[H, num_outliers, ratio] = ransac_homography2(X1, X2, 4)

%% Matchar features

X1p = dehom(H*hom(X1));
X1pp = H*hom(X1);


tform1 = projective2d(H.');

subplot(1,2,1)
imshow(img1); hold on; scatter(X1(1,:),X1(2,:))

subplot(1,2,2)
img1p = imwarp(img1,tform1);
imshow(img1p); hold on; scatter(X1p(1,:),X1p(2,:)); scatter(X1pp(1,:),X1pp(2,:))


% 
% subplot(2,3,1)
% scatter(X2(1,:),X2(2,:))
% subplot(2,3,2)
% scatter(X1(1,:),X1(2,:),'x')
% 
% subplot(2,3,3)
% scatter(X2(1,:),X2(2,:))
% hold on
% scatter(X1p(1,:),X1p(2,:),'x')
% 
% 
% subplot(2,3,4)
% imshow(img2); hold on; scatter(X2(1,:),X2(2,:))
% subplot(2,3,5)
% imshow(img1); hold on; scatter(X1(1,:),X1(2,:))
% 
% subplot(2,3,6)
% imagesc(imfuse(img2,img1p)); hold on; 
% scatter(X2(1,:),X2(2,:))
% scatter(X1p(1,:),X1p(2,:),'x')

%%

tform1 = projective2d(H.');

img1p = imwarp(img1,tform1);

subplot(1,2,1)
imshow(img1); hold on; scatter(X1(1,:),X1(2,:))

subplot(1,2,2)
imshow(img1p); hold on; scatter(X1p(1,:),X1p(2,:))
figure
imagesc(imfuse(img2,img1p));

%%

clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data('wall');
img1=imgs{1};img2=imgs{2};img3=imgs{3};img4=imgs{4};img5=imgs{5};img6=imgs{6};


















