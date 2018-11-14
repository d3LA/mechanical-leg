%initial condition
T0=[-63.6519
   -4.4460
  -56.4917
  -26.0057
  -61.6319
   -3.7550
  -59.5983
   -5.7695
  -49.5499
   -2.6946
  -44.7999
  -16.6956
  -36.6041
  -15.0043
  -32.4152
   -4.9780
  -37.2905
   -3.3325
  -26.6064
   -5.5274
  -18.5231
   -5.4202
  -18.4428
   -8.0487
  -14.5286
   -3.3598
   -5.3082
    3.2080
    2.5114
   -4.6505
    1.9999
    1.0014]';

% T0=randi([-5 5],1,32)

A=[];
b=[];
Aeq=[];
beq=[];
%xi>=0
%motor torque limit
Tmax=217;Tmin=-217;
ub=[Tmax;Tmax;Tmax;Tmax];      
lb=[Tmin;Tmin;Tmin;Tmin];
opts=optimoptions('fmincon','Algorithm','sqp','MaxFunctionEvaluations',10000);
[Topt,fopt,exitflag]=fmincon(@(T) objective(T),T0,A,b,Aeq,beq,lb,ub,@(T) nlcon(T),opts)
T01=[];
T02=[];
T1=[];
T2=[];

for i=1:2:32
T01=[T01 T0(i)]
end
for i=2:2:32
T02=[T02 T0(i)]
end

for i=1:2:32
T1=[T1 Topt(i)]
end
for i=2:2:32
T2=[T2 Topt(i)]
end
Ts=0.05
t=Ts:Ts:0.8
figure(1)
T= 0:0.01:0.8;
Tsmooth1 = pchip(t,T01,T);
plot(T,Tsmooth1)
hold on
T= 0:0.01:0.8;
Tsmooth2 = pchip(t,T1,T);
plot(T,Tsmooth2)
legend('no optimization','optimization')
xlabel('Time(s)')
ylabel('Torque(Nm)')
title('Motor 1')

figure(2)
T= 0:0.01:0.8;
Tsmooth1 = pchip(t,T02,T);
plot(T,Tsmooth1)
hold on
T= 0:0.01:0.8;
Tsmooth2 = pchip(t,T2,T);
plot(T,Tsmooth2)
legend('no optimization','optimization')
xlabel('Time(s)')
ylabel('Torque(Nm)')
title('Motor 2')
%[X,FVAL,EXITFLAG] = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS)