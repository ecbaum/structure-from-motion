function [r1, r2, r1_p, r2_p] = pert_res(H, P, P_m, j, pert_amt)

[r1, r2] = res(H,P,P_m);


H(j) = H(j) + pert_amt;

[r1_p, r2_p] = res(H,P,P_m);