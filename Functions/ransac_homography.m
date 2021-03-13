function [H, nbr_inliers, ratio, inliers1, inliers2, corrs] = ransac_homography2(X1, X2, threshold, corrs)
K_max = 1000;

current_lowest_num_outliers = inf;

m = size(X1,2);
n = 4;  

if m < 4
    H = [];
    nbr_inliers = 0;
    ratio = [];
    return;
end

for k = 1:K_max
   
    test_points = randperm(m,n);
        
    H_c = DLT_homography(X1(:,test_points), X2(:,test_points));
    
    diff = X2 - dehom( H_c*hom(X1) );
    errors = sqrt(diff(1,:).^2 + diff(2,:).^2);
    nbr_outliers = sum(errors>threshold);
    
    if nbr_outliers < current_lowest_num_outliers
        current_lowest_num_outliers = nbr_outliers;
        H = H_c;
        nbr_inliers = m - nbr_outliers;
        ratio = nbr_inliers/m;
        inlier_index = errors<=threshold;
    end
end
corrs = corrs(inlier_index,:);
inliers1 = X1(:,inlier_index);
inliers2 = X2(:,inlier_index);
