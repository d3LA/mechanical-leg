%%%%%%%%%%%%%% Generalized Reduced Gradient Implementation %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% By Max Yi Ren and Emrah Bayrak %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function solution = gradient(f, g, h, delh, d0, d_id, s_id, opt)
    % Set initial conditions
    d = [1;2]; % Set current solution to the initial guess
    s0 = [1;1]; % Set an arbitrary guess for s corresponding to your d0 (column vector)
    x = zeros(numel(s_id)+numel(d_id),1); % Create a zero column vector for x  
    x([d_id, s_id]) = [d;s0]; % Set initial guess to current solution.
    
    s = solveh(x, h, delh, s_id, d_id); % Find the corresponding s to d0 starting from s0
    x([d_id, s_id]) = [d;s]; % Save corrected s and d to current solution.
    
    iter = 0; % Set iteration counter to 0
    
    % Initialize a structure to record search process
    solution = struct('x',[]); 
    solution.x = [solution.x, x]; % save current solution to solution.x
    
    % Set the termination criterion:
    % Remember that in GRG reduced gradient is used to find stationary points.
    gval = g(x);
    delhval = delh(x);
    delzdeld = gval(d_id) - gval(s_id)*(delhval(:,s_id)\delhval(:,d_id)); % reduced gradient
    gnorm = norm(delzdeld); % norm of reduced gradient

    while gnorm>opt.eps % if not terminated
        
        iter = iter + 1; % update iteration counter
        
        % opt.linesearch switches line search on or off. 
        % You can first set the variable "a" to different constant values and see how it
        % affects the convergence.
        if opt.linesearch
            a = lineSearch(f, g, h, delh, x, d_id, s_id);
        else
            a = 0.01;
        end
        
        % Gradient descent:
        dstep = - a*delzdeld'; % step for decision variables
        d = d + dstep;          % update d with the step
	x([d_id,s_id]) = [d; s];
        delhval = delh(x);
	sstep = -(delhval(:,s_id)\delhval(:,d_id))*dstep; % find approximate step for state variables
        s_approx = s + sstep; % calculate approximate values for s using the the approximate step 
        x([d_id,s_id]) = [d; s_approx]; % save the decision and approximate state variables to current solution
        
        % State variable correction
        s = solveh(x, h, delh, s_id, d_id); % Calculate the actual state variables using linear approximation of h
        x([d_id,s_id]) = [d; s];      % Save the corrected variables to current solution
        
        % Update termination criterion:
        gval = g(x);
        delhval = delh(x);
        delzdeld = gval(d_id) - gval(s_id)*(delhval(:,s_id)\delhval(:,d_id)); % reduced gradient
        gnorm = norm(delzdeld); % norm of reduced gradient

        % save current solution to solution.x
        solution.x = [solution.x, x]; 
    end