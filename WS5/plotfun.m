function y= plotfun (k,ExpEulerSol, Nx, Ny , cnt , solutiontype,dt)
            figure(k);
            subplot(4,7,cnt);
            [X,Y] = meshgrid(linspace(0,1,Nx+2),linspace(0,1,Ny+2));
            f = surf(X,Y,ExpEulerSol);
            axis auto
            title("N=" +Nx + "  Time Step=1/"+1/dt)
            sgtitle(solutiontype+" time="+k/8+"s")
            zlabel('Temperature')
            xlabel('x direction','FontSize',7) 
            ylabel('y direction','FontSize',7)

end

