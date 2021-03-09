function [H, nbr_inliers] = ransac_homography(X1, X2, threshold)

    m = size(X1,2);
    n = 4;                   % Nr of points used for model fitting
    eta = 0.01;              % Probabilty of faliure
    epsilon = 0.01;          % Initial estimated inlier ration
    N_max = ceil(log(eta)./log(1-epsilon.^(n))); % Initial N_max
    N = 0;
    while N < N_max
        N = N+1;    
        
        test_points = randperm(m,n);
        
        H_c = DLT_homography(X1(:,test_points), X2(:,test_points)); % Candidate solution

       % P_c = [H_c(:,1:2),cross(H_c(:,1),H_c(:,2)), H_c(:,3)];
        
        % Finds number of points within tau
        
        diff = X2 - dehom( H_c*hom(X1) );
        errors = sqrt(diff(1,:).^2 + diff(2,:).^2);
        is_inlier = find(errors<threshold);
        nbr_inliers = length(is_inlier);
        inlier_ratio = nbr_inliers/m;
        
        % Evaluates model based on current inlier ration
        if inlier_ratio > epsilon
            % Updates best solution
            
            H = H_c;
            
            % Updates epsilon and N_max
            epsilon = inlier_ratio;
            N_max = ceil(log(eta)./log(1-epsilon.^(n)));
            
        end
    end
end