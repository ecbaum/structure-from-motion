function [H, num_inl, ratio] = ransac_homography(X1, X2, threshold)
K_max = 1000;

current_lowest_num_outliers = inf;

m = size(X1,2);
n = 4;  

if m < 4
    H = [];
    num_inl = 0;
    ratio = [];
    return;
end

for k = 1:K_max
   
    test_points = randperm(m,n);
        
    H_c = DLT_homography(X1(:,test_points), X2(:,test_points));
    
    diff = X2 - apply_H(H_c,X1); %dehom( H_c*hom(X1) );
    errors = sqrt(diff(1,:).^2 + diff(2,:).^2);
    nbr_outliers = sum(errors>threshold);
    
    if nbr_outliers < current_lowest_num_outliers
        current_lowest_num_outliers = nbr_outliers;
        H = H_c;
        num_inl = m - nbr_outliers;
        ratio = num_inl/m;
        inlier_index = errors<=threshold;
    end
end
