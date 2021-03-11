function [H, num_inliers, ratio] = homography_AtoB(imgA, imgB, MaxRatio, epsilon)

imgA_name = inputname(1);
imgB_name = inputname(2);

[pts1, descs1] = extractSIFT(imgA); 
[pts2, descs2] = extractSIFT(imgB); 
corrs = matchFeatures(descs1', descs2', 'MaxRatio', MaxRatio, 'MatchThreshold', 100); 
X1 = pts1(:,corrs(:,1));
X2 = pts2(:,corrs(:,2));

[H, num_inliers, ratio] = ransac_homography2(X1, X2, epsilon);

%disp(['H:' imgA_name ' -> ' imgB_name])
%disp(['Number of inliers: ' num2str(num_inliers) ', ratio: ' num2str(ratio)])