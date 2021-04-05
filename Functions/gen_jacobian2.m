function J = gen_jacobian2(theta, P_lists)

n = length(P_lists);
m = length(P_lists{1}.P_list);


J = [];
for j = 1:n
    
    for i = 1:m 
        J_i = [];
        P = P_lists{j}.P_list{i};

        H = reshape(theta((i-1)*9+1 : i*9),[3,3]);
        J_ = jac_an(H,P);
        for ii = 1:m
            if ii == i
                J_i = [J_i, J_];
            else
                J_i = [J_i, zeros(size(J_))];
            end
       
        end
        for k = 1:n
            if k == j
                J_i = [J_i, zeros(2)];
            else
                J_i = [J_i, zeros(2)];
            end
        end
                
        J = [J; J_i];
    end
    
    
end




