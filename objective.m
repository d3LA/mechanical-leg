function f=objective(T)
%sampling time:0.05(s)
Ts=0.05;
T1=[T(1);T(3);T(5);T(7);T(9);T(11);T(13);T(15);T(17);T(19);T(21);T(23);T(25);T(27);T(29);T(31)];
T2=[T(2);T(4);T(6);T(8);T(10);T(12);T(14);T(16);T(18);T(20);T(22);T(24);T(26);T(28);T(30);T(32)];
torques=[T1 T2];
TimeSpan=0:Ts:(size(torques,1)-1)*Ts;

%set initial position and velocity
IC=[pi/2;0;0;0];
options=odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5 1e-5],'MaxStep',Ts/2);
[tsim,y]=ode45(@samplesys,TimeSpan,IC,options,torques,Ts);

%states 
y=y';
theta1=y(1,:);
theta2=y(3,:);
w1=y(2,:)
w2=y(4,:)
w=[w1;w2]

% minimize energy
% E=0;
torques=torques';
E = torques.*w*Ts;
% E_net=(sum(sum(E)))^2
% E_total=sum(sum(E.^2))
E(E<0)=0;
% E(E<0)=0;
E = sum(sum(E));
% desire pose
theta_out=[theta1;theta2];
thed_deg=10;
thed_rad=deg2rad(thed_deg);
thed=[pi/2-thed_rad thed_rad]';
error=sum((theta_out(:,end)-thed).^2);


% f=-(E_total-E_net)
%objective function: 
f=E+10000*error
% f=error
end
   