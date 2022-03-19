function x=GaussSeidelSolver(b,Nx,Ny)
x = zeros(Nx,Ny);
b = reshape(b,Nx,Ny);
hx=1/(Nx+1);
hy=1/(Ny+1);
rNorm1 = ResidualNorm(Nx,Ny,x,b);
relError = 1;
%% Perform GaussSiedel 
%in case right, left, upper,lower neigbor exist
%take their current values !! 
%if any of them do not exist take it zero summuation will not be
%affected ! 
while(relError > 10^-4)
    for i=1:Ny
        for j=1:Nx    
            rNeigbor = 0;
            lNeigbor = 0;
            lowNeigbor = 0;
            uppNeigbor = 0;
            if(i>1)
                lowNeigbor = x(i-1,j);
            end

            if(i<Ny)
                uppNeigbor = x(i+1,j);
            end

            if(j>1)
                lNeigbor = x(i,j-1);
            end

            if(j<Ny)
                rNeigbor = x(i,j+1);
            end

            
           x(i,j) =( -1*b(i,j) + ( lNeigbor + rNeigbor )/hx^2  + ( lowNeigbor + uppNeigbor )/hy^2 ) / (2/hx^2 + 2/hy^2);
        end
    end
    
    rNorm2 = ResidualNorm(Nx,Ny,x,b);
    relError = abs(rNorm2 - rNorm1);
    rNorm1 = rNorm2;
end


