function [H, num_inliers, ratio, inliersA, inliersB] = homography_AtoB(imgA, imgB, MaxRatio, epsilon)

[pts1, descs1] = extractSIFT(imgA); 
[pts2, descs2] = extractSIFT(imgB); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', MaxRatio, 'MatchThreshold', 100,'Unique', true); 
X1 = pts1(:,corrs(:,1));
X2 = pts2(:,corrs(:,2));

[H, num_inliers, ratio, inliersA, inliersB] = ransac_homography2(X1, X2, epsilon);
