function xkk=GaussSeidelSolver(x0,Nx,Ny,dt)
xkk =  x0; %kk->k+1 time step, as an initial guess take as x0.
xk =   x0;   %k->solution at k time step, that is previous time step.
hx=1/(Nx+1);
hy=1/(Ny+1);
rNorm = 1;
%% Perform Residual Norm
%in case right, left, upper,lower neigbor exist
%take their current values !!
%if any of them does not exist take it zero, summation will not be
%affected !

while(rNorm > 10^-6)

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


            xkk(i,j) =( xk(i,j) + ( lNeighbor + rNeighbor )*dt/hx^2  + ( lowNeighbor + uppNeighbor )*dt/hy^2 ) / (1+2*dt/hx^2 + 2*dt/hy^2);
        end
    end
    rNorm = ResidualNorm(Nx,Ny,xk,xkk,dt);

end