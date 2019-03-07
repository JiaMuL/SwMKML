function [S, K] = miniJob(viewWeight, mvMatrix, F, alpha, beta)

    num = size(mvMatrix{1}, 1);
    viewNum = size(viewWeight, 2);
    
%     Initialize the kernel matrix
    KernelMatrix = zeros(num);
    for v = 1:viewNum
        KernelMatrix = KernelMatrix + viewWeight(v) * mvMatrix{v};
    end
    
    G = L2_distance_1(F', F');
%     Update S
    S = zeros(num); % S is the optimal matrix to be learned
    for i = 1:num
        S(i,:) = (eye(num) + KernelMatrix) \ (KernelMatrix(:,i) - alpha * G(:,i) / 4);
    end
     
%     Update K
    K = (2 * S' - S * S' - eye(num) + 2 * beta * KernelMatrix) / (2 * beta * sum(viewWeight));
    
end


   