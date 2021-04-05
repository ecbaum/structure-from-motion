function [theta, m] = refine_estimation2(feature_trails, origin_TF, pert_amt)

[P_lists, theta] = jacobian_preprocessing(feature_trails, origin_TF);
m = length(P_lists{1}.P_list);
disp('Delta before:')
disp(norm(cmp_delta(theta,P_lists)))
K_max = 60;
for k = 1:K_max
    delta = cmp_delta(theta,P_lists);
    
    J = gen_jacobian(theta, P_lists, pert_amt);
    %J = gen_jacobian2(theta, P_lists);
    %theta = theta - (J'*J)))\J'*delta;
    theta = theta - 0.1*J'*delta;
    %norm(J'*delta)
end
%norm(delta)
disp('Delta after:')
disp(norm(delta))


   

