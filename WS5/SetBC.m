function y = SetBC(b,Nx,Ny,boundaries)
% upperBC,lowerBC,leftBC,rightBC
temp_matrix = zeros(Nx+2,Ny+2);
temp_matrix(1,:) = boundaries(2);
temp_matrix(Nx+2,:) = boundaries(1);
temp_matrix(:,1) = boundaries(3);
temp_matrix(:,Ny+2) = boundaries(4);
B = reshape(b,Nx,Ny)';
temp_matrix(2:Nx+1,2:Ny+1) = B+ temp_matrix(2:Nx+1,2:Ny+1);
y = temp_matrix;
end

