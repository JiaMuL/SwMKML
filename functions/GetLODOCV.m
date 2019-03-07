function GetLODOCV(AM, AD, Y)
% Y is the input miR-disease association matrix;
    AM1 = AM;
    AD1 = AD;
	nm = size(Y, 1); 
%     nd = size(Y, 2);
    
    bindwidth = [0.01, 0.1, 1, 5, 10, 50, 100];
    
    for curIndex = 1:2  
        
        fprintf('Current disease : %d\n', curIndex);
        
        Y_temp = Y;
        Y_temp(:, curIndex) = 0;
        
        AM = cell(1);
        AD = cell(1);
        AM(1) = AM1;
        AD(1) = AD1;
       % compute a set of Gaussian Interaction Profile kernels
        for idx = 1:size(bindwidth, 2)
            [KD, KM] = GaussianKernel(Y_temp', bindwidth(idx), bindwidth(idx));
            KM(logical(eye(size(KM)))) = 0;
            KD(logical(eye(size(KD)))) = 0;
            AM(size(AM, 2) + 1) = {KM};
            AD(size(AD, 2) + 1) = {KD};
        end  
        
        F = MultiKernelLearning(AM, AD, Y_temp);
        
        % output the final score
        filename = sprintf('output/lodocv/%d.txt', curIndex);
        fp = fopen(filename, 'w');
        fprintf(fp, '%s\t%s\n', 'label', 'score');
        for i = 1:nm
            fprintf(fp, '%d\t%e\n', Y(i, curIndex), F(i, curIndex));
        end
        fclose(fp);
    end

end