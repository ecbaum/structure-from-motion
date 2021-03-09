function U = minimal_triangulation(Ps,us)
    % We construct the system of equation on form Ax=b and collect all
    % unknows in "x" using 5 of the provide equations to express A and b.
    % This was derived on paper as follows,
    b = -[Ps{1}(:,4);
        Ps{2}(2:3,4)];
    
    Asub1 = [Ps{1}(1:3,1:3);
            Ps{2}(2:3,1:3)];
    Asub2 = [-us(1,1);-us(2,1);-1;0;0];
    Asub3 = [zeros(3,1);-us(2,2);-1];

    A = [Asub1 Asub2 Asub3];
    x = A\b;
    U = x(1:3);
end