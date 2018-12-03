function [s,hnorm] = solveh(x, h, delh, s_id, d_id)

eps = 1e-3;  % Set a tolerance for convergence 
s = x(s_id);    % Save the current state variables
% d = x(d_id);
hval = h(x);
iter = 0;       % Set initial iteration to 0
% Set termination criterion
hnorm = norm(hval); % norm of the constraint vector

count = 0;
    while(hnorm > eps && count<10)
        iter = iter+1; % Increase iteration by 1
        delhval = delh(x);
        H = delhval(:,s_id); % save current dh/ds
        % Modify dh/ds when it is singular
        %%% KEEP THIS %%%
        Hinv = correctH(H,iter);
        %%%%%%%%%%%%%%%%%
        s = x(s_id) - Hinv*hval; % Use modified dh/ds to calculate new s
        x(s_id) = s;        % Save new s to the current solution
        hval = h(x); 
        hnorm = norm(hval); % Update termination critetion
        count = count + 1;
    end
end