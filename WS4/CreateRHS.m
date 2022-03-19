function y = CreateRHS(Nx,Ny,BC)
hx = 1/(Nx+1);
hy = 1/(Ny+1);
y = zeros(Nx*Ny,1);
cnt=1;
%% create RHS
%modify the boundary nodes according to the given BC's

for i = 1:Ny 
    for j=1:Nx 
        y(cnt) = -2*pi^2*sin(pi*i/(Nx+1))*sin(pi*j/(Ny+1));
        if(i==1)
            y(cnt) = y(cnt) -BC(2)/hy^2;
        end

        if(i==Ny)
            y(cnt) = y(cnt) -BC(1)/hy^2;
        end

        if(j==1)
            y(cnt) = y(cnt) -BC(3)/hx^2;
        end

        if(j==Nx)
            y(cnt) = y(cnt) -BC(4)/hx^2;
        end

        cnt = cnt + 1;
    end
end
end
        