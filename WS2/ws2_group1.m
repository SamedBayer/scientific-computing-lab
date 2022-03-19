clc;
clear all;
close all;

 

%% a-)
figure("Name","Exact Solution")
fplot(@(t) exp(-t),[0,5],"Color",'b');

%% b-c-)



timeStep = [1 1/2 1/4 1/8];
% for different time steps, solve ODEs with different methods
Sol1 = zeros(3,size((0:timeStep(1):5),2));
Sol2 = zeros(3,size((0:timeStep(2):5),2));
Sol3 = zeros(3,size((0:timeStep(3):5),2));
Sol4 = zeros(3,size((0:timeStep(4):5),2));

% call different methods for each time steps

% for time step=1
Sol1(1,:) = expl_euler(1,1,5,@(x) -x);
Sol1(2,:) = heun(1,1,5,@(x) -x);
Sol1(3,:) = RungeKutta(1,1,5,@(x) -x); 


% for time step = 1/2
Sol2(1,:) = expl_euler(1,0.5,5,@(x) -x);
Sol2(2,:) = heun(1,0.5,5,@(x) -x);
Sol2(3,:) = RungeKutta(1,0.5,5,@(x) -x); 



% for time step = 1/4
Sol3(1,:) = expl_euler(1,0.25,5,@(x) -x);
Sol3(2,:) = heun(1,0.25,5,@(x) -x);
Sol3(3,:) = RungeKutta(1,0.25,5,@(x) -x); 



% for time step = 1/8
Sol4(1,:) = expl_euler(1,0.125,5,@(x) -x);
Sol4(2,:) = heun(1,0.125,5,@(x) -x);
Sol4(3,:) = RungeKutta(1,0.125,5,@(x) -x); 






% Explicit Euler
figure("Name","Explicit Euler")
fplot(@(t) exp(-t),[0,5],"Color",'k');
hold on
plot(0:1:5, Sol1(1,:),'o',"Color",'b');
plot(0:1/2:5, Sol2(1,:),'o',"Color",'r');
plot(0:1/4:5, Sol3(1,:),'o',"Color",'g');
plot(0:1/8:5, Sol4(1,:),'o',"Color",'m');
legend('Analytical Solution','\deltat=1', ...
       '\deltat=1/2','\deltat=1/4','\deltat=1/8');

% Heun Method
figure("Name","Method of Heun")
fplot(@(t) exp(-t),[0,5],"Color",'k');
hold on
plot(0:1:5, Sol1(2,:),'o',"Color",'b');
plot(0:0.5:5, Sol2(2,:),'o',"Color",'r');
plot(0:0.25:5, Sol3(2,:),'o',"Color",'g');
plot(0:0.125:5, Sol4(2,:),'o',"Color",'m');
legend('Analytical Solution','\delta t=1', ...
       '\deltat=1/2','\deltat=1/4','\deltat=1/8');


% Runge-Kutta
figure("Name","Runge-Kutta")
fplot(@(t) exp(-t),[0,5],"Color",'k');
hold on
plot(0:1:5, Sol1(3,:),'o',"Color",'b');
plot(0:1/2:5, Sol2(3,:),'o',"Color",'r');
plot(0:1/4:5, Sol3(3,:),'o',"Color",'g');
plot(0:1/8:5, Sol4(3,:),'o',"Color",'m');
legend('Analytical Solution','\deltat=1', ...
       '\deltat=1/2','\deltat=1/4','\deltat=1/8');

   

%% Error Calculations with exact solutions

ExactSol1 = ( exp(-(0:1:5)));
ExactSol2 = ( exp(-(0:0.5:5)));
ExactSol3 = ( exp(-(0:0.25:5)));
ExactSol4 = ( exp(-(0:0.125:5)));

%preallocating
Error1 = zeros(3,1,2);
Error2 = zeros(3,1,2);
Error3 = zeros(3,1,2);
Error4 = zeros(3,1,2);

