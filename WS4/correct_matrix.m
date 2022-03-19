function y = correct_matrix(Ny,Nx)
y = zeros(Nx*Ny,1);
cnt=1;
for i = 1:Ny
    for j=1:Nx
        y(cnt) = sin(pi*i/(Nx+1))*sin(pi*j/(Ny+1));
        cnt = cnt + 1;
    end
end
end
        