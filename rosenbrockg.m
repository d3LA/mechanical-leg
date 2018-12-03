function g = rosenbrockg(x)
    % Gradient vector. (row vector)
    % df/dx = [df/dx1, df/dx2, ... , df/dxn]
    g = [x(2),x(1),x(4),x(3)];