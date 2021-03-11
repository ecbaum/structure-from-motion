function [A_best,t_best] = ransac_fit_affine2(pts, pts_tilde, tau)
    m = size(pts,2);
    n = 3;                   % Nr of points used for model fitting, n >= 3
    eta = 0.01;              % Probabilty of faliure
    epsilon = 0.01;          % Initial estimated inlier ration
    N_max = ceil(log(eta)./log(1-epsilon.^(n))); % Initial N_max
    N = 0;
    while N < N_max
        N = N+1;    
        
        test_points = randperm(m,n);
        [A,t] = estimate_affine(pts(:,test_points),pts_tilde(:,test_points));
             
        residual = sum((pts_tilde - (A*pts + t)).^2,1);
        is_inlier = find(residual<tau);
        inlier_ratio = length(is_inlier)/m;
        
        if inlier_ratio > epsilon
            [A_best,t_best] = estimate_affine(pts(:,is_inlier),pts_tilde(:,is_inlier));
            epsilon = inlier_ratio;
            N_max = ceil(log(eta)./log(1-epsilon.^(n)));
            
        end
    end
end