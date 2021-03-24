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



%%
feat_trails = feature_trail(corrs_links, origin_TF);
%%
n = 0;
m = 0;
for i = 1:length(feat_trails)
    if length(feat_trails{i}.trail) >= 3
        m = m +1;
        [~,e]=refine_estimation(convert_trail(feat_trails{i},origin_TF,TF_idx), 3, 0.002, 0.001);
        if e > 0
            n = n+1;
        end
    end
end
n
