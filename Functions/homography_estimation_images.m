function img_hom = homography_estimation_images(imgs, MaxRatio, epsilon, ransac_iter)

idx = [];

N = length(imgs);
for i = 1:(N-1)
    for j = (i+1):N
        idx = [idx; [i j]];
    end
end

M = size(idx,1);
disp('Estimating homographies')
img_hom = cell(1,M);
for i = 1:M
    idxA = idx(i,1);
    idxB = idx(i,2);
    
    
    
    imgA = imgs{idxA};
    imgB = imgs{idxB};

    [H, num_inliers, ratio, ptsA, ptsB, corrs] = homography_AtoB(imgA, imgB, MaxRatio, epsilon, ransac_iter);
    
    disp(['img' num2str(idxA) ' <-> ' 'img' num2str(idxB) ',    inl.: ' num2str(num_inliers)])
    
    inlier_corrs = [];
    if num_inliers > 0
        for j = 1:size(corrs,2)
            pt1 = ptsA(:,corrs(1,j));
            pt2 = ptsB(:,corrs(2,j));
            diff = pt2 - apply_H(H,pt1);
            if sqrt(diff(1,:).^2 + diff(2,:).^2) <= epsilon
                inlier_corrs = [inlier_corrs, corrs(:,j)];
            end
        end
    end

    img_hom{i}.H = H;
    img_hom{i}.img_from = imgA;
    img_hom{i}.idx_from = idxA;
    img_hom{i}.pts_from = ptsA;
    img_hom{i}.img_to = imgB;
    img_hom{i}.idx_to = idxB;
    img_hom{i}.pts_to = ptsB; 
    img_hom{i}.inlier_corrs = inlier_corrs;
    img_hom{i}.num_inliers = num_inliers;
    img_hom{i}.ratio = ratio;
    
    
end
% sorting proceedure 
inliers_and_idx = [zeros(1,M);1:M]';

for i = 1:M
    inliers_and_idx(i,1) = img_hom{i}.num_inliers;
end
inliers_and_idx = sortrows(inliers_and_idx,1,'descend');

img_hom_sorted = cell(1,M);
for i = 1:M
    img_hom_sorted{i} = img_hom{inliers_and_idx(i,2)};
end
img_hom = img_hom_sorted;

end