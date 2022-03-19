function y=ResidualNorm(Nx,Ny,x,b)
hx = 1/(Nx+1);
hy = 1/(Ny+1);
tot = 0;
for i=1:Ny
    for j=1:Nx
        tot = tot +( b(i,j) - (2/hx^2 + 2/hy^2)*sum( x(i,:) ) )^2;
    end
end

y = sqrt(tot/(Nx-1)*(Ny-1));
end

