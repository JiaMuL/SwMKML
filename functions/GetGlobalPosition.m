function [globalPos] = GetGlobalPosition(AM, AD, Y, pIndex)
    AM1 = AM;
    AD1 = AD;
    nm = size(Y, 1); 
    nd = size(Y, 2);
    
    [pp, ~] = size(pIndex);
    globalPos = zeros(1, pp);
    
    bindwidth = [0.01, 0.1, 1, 5, 10, 50, 100];
    
    for curIndex = 3201:3250
        Y_temp = Y;
        Y_temp(pIndex(curIndex, 1), pIndex(curIndex, 2)) = 0;
        AM = AM1;
        AD = AD1;
        
        % compute a set of Gaussian Interaction Profile kernels
        for idx = 1:size(bindwidth, 2)
            [KD, KM] = GaussianKernel(Y_temp', bindwidth(idx), bindwidth(idx));
            KM(logical(eye(size(KM)))) = 0;
            KD(logical(eye(size(KD)))) = 0;
            AM(size(AM, 2) + 1) = {KM};
            AD(size(AD, 2) + 1) = {KD};
        end
        
        F = MultiKernelLearning(AM, AD, Y_temp);
        finalscore = F(pIndex(curIndex, 1), pIndex(curIndex, 2));
        
        % make the score of seed  disease-microbe Ys as zero
        for i = 1:nm
            for j = 1:nd
                if Y(i,j) == 1
                    F(i,j) = 0;
                end
            end
        end
        
        % obtain the position of tested disease-microbe Y as variable globalposition(1,cv),
        [ll1, ~] = size(find(F >= finalscore));
        [ll2, ~] = size(find(F > finalscore));
        globalPos(1, curIndex) = (ll2 + 1 + (ll1 - ll2 - 1))/2;
%       globalposition(1,cv)=ll2;
        str0 = sprintf('Experiment type        : Global cross validation');
        disp(str0);
        str1 = sprintf('Total steps are        : %d', pp);
        disp(str1);
        str2 = sprintf('Current step is        : %d', curIndex);
        disp(str2);
        str3 = sprintf('Precicting score is    : %d', finalscore);
        disp(str3);
        str = sprintf('The current ranking is : %d', globalPos(1, curIndex));
        disp(str);
        str4 = sprintf('\n');
        disp(str4);
    end
    
end
  