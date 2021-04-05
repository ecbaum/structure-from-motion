function [converted_trail,diff] = refine_estimation(converted_trail,k_max, pert_amt, alpha)


N = length(converted_trail.H_list);

theta = [];

for i = 1:N
    H = converted_trail.H_list{i};
    theta = [theta; reshape(H,[9,1])];
end

theta = [theta; converted_trail.P_m];

e0 = trail_residual(theta, converted_trail.P_list);

lambda = 0.001;
e_prev = e0;
for k = 1:k_max
    e = trail_residual(theta, converted_trail.P_list);
    J = jacobian_FDA(converted_trail,pert_amt).';
    theta = theta - alpha*(inv(J'*J + lambda*eye(length(J)))*J'*e);
    
    improv = norm(e_prev) - norm(e);
    e_prev = e;
    if improv > 0
        lambda = lambda*10;
    else
        lambda = lambda*0.1;
    end
end

for i = 1:N
    converted_trail.H_list{i} = reshape(theta((i-1)*9+1 : i*9),[3,3]);
end

converted_trail.P_m = theta(end-1:end);
diff = norm(e0) - norm(e);