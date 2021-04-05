function delta = cmp_delta(theta,P_lists)

n = length(P_lists);
m = length(P_lists{1}.P_list);


delta = [];
for j = 1:n
    for i = 1:m
        
        P = P_lists{j}.P_list{i};

        P_m = theta(m*9 + (j-1)*2+1 : m*9 + j*2);

        H = reshape(theta((i-1)*9+1 : i*9),[3,3]);

        F = P_m - apply_H(H,P);
        delta = [delta; F];
    end
end