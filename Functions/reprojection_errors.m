function errors = reprojection_errors(Ps, us, U)
    N = length(Ps);
    
    errors = ones(1,N)*inf;
    
    %positive = check_depths(Ps,U);
    
    for i = 1:N
        %if positive(i)
            u = us(:,i);
            P = Ps{i};
            
            lambda = P(3,:)*[U;1];
            u_hat = P*[U;1]/lambda;
            R = u - u_hat(1:2);

            errors(i) = R.'*R;
       % end
        
    end
end

