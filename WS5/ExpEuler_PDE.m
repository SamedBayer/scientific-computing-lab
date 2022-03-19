function y = ExpEuler_PDE(Nx,Ny,u,dt)
temp = 0;  %summation of dt over every iteration
y=u;
A = CreateLHS(Nx,Ny,0);

    while(temp<=4/8)
       
        u_new=dt*(A*u) +u;
        u=u_new;
        y=[y u_new];
        temp= temp +dt;

    end

end
