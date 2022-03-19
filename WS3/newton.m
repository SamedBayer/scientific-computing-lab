% b)
% newton( y(i),@(x) ( x - y(i)  - dt*f(x) ) ,@(x) ( 1-dt*df(x) ) );
function y = newton(x_0, G, dG)
i = 0; tol = 1;
while( i<=100 && tol > 10^-8 )
    %y-->x_new

    if dG(x_0) < 10^-8
        print("Problem is not solvable, please try another initial guess")
        break;
    end

    y = x_0 - G(x_0) / dG(x_0) ;
    tol = abs(y - x_0);
    x_0 = y;
    i = i+1;
end
end