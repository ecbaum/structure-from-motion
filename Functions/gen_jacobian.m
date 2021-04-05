function J = gen_jacobian(theta, P_lists, p)

n = length(P_lists);
m = length(P_lists{1}.P_list);



J = [];
for j = 1:n
    for i = 1:m 
        P = P_lists{j}.P_list{i};
        for ii = 1:2
            J_row = [];
            for k = 1:length(theta)

                theta_p = theta;
                theta_m = theta;

                theta_p(k) = theta_p(k) + p;
                theta_m(k) = theta_m(k) - p;


                P_m_p = theta_p(m*9 + (j-1)*2+1 : m*9 + j*2);
                P_m_m = theta_m(m*9 + (j-1)*2+1 : m*9 + j*2);

                H_p = reshape(theta_p((i-1)*9+1 : i*9),[3,3]);
                H_m = reshape(theta_m((i-1)*9+1 : i*9),[3,3]);
                
                f_p = P_m_p - apply_H(H_p,P);
                f_m = P_m_m - apply_H(H_m,P);

                df = (f_p - f_m)/(2*p);
                
                J_k = df(ii);
                
                J_row = [J_row, J_k];
            end

            J = [J;J_row];
        end
    end    
end




