function [fx, fy] = res(H,P,P_m)


h11 = H(1); h12 = H(4); h13 = H(7);
h21 = H(2); h22 = H(5); h23 = H(8);
h31 = H(3); h32 = H(6); h33 = H(9);

x = P(1); y = P(2);
x_m = P_m(1); y_m = P_m(2);

fx = (x_m - (h13 + h11*x + h12*y)/(h33 + h31*x + h32*y))^2;
fy = (y_m - (h23 + h21*x + h22*y)/(h33 + h31*x + h32*y))^2;