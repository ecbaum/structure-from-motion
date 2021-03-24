function [converted_trail,diff] = refine_estimation(converted_trail,k_max, pert_amt, alpha)
%converted_trail = convert_trail(feat_trails{4},origin_TF,TF_idx);
%pert_amt = 0.1;

N = length(converted_trail.H_list);

theta = [];

for i = 1:N
    H = converted_trail.H_list{i};
    theta = [theta; reshape(H,[9,1])];
end

theta = [theta; converted_trail.P_m];

e0 = trail_residual(theta, converted_trail.P_list);

lambda = 0.01;
for k = 1:k_max
    e = trail_residual(theta, converted_trail.P_list);
    J = jacobian_FDA(converted_trail,pert_amt).';
    theta = theta - alpha*(inv(J'*J + lambda*eye(length(J)))*J'*e);
end

for i = 1:N
    converted_trail.H_list{i} = reshape(theta((i-1)*9+1 : i*9),[3,3]);
end

converted_trail.P_m = theta(end-1:end);
diff = norm(e0) - norm(e);