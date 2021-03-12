function img_hom = homography_estimation_images(imgs, MaxRatio, epsilon)

idx = [];

N = length(imgs);
for i = 1:(N-1)
    for j = (i+1):N
        idx = [idx; [i j]];
    end
end

M = size(idx,1);

%M = 6;

img_hom = cell(1,M);

%for i = 1:M-1
%     idxA = i+1;
%     idxB = i;

for i = 1:M
    idxA = idx(i,1);
    idxB = idx(i,2);
    
    disp(['img' num2str(idxA) '->' 'img' num2str(idxB)])
    
    imgA = imgs{idxA};
    imgB = imgs{idxB};

    [H, num_inliers, ratio, inliersA, inliersB] = homography_AtoB(imgA, imgB, MaxRatio, epsilon);
    
    
    img_hom{i}.H = H;
    img_hom{i}.idx_from = idxA;
    img_hom{i}.idx_to = idxB;
    img_hom{i}.img_from = imgA;
    img_hom{i}.img_to = imgB;
    img_hom{i}.num_inliers = num_inliers;
    img_hom{i}.inliers_from = inliersA;
    img_hom{i}.inliers_to = inliersB;
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