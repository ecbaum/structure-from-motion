function [H, num_inliers, ratio, ptsA, ptsB, corrs] = homography_AtoB(imgA, imgB, MaxRatio, epsilon, ransac_iter)

[ptsA, descs1] = extractSIFT(imgA); 
[ptsB, descs2] = extractSIFT(imgB); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', MaxRatio, 'MatchThreshold', 100,'Unique', true); 
XA = ptsA(:,corrs(:,1));
XB = ptsB(:,corrs(:,2));

[H, num_inliers, ratio] = ransac_homography(XA, XB, epsilon, ransac_iter);

corrs = corrs.';