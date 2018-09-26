clc; clear;
% differential equation characterizing the evolution of the system under
% the action of external stimuli: ?=M(?)...
syms m1 m2 l1 l2 theta1 theta2 dtheta1 dtheta2 ddtheta1 ddtheta2 g real
M = [m1*l1^2+m2*(l1^2+2*l1*l2*cos(theta2)+l2^2) m2*(l1*l2*cos(theta2)+l2^2);
    m2*(l1*l2*cos(theta2)+l2^2) m2*l2^2];
C = [-m2*l1*l2*sin(theta2)*(2*dtheta1*dtheta2+dtheta2^2); m2*l1*l2*dtheta1^2*sin(theta2)];
G = [(m1+m2)*l1*g*cos(theta1)+m2*g*l2*cos(theta1+theta2); m2*g*l2*cos(theta1+theta2)];
tau = M*[ddtheta1;ddtheta2]+C+G; 
%simplify(tau)
L=-inv(M)*(C+G);
A1 = [dtheta1;dtheta2;L(1);L(2)];
for n = 1:4
    A2 = gradient(A1(n),[theta1,theta2,dtheta1,dtheta2]);
    A(n,:) = A2';
end
% Ax + Bu
A;
B = [0 0;0 0;inv(M)];
