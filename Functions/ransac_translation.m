function [t_best] = ransac_translation(pts, pts_tilde, tau)
    m = size(pts,2);
    n = 2;                   % Nr of points used for model fitting, n >= 3
    eta = 0.01;              % Probabilty of faliure
    epsilon = 0.01;          % Initial estimated inlier ration
    N_max = ceil(log(eta)./log(1-epsilon.^(n))); % Initial N_max
    N = 0;
    while N < N_max
        N = N+1;    
        test_points = randperm(m,n);
        t = pts(:,test_points(2)) - pts_tilde(:,test_points(1));
        
        res = pts - pts_tilde + t;
        residual = sum(res.^2,1);
        
        is_inlier = find(residual<tau);
        inlier_ratio = length(is_inlier)/m;
        
        if inlier_ratio > epsilon
            t_best = t;
            epsilon = inlier_ratio;
            N_max = ceil(log(eta)./log(1-epsilon.^(n)));
            
        end
    end
end