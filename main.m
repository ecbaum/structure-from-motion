clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data();

img1 = imgs{1};
img2 = imgs{2};

[pts1, descs1] = extractSIFT(img1); 
[pts2, descs2] = extractSIFT(img2); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.8, 'MatchThreshold', 100); 
X1 = pts1(:,corrs(:,1));
X2 = pts1(:,corrs(:,2));

%%

%[P, nbr_inliers] = ransac_homography(X1, X2, 1)


test_points = randperm(length(X1),4);
X =   X1(:,test_points);
X_p = X2(:,test_points);

H = DLT_homography(X, X_p);

Xh = [X1(:,test_points); ones(1,4)];
Xh_p =[X2(:,test_points); ones(1,4)];

Xh_hat_p = H*Xh;
X_hat_p = Xh_hat_p(1:2,:)./Xh_hat_p(3,:);

diff = X_hat_p - X_p;

error = sum(sqrt(diff(1,:).^2 + diff(2,:).^2))

