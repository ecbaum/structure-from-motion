function H = DLT_homography(X, X_p) % H*X = X_p

N = 4; % Four point DLT

T = DLT_normalization(X); % Calculate normalization matrix
T_p = DLT_normalization(X_p);

%T = eye(3); T_p = eye(3);

Xn = T*[X; ones(1,N)];   % Normalize the points
Xn_p = T_p*[X_p; ones(1,N)];

A = zeros(2*N,9);

for i = 1:N
    u = Xn(1,i); v = Xn(2,i); 
    u_p = Xn_p(1,i); v_p = Xn_p(2,i);
    
    
    Ai = [0, 0, 0, -u, -v, -1, v_p*u, v_p*v, v_p;
          u, v, 1, 0, 0, 0, -u_p*u, -u_p*v, -u_p]; 
      
    A((2*i-1):(2*i),:) = Ai; % Assemble A-matrix
end


[~,~,V] = svd(A); 

H_hat = reshape(V(:,end),[3,3]); % Get solution to homography problem

H = inv(T_p)*H_hat.'*T; % Account for normalization

%end

