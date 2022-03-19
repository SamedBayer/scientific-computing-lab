function y = ImplicitSolver(Nx,Ny,dt,y0)
solSize = size((0:dt:4/8),2);
y = zeros(Nx,Ny,solSize);
y(:,:,1) = y0;
for k=1:solSize-1
    y(:,:,k+1) = GaussSeidelSolver(y(:,:,k),Nx,Ny,dt) ;
end
end