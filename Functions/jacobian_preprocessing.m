function [P_lists, theta] = jacobian_preprocessing(feature_trails, origin_TF)

N = length(feature_trails)

P_lists = cell(1,N);

for i = 1:N
    
    trail = convert_trail(feature_trails{i}, origin_TF);
    struct.P_m = trail.P_m;
    struct.P_list = trail.P_list;
    P_lists{i} = struct;
end

H_list = trail.H_list;

m = length(H_list);
n = length(P_lists);

theta = zeros(9*m + 2*n,1);

for i = 1:m
    H = H_list{i};
    theta((i-1)*9+1 : i*9) = reshape(H,[1,9]);
end
i0 = m*9;
for i = 1:n
    P = P_lists{i}.P_m;
    theta(i0 + (i-1)*2+1 : i0 + i*2) = P;
    
end














