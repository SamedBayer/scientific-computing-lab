%% g) 
function y = ImpEulerExtended(y_0, dt, t_end, f, df)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(s, size(y_0,2));
y(1,:) = y_0
for i = 1:s-1
    G = @(x) (x-y(i,:) - dt*f(x));
    dG= @(x) (eye(size(y_0,2))-dt*df(x));
    y(i+1,:) = newtonExtended( y(i,:), G, dG );
end
end