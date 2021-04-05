H = sym('H',[3,3]);

Pm = sym('pm',[2,1]);
P = sym('p',[2,1]);

f = Pm - apply_H(H,P);

fx = f(1);

fy = f(2);

J_i_H = jacobian(f,[H(1) H(2) H(3) H(4) H(5) H(6) H(7) H(8) H(9)]);

J_i_x = jacobian(f,[Pm(1), Pm(2)])