function X = dehom(X)
    X = X(1:2,:)./X(3,:);
end