clc;
close all;

sol1_b = impl_euler(1,1/4,5,@(x) -x, @(x) -1);
% a)

t_end = 5;
x_0 =1;
timeStep = [1/2 1/4 1/8 1/16 1/32];
mu=7;

Sol1 = zeros(2,size((0:timeStep(1):t_end),2));
Sol2 = zeros(2,size((0:timeStep(2):t_end),2));
Sol3 = zeros(2,size((0:timeStep(3):t_end),2));
Sol4 = zeros(2,size((0:timeStep(4):t_end),2));
Sol5 = zeros(2,size((0:timeStep(5):t_end),2));

a = expl_euler(1,0.1,5,@(x) -1*x);
a1 = impl_euler(1,0.1,5,@(x) -1*x, @(x) -1);

Sol1(1,:) = expl_euler(x_0,timeStep(1),t_end,@(x) -mu*x);
Sol2(1,:) = expl_euler(x_0,timeStep(2),t_end,@(x) -mu*x);
Sol3(1,:) = expl_euler(x_0,timeStep(3),t_end,@(x) -mu*x);
Sol4(1,:) = expl_euler(x_0,timeStep(4),t_end,@(x) -mu*x);
Sol5(1,:) = expl_euler(x_0,timeStep(5),t_end,@(x) -mu*x);
% 
% % Explicit Euler
figure("Name","Explicit Euler")
fplot(@(t) exp(-mu*t),[0,5],"Color",'k');
hold on
plot(0:timeStep(1):t_end, Sol1(1,:),'o',"Color",'b');
plot(0:timeStep(2):t_end, Sol2(1,:),'o',"Color",'r');
plot(0:timeStep(3):t_end, Sol3(1,:),'o',"Color",'g');
plot(0:timeStep(4):t_end, Sol4(1,:),'o',"Color",'m');
plot(0:timeStep(5):t_end, Sol5(1,:),'o',"Color",'c');
xlim([0 5])
ylim([-1 1])
legend('Analytical Solution', ...
       '\deltat=1/2','\deltat=1/4','\deltat=1/8',...
       '\deltat=1/16','\deltat=1/32');




% 
% 
% 
% 
% %% d)


Sol1(2,:) = impl_euler(x_0,timeStep(1),t_end,@(x) -mu*x, @(x) -mu);
Sol2(2,:) = impl_euler(x_0,timeStep(2),t_end,@(x) -mu*x, @(x) -mu);
Sol3(2,:) = impl_euler(x_0,timeStep(3),t_end,@(x) -mu*x, @(x) -mu);
Sol4(2,:) = impl_euler(x_0,timeStep(4),t_end,@(x) -mu*x, @(x) -mu);
Sol5(2,:) = impl_euler(x_0,timeStep(5),t_end,@(x) -mu*x, @(x) -mu);

% 
% % Implicit  Euler
figure("Name","Implicit Euler")
fplot(@(t) exp(-mu*t),[0,5],"Color",'k');
hold on
plot(0:timeStep(1):t_end, Sol1(2,:),'o',"Color",'b','MarkerSize',10);
plot(0:timeStep(2):t_end, Sol2(2,:),'o',"Color",'r','MarkerSize',9);
plot(0:timeStep(3):t_end, Sol3(2,:),'o',"Color",'g','MarkerSize',8);
plot(0:timeStep(4):t_end, Sol4(2,:),'o',"Color",'m','MarkerSize',7);
plot(0:timeStep(5):t_end, Sol5(2,:),'o',"Color",'c','MarkerSize',5);
xlim([0 5])
ylim([-1 1])
legend('Analytical Solution', ...
       '\deltat=1/2','\deltat=1/4','\deltat=1/8',...
       '\deltat=1/16','\deltat=1/32');

% %% e)
% 

% % preallocating

Error1 = zeros(2,1,2);Error2 = zeros(2,1,2);Error3 = zeros(2,1,2);
Error4 = zeros(2,1,2);Error5 = zeros(2,1,2);

for i=1:2
    Error1(i,:)= error_func(mu,timeStep(1),t_end, Sol1(i,:));
    Error2(i,:)= error_func(mu,timeStep(2),t_end, Sol2(i,:));
    Error3(i,:)= error_func(mu,timeStep(3),t_end, Sol3(i,:));
    Error4(i,:)= error_func(mu,timeStep(4),t_end, Sol4(i,:));
    Error5(i,:)= error_func(mu,timeStep(5),t_end, Sol5(i,:));
end

for i=1:2
    table([Error1(i);0],[Error2(i);Error1(i)/Error2(i)], ...
    [Error3(i);Error2(i)/Error3(i)],[Error4(i);Error3(i)/Error4(i)],[Error5(i);Error4(i)/Error5(i)], ...
    'VariableNames',{'1/2','1/4','1/8','1/16','1/32'},'RowName',{'error','error red'})
end

% explicitEulerMethod = table([Error1(1);0],[Error2(1);Error1(1)/Error2(1)], ...
%     [Error3(1);Error2(1)/Error3(1)],[Error4(1);Error3(1)/Error4(1)],[Error5(1);Error4(1)/Error5(1)], ...
%     'VariableNames',{'1/2','1/4','1/8','1/16','1/32'},'RowName',{'error','error red'})
% 
% implicitEulerMethod  = table([Error1(2);0],[Error2(2);Error1(2)/Error2(2)], ...
%     [Error3(2);Error2(2)/Error3(2)],[Error4(2);Error3(2)/Error4(2)],[Error5(2);Error4(2)/Error5(2)], ...
%     'VariableNames',{'1/2','1/4','1/8','1/16','1/32'},'RowName',{'error','error red'})




%% g
initial_conditions = [1 1];
t_end_new=20;
time_step_new= 0.01;
mu=4;  
f_new = @(x) [ x(2),  mu*(1-x(1)^2)*x(2) - x(1)];

Sol6 = ExpEulerExtended(initial_conditions,time_step_new,t_end_new,f_new);
figure("Name","2nd Order ODE: Explicit Euler Method")
plot(0:0.01:20, Sol6(1,:),'b');
hold on
plot(0:0.01:20, Sol6(2,:),'r');
legend('x','y');

figure("Name","y vs x")
plot(Sol6(1,:), Sol6(2,:))


%% h&i

df_new = @(x) [0 1;-2*mu*x(1)*x(2)-1 mu*(1-x(1)^2)];
% 
% solve This nonlinear second-order ODE, call function
Sol7 = ImpEulerExtended(initial_conditions,time_step_new,t_end_new,f_new,df_new);
% 
% 
% Implicit Euler Method method for 2nd Order ODE
figure("Name","2nd Order ODE: Implicit Euler Method")
plot(0:0.01:20, Sol7(:,1),'b');
hold on
plot(0:0.01:20, Sol7(:,2),'r');
legend('x','y');

figure("Name","y vs x")
plot(Sol7(:,1), Sol7(:,2))





