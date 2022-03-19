function y = CreateRHS(Nx,Ny,BC,dt)
%BC-->respectively upperBC,lowerBC,leftBC,rightBC 
hx = 1/(Nx+1);
hy = 1/(Ny+1);
y = ones(Nx,Ny);
%% create RHS
%modify the boundary nodes according to the given BC's

for i = 1:Nx 
    for j=1:Ny 
        if(j==1)
            y(i,j) = y(i,j) -BC(2)*dt/hy^2;
        end

        if(j==Ny)
            y(i,j) = y(i,j) -BC(1)*dt/hy^2;
        end

        if(i==1)
            y(i,j) = y(i,j) -BC(3)*dt/hx^2;
        end

        if(i==Nx)
            y(i,j) = y(i,j) -BC(4)*dt/hx^2;
        end

    end
end
end
        