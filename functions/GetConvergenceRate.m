function [Obj] = GetConvergenceRate(AM, AD, Y)

    % compute the Gaussian Interaction Profile
    bindwidth = [0.01, 0.1, 1, 5, 10, 50, 100];
    
    for idx = 1:size(bindwidth, 2)
        [KD, KM] = GaussianKernel(Y', bindwidth(idx), bindwidth(idx));
        KM(logical(eye(size(KM)))) = 0;
        KD(logical(eye(size(KD)))) = 0;
        AM(size(AM, 2) + 1) = {KM};
        AD(size(AD, 2) + 1) = {KD};
    end  
        
    AMview = size(AM, 2);
    ADview = size(AD, 2);
    
    AMweight = 1 / AMview * ones(1, AMview);
    ADweight = 1 / ADview * ones(1, ADview);
    
    alpha = 0.00001; 
    beta = 10;
    gamma = 1;% This is the parameter for multi-label learning

    NITER = 20;
    Obj = zeros(1, NITER);
       
    for iter = 1:NITER
        
        fprintf('Current step: %d\n',iter);
        
        % update SM, SD and F;
        [~, KM, ~, KD, F] = alternativeUpdate(AMweight, AM, KM, ADweight, AD, KD, ...
                            Y, alpha, beta, gamma);
        
        % update view weights and calculate obj;
        obj = 0;
        for v = 1:AMview
%             curValue = norm(SM - AM{v}, 'fro');
            curValue = norm(KM - AM{v}, 'fro');
            AMweight(1, v) = 0.5 / curValue;
            obj = obj + curValue;
        end
        
        for v = 1:ADview
%             curValue = norm(SD - AD{v}, 'fro');
            curValue = norm(KD - AD{v}, 'fro');
            ADweight(1, v) = 0.5 / curValue;
            obj = obj + curValue;
        end
        
        obj = obj + norm(F - Y, 'fro');
        Obj(iter) = obj;
    end

end