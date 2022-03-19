clc;
clear all;
close all;
%respectively upperBC,lowerBC,leftBC,rightBC 
boundaries = [0,0,0,0];
%0->direct creater
%1->sparse creater
LHSType = [0 1];
%% Iteration Part

% runtime is a cell storing the runtime and storage values of different
% solutions for different N values

N_values = [3,7,15,31,63];
a_error = zeros(1,5);

for i= 1 : size(N_values,2)
    
    % For plotting
    [X,Y] = meshgrid(linspace(0,1,N_values(i)+2),linspace(0,1,N_values(i)+2));
    b=CreateRHS(N_values(i),N_values(i),boundaries);

   
    % storing the system matrix as a normal (full) N × N matrix and using the  
    % MATLAB direct solver
    figure
    subplot(2,3,1);
    A = CreateLHS(N_values(i),N_values(i),LHSType(1));
    tic
    direct_solution = A\b;
    runtime{1}(1,i) = toc;
    S = whos('direct_solution');
    S2 = whos('A');
    S3 = whos('b');
    % storage requirements (measured by the number 
    % of doubles needed to store the system matrix and vectors ) 
    runtime{1}(2,i) = ((S.bytes) + (S2.bytes) + (S3.bytes))/8;
    
    direct_solution = SetBC(direct_solution,N_values(i),N_values(i),boundaries(1),boundaries(2),boundaries(3),boundaries(4));
    direct_solution = reshape(direct_solution,N_values(i)+2,N_values(i)+2);
    surf(X,Y,direct_solution)
    axis auto
    title("Direct solution with N=" +N_values(i) )
    zlabel('Temperature')
    
    subplot(2,3,4);
    contour(X,Y,direct_solution)
    xlabel('x direction') 
    ylabel('y direction')
    axis auto




    % storing the system matrix as a sparse matrix and using the 
    % MATLAB directsolver,
    subplot(2,3,2);
    sparse_A = CreateLHS(N_values(i),N_values(i),LHSType(2));
    tic
    sparse_solution = sparse_A\b;
    runtime{2}(1,i) = toc;
    S = whos('sparse_solution');
    S2 = whos('sparse_A');
    % storage requirements (measured by the number 
    % of doubles needed to store the system matrix and vectors ) 
    % It also gives the storage requirements for zero cells 
    % (they are not zero) which are way
    % lower than the storage requirements of nonzero cells.
    runtime{2}(2,i) = ((S.bytes) + (S2.bytes) + (S3.bytes))/8;
    
    sparse_solution = SetBC(sparse_solution,N_values(i),N_values(i),boundaries(1),boundaries(2),boundaries(3),boundaries(4));
    sparse_solution = reshape(sparse_solution,N_values(i)+2,N_values(i)+2);
    surf(X,Y,sparse_solution)
    axis auto
    title(["As a sparse matrix"," with N="+N_values(i)] )
    zlabel('Temperature')

    subplot(2,3,5);
    contour(X,Y,sparse_solution)
    xlabel('x direction') 
    ylabel('y direction')
    axis auto





    % without storing the system matrix 
    % (use Gauss-Seidel with zero as initial guessfor T!).
    subplot(2,3,3);
    tic
    gauss_solution = GaussSeidelSolver(b,N_values(i),N_values(i));
    runtime{3}(1,i) = toc;
    S = whos('gauss_solution');
    % storage requirements (measured by the number 
    % of doubles needed to store the vectors ) 
    runtime{3}(2,i) = (S.bytes+S3.bytes)/8;
    a_error(i)= sqrt(sum( (reshape(correct_matrix (N_values(i),N_values(i)), N_values(i),N_values(i)) - gauss_solution).^2,'all') / (N_values(i)*N_values(i)));

    gauss_solution = SetBC(gauss_solution,N_values(i),N_values(i),boundaries(1),boundaries(2),boundaries(3),boundaries(4));
    gauss_solution = reshape(gauss_solution,N_values(i)+2,N_values(i)+2);
    surf(X,Y,gauss_solution)
    axis auto
    title(["Gauss-Seidel","with N="+N_values(i)])
    zlabel('Temperature')

    subplot(2,3,6);
    contour(X,Y,gauss_solution)
    xlabel('x direction') 
    ylabel('y direction')
    axis auto

    sgtitle('Coloured Surface and Contour Plot of Different Solutions') 
end


%% table

% table
table_names = ["Direct Solution with Full Matrix" "Direct Solution with Sparse Matrix" "Gauss Seidel Solution"];
for i=1:3
    table_names(i)
    table([runtime{i}(1,2);runtime{i}(2,2)],[runtime{i}(1,3);runtime{i}(2,3)], ...
    [runtime{i}(1,4);runtime{i}(2,4)],[runtime{i}(1,5);runtime{i}(2,5)], ...
     'VariableNames',{'7','15','31','63'},'RowName',{'runtime','storage'})
end


%% Error
b= CreateRHS(127,127,boundaries);
gauss_solution_127 = GaussSeidelSolver(b,127,127);
a_error(6) =sqrt(sum( (reshape(correct_matrix (127,127), 127,127) - gauss_solution_127).^2,'all') / (127*127));



error_Gauss_Seidal = table([a_error(2);NaN],[a_error(3);a_error(2)/a_error(3)], ...
     [a_error(4);a_error(3)/a_error(4)],[a_error(5);a_error(4)/a_error(5)],[a_error(6);a_error(5)/a_error(6)], ...
     'VariableNames',{'7','15','31','63','127'},'RowName',{'error','error red'})