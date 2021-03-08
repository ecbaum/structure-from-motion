function [U, nbr_inliers] = ransac_homography(Ps, us, threshold)

    m = size(us,2);
    n = 2;                   % Nr of points used for model fitting
    eta = 0.01;              % Probabilty of faliure
    epsilon = 0.01;          % Initial estimated inlier ration
    N_max = ceil(log(eta)./log(1-epsilon.^(n))); % Initial N_max
    N = 0;
    while N < N_max
        N = N+1;    
        
        test_points = randperm(m,n);
        U_candidate = %% Transform estimation
        
        % Finds number of points within tau
        errors = %% Calculate errors 

        is_inlier = find(errors<threshold);
        nbr_inliers = length(is_inlier);
        inlier_ratio = nbr_inliers/m;
        
        % Evaluates model based on current inlier ration
        if inlier_ratio > epsilon
            % Updates best solution
            
            U = U_candidate;
            
            % Updates epsilon and N_max
            epsilon = inlier_ratio;
            N_max = ceil(log(eta)./log(1-epsilon.^(n)));
            
        end
    end
end