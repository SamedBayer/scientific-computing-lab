function savefun(ExpEulerSol,Nx,Ny, dt, k)
    f= figure('Visible','off');
    [X,Y] = meshgrid(linspace(0,1,Nx+2),linspace(0,1,Ny+2));
    surf(X,Y,ExpEulerSol);
    axis auto 
    title("N=" +Nx + " Time Step="+"1/"+1/dt+" t="+string(k/8))
    zlabel('Temperature')
    xlabel('x direction','FontSize',7) 
    ylabel('y direction','FontSize',7)
    saveas(f,'N_'+string(Nx)+'_dt_'+string(dt)+'_time_'+string(k/8)+'.png')
    close(f)

end

