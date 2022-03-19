% c)
function y = impl_euler(y_0, dt, t_end, f, df)
s = length(0:dt:t_end);
y= zeros(s,1);
y(1) = y_0;
for i = 1:s-1
    y(i+1) = newton( y(i),@(x) ( x - y(i)  - dt*f(x) ) ,@(x) ( 1-dt*df(x) ) );
end
end
