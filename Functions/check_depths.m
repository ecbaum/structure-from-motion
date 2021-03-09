function positive = check_depths(Ps,U)
    N = length(Ps);
    positive = zeros(1,N);
    
    for i = 1:N
        lambda = Ps{i}(3,:)*[U;1];
        positive(i) = (lambda > 0);
    end
    
end

