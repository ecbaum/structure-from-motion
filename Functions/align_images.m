function warped = align_images(source, target, threshold, method)
    
[pts1, descs1] = extractSIFT(source); 
[pts2, descs2] = extractSIFT(target); 

corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.8, 'MatchThreshold', 100);


pts = pts1(:,corrs(:,1));
pts_tilde = pts2(:,corrs(:,2));

if method == 1
    [A,t] = ransac_fit_affine2(pts, pts_tilde, threshold);
    warped = affine_warp(size(source), source, A, t);
elseif method == 2
    t = translation(pts, pts_tilde, threshold);
    warped = affine_warp(size(source), source, eye(2), t);
end



 