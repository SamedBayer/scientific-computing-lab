clc;
clear all;
close all;
tic
%respectively upperBC,lowerBC,leftBC,rightBC 
boundaries = [0,0,0,0];
%0->direct creater
%1->sparse creater
LHSType = [0 1];

%% Iteration Part

N_values = [3,7,15,31,63];
dt = [1/64,1/128,1/256,1/512,1/1024,1/2048,1/4096];

%% a

% When t-> infinity, solutions at last step and previous step are same.
% Therefore, discrete 2D Laplacian equals 0 which is b here (assume BCs 0) 
Nx=5 ; Ny = 5;
b= zeros(Nx*Ny,1);
A = CreateLHS(Nx,Ny,LHSType(2));
direct_solution_stationary = A\b;
direct_solution_stationary = reshape(direct_solution_stationary,Nx,Ny)';

%% b-c
for i=1:4
    figure(i);
end

cnt = 1;
for i=1:size(N_values,2) - 1
    Nx = N_values(i);
    Ny = N_values(i);
    for j=1:size(dt,2)
        initial = ones(Nx*Ny,1);
        ExpSol= ExpEuler_PDE(Nx,Ny,initial,dt(j));
        for k = 1:4
            solLocation = 1+k/(8*dt(j));
            solution= SetBC(ExpSol(:,solLocation),Nx,Ny,boundaries);
            plotfun(k,solution,Nx,Ny, cnt, 'Explicit Solution', dt(j));
            savefun(solution,Nx,Ny, dt(j), k);
        end
        cnt = cnt + 1;
    end
end



%% d-e
figure(5)
cnt = 1;
for i=1:size(N_values,2) - 1
    Nx = N_values(i);
    Ny = N_values(i);
    y0 = CreateRHS(Nx,Ny,boundaries,dt(1));
    ImpSol= ImplicitSolver(Nx,Ny,dt(1),y0);
    for k = 1:4
        sol = ImpSol(:,:, 1+k/(8*dt(1)) );
        [X,Y] = meshgrid(linspace(0,1,Nx+2),linspace(0,1,Ny+2));
        figure(5)
        subplot(4,4,cnt);
        sol= SetBC(sol,Nx,Ny,boundaries);
        fig = surf(X,Y,sol);
        axis auto
        title("N=" +Nx +" time="+k/8+"s")
        sgtitle("Implicit Euler")
        zlabel('Temperature')
        xlabel('x direction','FontSize',7)
        ylabel('y direction','FontSize',7)
        cnt = cnt + 1;
    end
end
toc