for i=1:3
    Error1(i,:)=...
        sqrt(1/5 * sum(  (ExactSol1 -  Sol1(i,:)).^2  ) ) ;

    Error2(i,:)=...
        sqrt(0.5/5 * sum(  (ExactSol2 -  Sol2(i,:)).^2  ) );

    Error3(i,:)=...
        sqrt(0.25/5 * sum(  (ExactSol3 -  Sol3(i,:)).^2  ) );

    Error4(i,:)=...
        sqrt(0.125/5 * sum(  (ExactSol4 -  Sol4(i,:)).^2  ) );
end




%% errors and error reductions in the tables


explicitEulerMethod = table([Error1(1);0],[Error2(1);Error1(1)/Error2(1)], ...
    [Error3(1);Error2(1)/Error3(1)],[Error4(1);Error3(1)/Error4(1)], ...
    'VariableNames',{'1','1/2','1/4','1/8'},'RowName',{'error','error red'})


HeunMethod  = table([Error1(2);0],[Error2(2);Error1(2)/Error2(2)], ...
    [Error3(2);Error2(2)/Error3(2)],[Error4(2);Error3(2)/Error4(2)], ...
    'VariableNames',{'1','1/2','1/4','1/8'},'RowName',{'error','error red'})

RungeKuttaMethod  = table([Error1(3);0],[Error2(3);Error1(3)/Error2(3)], ...
    [Error3(3);Error2(3)/Error3(3)],[Error4(3);Error3(3)/Error4(3)], ...
    'VariableNames',{'1','1/2','1/4','1/8'},'RowName',{'error','error red'})
 



%% d-e-) Van-der-Pol-Oscillator

% Initialize values
initial_conditions = [1 1];
t_end_new=20;
time_step_new= 0.1;
mu=1;  
f_new = @(x) [ x(2), mu*(1-x(1)^2)*x(2) - x(1)];


% solve This nonlinear second-order ODE, call function
Sol5 = heunExtended(initial_conditions,time_step_new,t_end_new,f_new);


% Extended Heun method for 2nd Order ODE
figure("Name","2nd Order ODE: Heun Method")
plot(0:0.1:20, Sol5(1,:),'b');
hold on
plot(0:0.1:20, Sol5(2,:),'r');
legend('x','y');

figure("Name","y vs x")
plot(Sol5(1,:), Sol5(2,:))


%% Optional 
[X Y] = meshgrid(-2.5:0.1:2.5, -2.5:0.1:2.5);
U = Y;
V = (1-X.^2).*Y - X;
figure("Name", "Phase Space as Vector Field")
quiver(X,Y,U,V,3,'r')


%% Functions  
   
% explicit Euler method
function y = expl_euler(y_0, dt, t_end, f)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(1,s);
y(1) = y_0;
for i = 1:s-1
    y(i+1) = y(i) + dt*f(y(i));
end
end


% method of Heun,
function y = heun(y_0, dt, t_end, f)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(1,s);
y(1) = y_0;
for i = 1:s-1
    yy = f( y(i) + dt*f(y(i)) );
    y(i+1) = y(i) + dt*0.5*(f(y(i)) + yy);
end
end


% Runge-Kutta method (fourth order)
function y = RungeKutta(y_0, dt, t_end, f)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(1,s);
y(1) = y_0;
for i = 1:s-1
    Y1 = f(y(i));
    Y2 = f(y(i) + 0.5*dt*Y1);
    Y3 = f(y(i) + 0.5*dt*Y2);
    Y4 = f(y(i) + dt*Y3);
    y(i+1)=... 
          y(i) +  dt/6*(Y1 + 2*Y2 + 2*Y3 + Y4);
end
end


% Extend the Heun method to also account for vector valued functions.
function y = heunExtended(y_0, dt, t_end, f)
tArr = 0:dt:t_end;
s = size(tArr,2);
y = zeros(size(y_0,2),s);
y(:,1) = y_0(1,:)' ;
for i = 1:s-1
    yy =  f( (y(:,i) + dt*f( y(:,i) )'  )' )';
    y(:,i+1) = y(:,i) + dt*0.5*(  f( y(:,i)' )' + yy);
end
end

