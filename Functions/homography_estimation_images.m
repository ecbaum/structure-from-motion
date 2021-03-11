function img_hom = homography_estimation_images(imgs, MaxRatio, epsilon)

N = length(imgs);
img_hom = cell(1,N-1);


for i = 1:N-1
    idxA = i+1;
    idxB = i;
    
    imgA = imgs{idxA};
    imgB = imgs{idxB};

    [H, num_inliers, ratio] = homography_AtoB(imgA, imgB, MaxRatio, epsilon);
    
    img_hom{i}.H = H;
    img_hom{i}.desc = ['img' num2str(idxA) '->' 'img' num2str(idxB)];
    img_hom{i}.num_inliers = num_inliers;
    img_hom{i}.ratio = ratio;
    
end


end