function [F] = GetCaseStudy(AM, AD, Y)
    
    bindwidth = [0.01, 0.1, 1, 5, 10, 50, 100];

    % compute a set of Gaussian Interaction Profile kernels
    for idx = 1:size(bindwidth, 2)
        [KD, KM] = GaussianKernel(Y', bindwidth(idx), bindwidth(idx));
        KM(logical(eye(size(KM)))) = 0;
        KD(logical(eye(size(KD)))) = 0;
        AM(size(AM, 2) + 1) = {KM};
        AD(size(AD, 2) + 1) = {KD};
    end  
        
    F = MultiKernelLearning(AM, AD, Y);
    
end