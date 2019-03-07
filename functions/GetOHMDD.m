function GetOHMDD(AM, AD, Y, trainingMatrix)
    
    nm = size(Y, 1);
    nd = size(Y, 2);

    bindwidth = [0.01, 0.1, 1, 5, 10, 50, 100];
    
    % compute a set of Gaussian Interaction Profile kernels
    for idx = 1:size(bindwidth, 2)
        [KD, KM] = GaussianKernel(trainingMatrix', bindwidth(idx), bindwidth(idx));
        KM(logical(eye(size(KM)))) = 0;
        KD(logical(eye(size(KD)))) = 0;
        AM(size(AM, 2) + 1) = {KM};
        AD(size(AD, 2) + 1) = {KD};
    end    

    F = MultiKernelLearning(AM, AD, trainingMatrix);
    
    % output the final score
    filename = 'output/ohmdd.txt';
    fp = fopen(filename, 'w');
    fprintf(fp, '%s\t%s\n', 'label', 'score');
    for i = 1:nm
        for j = 1:nd
            if trainingMatrix(i, j) ~= 1
                fprintf(fp, '%d\t%e\n', Y(i, j), F(i, j));
            end
        end
    end
    fclose(fp);
    
end