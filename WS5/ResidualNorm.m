function y=ResidualNorm(Nx,Ny,xk,xkk,dt)
hx = 1/(Nx+1);
hy = 1/(Ny+1);
tot = 0;
for i=1:Nx
    for j=1:Ny
            rNeighbor = 0;
            lNeighbor = 0;
            lowNeighbor = 0;
            uppNeighbor = 0;
            if(j>1)
                lowNeighbor = xkk(i,j-1);
            end

            if(j<Ny)
                uppNeighbor = xkk(i,j+1);
            end

            if(i>1)
                lNeighbor = xkk(i-1,j);
            end

            if(i<Nx)
                rNeighbor = xkk(i+1,j);
            end

   
           tot = tot -xkk(i,j) +( xk(i,j) + ( lNeighbor + rNeighbor )*dt/hx^2  + ( lowNeighbor + uppNeighbor )*dt/hy^2 ) / (1+2*dt/hx^2 + 2*dt/hy^2);

    end
end

y = sqrt(tot/(Nx)*(Ny));
end
