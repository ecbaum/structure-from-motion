function H = DLT_homography(X1, X2)

N = 4; % Four point DLT

T1 = DLT_normalization(X1); % Calculate normalization matrix
T2 = DLT_normalization(X2);

X1n = T1*[X1; ones(1,N)];   % Normalize the coordinates
X2n = T2*[X2; ones(1,N)];

A = zeros(2*N,9);

for i = 1:N
    x1 = X1n(1,i); y1 = X1n(2,i); 
    x2 = X2n(1,i); y2 = X2n(2,i);
    
    Ai = [0, 0, 0, -x2, -y2, -1, y2*x1, y2*y1, y2;
          x1, y1, 1, 0, 0, 0, -x2*x1, -x2*y1, -x2]; 
      
    A((2*i-1):(2*i),:) = Ai; % Assemble A-matrix
end


[~,~,V] = svd(A); 

sol = reshape(V(:,end),[3,3]); % Get solution to homography problem

H = inv(T2)*sol*T1; % Account for normalization

end

