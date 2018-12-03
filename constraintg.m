function y = constraintg(x)
    % Gradient of the contraints:
    % dh/dx = [dh1/dx1, dh1/dx2, ... dh1/dxn;
    %           ...
    %          dhn/dx1, dhn/dx2, ... dhn/dxn]
    run leg.m
delta = tL(1)-tL(2);
theta1 = xL(2,1); theta2 = xL(2,3);
dtheta11 = x(2); dtheta21 = x(4); 
ddtheta1 = -2*x(2)/delta; ddtheta21 = -2*x(4)/delta;
tau1 = x(1); tau2 = x(3);
    y = [-1,-50*dtheta21*sin(theta2)-(2*(50*cos(theta2)+20001/100))/delta,0,-50*dtheta11*sin(theta2)-50*dtheta21*sin(theta2)-(2*(25*cos(theta2)+47/2))/delta;
        0,50*dtheta11*sin(theta2)-(2*(25*cos(theta2)+47/2))/delta,-1,-245/delta];
        
        