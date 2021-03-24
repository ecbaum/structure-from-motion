function J = jacobian_FDA(converted_trail, pert_amt)



P_m = converted_trail.P_m;
P_list = converted_trail.P_list;
H_list = converted_trail.H_list;

J = [];
for i = 1:length(H_list)
    H = H_list{i};
    P = P_list{i};
    for j = 1:9
        [r1, r2, r1_p, r2_p] = pert_res(H, P, P_m, j, pert_amt);
        
        dr1 = (r1 - r1_p)/pert_amt;
        dr2 = (r2 - r2_p)/pert_amt;
        
        J = [J;[dr1, dr2]];
    end
end

pert = {[pert_amt; 0],[0; pert_amt]};

for k = 1:2
    
    pp = pert{k};
    
    r1 = 0;
    r2 = 0;

    for i = 1:length(H_list)
        H = H_list{i};
        P = P_list{i};
        [r1_, r2_] = res(H,P,P_m);
        r1 = r1 + r1_;
        r2 = r2 + r2_;
    end

    r1p = 0;
    r2p = 0;

    for i = 1:length(H_list)
        H = H_list{i};
        P = P_list{i};
        [r1_, r2_] = res(H,P,P_m + pp);
        r1p = r1p + r1_;
        r2p = r2p + r2_;
    end

    dr1 = (r1 - r1_p)/pert_amt;
    dr2 = (r2 - r2_p)/pert_amt;

    J = [J;[dr1, dr2]];
end
