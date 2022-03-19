
function y = ExtExpEuler(y_0, dt, t_end, f)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(size(y_0,2),s);
y(:,1) = y_0(1,:)' ;
for i = 1:s-1
    y(:,i+1) = y(:,i) + dt*(  f( y(:,i)' )' );
end
end