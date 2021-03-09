function homography = homography_estimation_images(imgs)

homography = cell(1,length(imgs));

imgA = imgs{1};
for i = 1:6
    
    imgB = imgs{2};

    [pts1, descs1] = extractSIFT(imgA); 
    [pts2, descs2] = extractSIFT(imgB); 
    corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.4, 'MatchThreshold', 100); 
    X1 = pts1(:,corrs(:,1));
    X2 = pts2(:,corrs(:,2));

    [H, nbr_inliers] = ransac_homography(X1, X2, 3);
    
    homography{i}.H = H;
    homography{i}.inliers = nbr_inliers;
    
end


end