function [S_new] = kernelization(S, c)
% parameter c is used to control which kernalization method to be chosen;
% and it can be chosen from shif, flip or clip;
    [U, D] = qdwheig(S);
    if(strcmp(c, 'shift'))
        S_new = U * (D + abs(min(min(diag(D)), 0)) * eye(size(D))) * U';
    elseif(strcmp(c, 'flip'))
        S_new = U * abs(D) * U';
    elseif(strcmp(c, 'clip'))
        S_new = U * diag(max(diag(D),0)) * U';
    else
        disp('Wrong parameter. Please input again');
        exit;
    end
end