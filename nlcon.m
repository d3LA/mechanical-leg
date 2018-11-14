function [c,ceq]=nlcon(T)

Ts=0.05;
T1=[T(1);T(3);T(5);T(7);T(9);T(11);T(13);T(15);T(17);T(19);T(21);T(23);T(25);T(27);T(29);T(31)];
T2=[T(2);T(4);T(6);T(8);T(10);T(12);T(14);T(16);T(18);T(20);T(22);T(24);T(26);T(28);T(30);T(32)];
torques=[T1 T2];
% torques=[zeros(floor(1/dt)+1,1) zeros(floor(1/dt)+1,1)];
TimeSpan=0:Ts:(size(torques,1)-1)*Ts;
% TimeSpan=[0 1];
IC=[pi/2;0;0;0];
options=odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5 1e-5],'MaxStep',Ts/2);
[tsim,y]=ode45(@samplesys,TimeSpan,IC,options,torques,Ts);
y=y';
theta1=y(1,:);
theta2=y(3,:);
w1=y(2,:);
w2=y(4,:);
w=[w1;w2];


%angular velocity limit
wmax=65;
wmin=-65;

theta_out=[pi/2-theta1;theta2];
thed_deg=10;
thed_rad=deg2rad(thed_deg);
thed=[thed_rad thed_rad]';
error=sum((theta_out(:,end)-thed).^2);
c=w(:)-wmax;
c=[c;wmin-w(:)];

ceq=[];

end