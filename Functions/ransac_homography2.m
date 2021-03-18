function [H, num_inl, inlier_ratio] = ransac_homography2(X1, X2, threshold, ransac_iter)
    m = size(X1,2);
    n = 4;                   % Nr of points used for model fitting, n >= 3
    eta = 0.0001;              % Probabilty of faliure
    epsilon = 0.01;          % Initial estimated inlier ration
    N_max = ransac_iter; % Initial N_max
    N = 0;
    while N < N_max
        %disp(N_max)
        N = N+1;    
        % Fits model for n random points
%         index = randperm(m);
%         test_points = index(1:n);
        test_points = randperm(m,n);
        H_c = DLT_homography(X1(:,test_points), X2(:,test_points));
        diff = X2 - apply_H(H_c,X1);  
        errors = sqrt(diff(1,:).^2 + diff(2,:).^2);
        is_inlier = find(errors<threshold);
        num_inl = length(is_inlier);
        inlier_ratio = num_inl/m;
        
        % Evaluates model based on current inlier ration
        if inlier_ratio > epsilon
            % Updates best solution
            H = H_c;
            % Updates epsilon and N_max
            epsilon = inlier_ratio;
            N_max = ceil(log(eta)./log(1-epsilon.^(n)));
            
        end
    end

disp(['ransac iter: ' num2str(N)])
end