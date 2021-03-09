clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data('wall');

img1 = imgs{1};
img2 = imgs{2};

[pts1, descs1] = extractSIFT(img1); 
[pts2, descs2] = extractSIFT(img2); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.4, 'Ma    tchThreshold', 100); 
X1 = pts1(:,corrs(:,1));
X2 = pts2(:,corrs(:,2));
%%
clf
subplot(1,2,1)
imagesc(img1);colormap gray
subplot(1,2,2)
imagesc(img2);colormap gray
figure
showMatchedFeatures(img1,img2,X1',X2')

%%

test_points = randperm(length(X1),4);
X =   X1(:,test_points);
X_p = X2(:,test_points);

H = DLT_homography(X, X_p);

X_hat_p = dehom( H*hom(X) );

diff = X_hat_p - X_p

error = sum(sqrt(diff(1,:).^2 + diff(2,:).^2))

%%
[H, nbr_inliers] = ransac_homography(X1, X2, 4)

