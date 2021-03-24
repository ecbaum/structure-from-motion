function e = trail_residual(theta, P_list)
    e = zeros(2,1);
    
    N = length(P_list);
    
    P_m = theta(end-1:end);
    
    for i = 1:N
        H = reshape(theta((i-1)*9+1 : i*9),[3,3]);
        P = P_list{i};
        e = e + (P_m - apply_H(H,P)).^2;
    end
end