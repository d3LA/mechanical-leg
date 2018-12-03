function y = constraint(x)
run leg.m
delta = tL(1)-tL(2);
theta1 = xL(n,1); theta2 = xL(n,3); % n = 1, increases per every step
dtheta11 = x(2); dtheta21 = x(4); 
ddtheta1 = -2*x(2)/delta; ddtheta21 = -2*x(4)/delta;
tau1 = x(1); tau2 = x(3);
    % Constraint vector (column vector)
y = [(-25*sin(theta2)*dtheta21^2-50*dtheta11*sin(theta2)*dtheta21 +(981*cos(theta1+...
theta2))/2+(3924*cos(theta1))/5+ddtheta21*(25*cos(theta2)+47/2)+ddtheta1*(50*cos(theta2)+20001/100))-tau1;
(25*sin(theta2)*dtheta11^2+(245*ddtheta21)/2+(981*cos(theta1+theta2))/4+ddtheta1*(25*cos(theta2)+47/2))-tau2];
