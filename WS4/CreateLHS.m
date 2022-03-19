function y = CreateLHS(Nx,Ny,type)

hx=1/(Nx+1);
hy=1/(Ny+1);
%% choose the type of Coefficient Matrix.
if(type==0)
    y = zeros(Nx*Ny,Nx*Ny);
elseif(type==1)
    y=sparse(Nx*Ny,Nx*Ny);
end
%% number the nodes
NodeNum = zeros(Nx,Ny);
cnt = 1;

for i=1:Ny
    for j=1:Nx
        NodeNum(i,j) = cnt;
        cnt = cnt + 1;
    end
end
%% create LHS 
%diagonal elemnt is same for each node!!
%ask if the left,right,upper or lower neigbor exist or not!!
for i=1:Ny
    for j=1:Nx
        currNode = NodeNum(i,j);
        y(currNode,currNode) = -2/hx^2 -2/hy^2;

        if(j>1)
            lNeigbor = NodeNum(i,j-1);
            y(currNode,lNeigbor) = y(currNode,lNeigbor) + 1/hx^2;
        end

        if(j<Ny)
            rNeigbor =  NodeNum(i,j+1);
            y(currNode,rNeigbor) = y(currNode,rNeigbor) + 1/hx^2;
        end

        if(i<Nx)
            uppNeigbor = NodeNum(i+1,j);
            y(currNode,uppNeigbor) = y(currNode,uppNeigbor) + 1/hy^2;
        end

        if(i>1)
            lowNeigbor = NodeNum(i-1,j);
            y(currNode,lowNeigbor) = y(currNode,lowNeigbor) + 1/hy^2;
        end
    end

end
end
