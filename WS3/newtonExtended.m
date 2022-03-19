%% h)
function y = newtonExtended(x_0, G, dG)
i = 0; tol = 1;
while( i<=100 && tol > 10^-8 )
    %y-->x_new
    y = x_0 -  ( dG(x_0) \ (G(x_0))' )';
    tol = max( abs(y - x_0) );
    x_0 = y;
    i = i+1;
end
end
