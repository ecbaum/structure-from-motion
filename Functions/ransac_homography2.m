function [H, nbr_inliers] = ransac_homography2(X1, X2, threshold)
K_max = 1000;

current_lowest_num_outliers = inf;

m = size(X1,2);
n = 4;  


for k = 1:K_max
   
    test_points = randperm(m,n);
        
    H_c = DLT_homography(X1(:,test_points), X2(:,test_points));
    
    diff = X2 - dehom( H_c*hom(X1) );
    errors = sqrt(diff(1,:).^2 + diff(2,:).^2);
    num_outliers = sum(errors>threshold);
    
    if num_outliers < current_lowest_num_outliers
        current_lowest_num_outliers = num_outliers;
        nbr_inliers = m - current_lowest_num_outliers;
        H = H_c;

    end
end