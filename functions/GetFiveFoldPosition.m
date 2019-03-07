function [ffcvPos] = GetFiveFoldPosition(AM, AD, Y, pIndex,alpha,gamma)
    AM1 = AM;
    AD1 = AD;
    HMDD = pIndex;
    nm = size(Y, 1); 
    nd = size(Y, 2);
    
    [pp, ~] = size(pIndex);
    ffcvPos = zeros(1, pp);
    
    rng(1); % fix the random seed;
    Indices = 1:pp;
    X = (Indices(randperm(length(Indices))))';
    
    T = 1;
    
    bindwidth = [0.01, 0.1, 1, 5, 10, 50, 100];
    
    for cv = 1:5
        
        fprintf('Current fold: %d\n', cv);
        
        Y_temp = Y;
        if cv < 5
            B = HMDD(X((cv - 1) * floor(pp / 5) + 1:floor(pp / 5) * cv), :);
            % obtain training sample
            for i = 1:floor(pp / 5)
                Y_temp(B(i, 1), B(i, 2)) = 0;
            end
        else
            B = HMDD(X((cv - 1) * floor(pp / 5) + 1:pp), :);
            % obtain training sample
            for i = 1:pp - floor(pp / 5) * 4
                Y_temp(B(i, 1), B(i, 2)) = 0;
            end
        end
        
        % compute a set of Gaussian Interaction Profile kernels
        AM = AM1;
        AD = AD1;
        for idx = 1:size(bindwidth, 2)
            [KD, KM] = GaussianKernel(Y_temp', bindwidth(idx), bindwidth(idx));
            KM(logical(eye(size(KM)))) = 0;
            KD(logical(eye(size(KD)))) = 0;
            AM(size(AM, 2) + 1) = {KM};
            AD(size(AD, 2) + 1) = {KD};
        end    
        
        F = MultiKernelLearning(AM, AD, Y_temp,alpha,gamma);
        [size1B, ~] = size(B);

        for i = 1:size1B
            finalscore(i, 1) = F(B(i, 1), B(i, 2));
        end

        for i = 1:nm
            for j = 1:nd
                if Y(i, j) == 1
                    F(i, j) = 0;
                end
            end
        end
        
        for qq = 1:size1B
            % obtain the position of tested disease-microbe interaction as variable position(1,cv), 
            [ll1,~] = size(find( F >= finalscore(qq)));
            [ll2,~] = size(find(F > finalscore(qq)));
            ffcvPos(1, T) = ll2 + 1 + (ll1 - ll2 - 1) / 2;
            T = T + 1;
        end

    end

end
  