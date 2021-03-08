function T = DLT_normalization(X) 
    t = -[mean(X(1,:)); mean(X(2,:))]; % The negative mean distance to origin
    Xp = X + t;
    
    D = mean(sqrt(Xp(1,:).^2 + Xp(2,:).^2)); % mean distance two origin after translation
    S = sqrt(2)*diag([1/D, 1/D]); % Normalize distance to sqrt(2)
    
    T = [S, S*t; [0 0 1]];   % Scaling is applied after translation;
    
end

