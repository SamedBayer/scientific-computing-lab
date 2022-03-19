% 
% % explicit Euler method

function y = expl_euler(y_0, dt, t_end, f)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(1,s);
y(1) = y_0;
for i = 1:s-1
    y(i+1) = y(i) + dt*f(y(i));
end
end