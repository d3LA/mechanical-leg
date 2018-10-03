%% state space
clear; clc;
syms T1 T2
syms m1 m2;
syms a1 a2;
syms I1 I2;
syms L1 L2;
syms c1 s1 c2 s2 c12;
syms theta1 theta2 dtheta1 dtheta2 ddtheta1 ddtheta2;
syms g;
c1=cos(theta1);s1=sin(theta1);c2=cos(theta2);s2=sin(theta2);c12=cos(theta1+theta2)
syms M11 M12 M21 M22 B1 B2 g1 g2
% M11=m1*L1^2+I1+m2*(a1^2+L2^2+2*a1*a2*c2)+I2;
% M12=m2*(L2^2+a1*L2*c2)+I2;
% M21=m2*(L2^2+a1*L2*c2)+I2;
% M22=m2*L2^2+I2;
% B1=-m2*a1*L2*s2*(2*dtheta1*dtheta2+dtheta2^2);
% B2=m2*a1*L2*s2*dtheta1^2;
% g1=m1*g*L1*c1+m2*g*(a1*c1+L2*c12);
% g2=m2*g*L2*c12;
% M=[M11 M12;
%    M21 M22]
% B=[B1;B2]
% g=[g1;g2]
ddtheta=[ddtheta1;ddtheta2]
eqn1=[M11*ddtheta1+M12*ddtheta2+B1+g1==T1]
eqn2=[M21*ddtheta1+M22*ddtheta2+B2+g2==T2]
eqn=[eqn1,eqn2]
var=[ddtheta1 ddtheta2];
[ddthe1,ddthe2]=solve(eqn,var)
pretty(simplify(ddthe1))    ;          %ddtheta1
pretty(simplify(ddthe2))    ;          %ddtheta2
%% linearization
% equilibrium
clear; clc;
syms T1 T2
syms m1 m2;
syms a1 a2;
syms I1 I2;
syms L1 L2;
syms c1 s1 c2 s2 c12;
syms theta1 theta2 dtheta1 dtheta2 ddtheta1 ddtheta2;
syms g;
c1=cos(theta1);s1=sin(theta1);c2=cos(theta2);s2=sin(theta2);c12=cos(theta1+theta2)
M11=m1*L1^2+I1+m2*(a1^2+L2^2+2*a1*a2*c2)+I2;
M12=m2*(L2^2+a1*L2*c2)+I2;
M21=m2*(L2^2+a1*L2*c2)+I2;
M22=m2*L2^2+I2;
B1=-m2*a1*L2*s2*(2*dtheta1*dtheta2+dtheta2^2);
B2=m2*a1*L2*s2*dtheta1^2;
g1=m1*g*L1*c1+m2*g*(a1*c1+L2*c12);
g2=m2*g*L2*c12;
% state-space=0, using taylor expansion
equal1=[taylor(M12*g2-M22*g1,[theta1,theta2],'order',4)==0]
equal2=[taylor(-M11*g2+M21*g1,[theta1,theta2],'order',4)==0]
equal=[equal1,equal2];
var=[theta1 theta2];
[the1,the2]=solve(equal,var)            % get equlibrium point:theta1 theta2
 
% jacobian
ddthe1=-(M12*T2 - M22*T1 - M12*g2 + M22*g1 - B2*M12 + B1*M22)/(M11*M22 - M12*M21)
ddthe2=(M11*T2 - M21*T1 - M11*g2 + M21*g1 - B2*M11 + B1*M21)/(M11*M22 - M12*M21)
f1=dtheta1;        
f2=dtheta2;
f3=ddthe1;
f4=ddthe2;
A=jacobian([f1;f2;f3;f4],[theta1 theta2 dtheta1 dtheta2])
B=jacobian([f1;f2;f3;f4],[T1 T2])
%plug in equilibrium point
%subs(A,{theta1,theta2,dtheta1,dtheta2},{the1(1),the2(1),0,0}) 
%subs(B,{theta1,theta2,dtheta1,dtheta2},{the1(1),the2(1),0,0})

