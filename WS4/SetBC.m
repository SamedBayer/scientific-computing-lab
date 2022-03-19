function y = SetBC(b,Nx,Ny,uppBC,lowBC,lBC,rBC)
temp_matrix = zeros(Ny+2,Nx+2);
temp_matrix(1,:) = lowBC;
temp_matrix(Ny+2,:) = uppBC;
temp_matrix(:,1) = lBC;
temp_matrix(:,Nx+2) = rBC;
B = reshape(b,Ny,Nx);
temp_matrix(2:Ny+1,2:Nx+1) = B+ temp_matrix(2:Ny+1,2:Nx+1);
y = reshape(temp_matrix,(Nx+2)*(Ny+2),1);
end

