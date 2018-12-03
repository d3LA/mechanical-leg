function Hinv = correctH(H, iter)
    % Fix singular H matrix
    I = eye(size(H));
    lambda = 1.0;
    Hinv = (H'*H+lambda*I)\H'; %use Levenberg-Marquardt when singular
end