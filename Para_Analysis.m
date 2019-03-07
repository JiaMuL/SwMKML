clc;              
clear;            % clear all workspace variables
close all;        % close all windows
  
currentFolder = pwd;              
addpath(genpath(currentFolder));

load('datasets/miR_sim.mat');
load('datasets/disease_sim.mat');
load('datasets/miR_disease.mat');

% set the diagonal elements to 0
% go_sim_matrix(logical(eye(size(go_sim_matrix)))) = 0;
% seq_sim_matrix(logical(eye(size(seq_sim_matrix)))) = 0;
miR_sim_matrix(logical(eye(size(miR_sim_matrix)))) = 0;
disease_sim_matrix(logical(eye(size(disease_sim_matrix)))) = 0;

% kernelize both similarity matrices first
method = 'shift';
kern_miR = kernelization(miR_sim_matrix, method);
kern_dis = kernelization(disease_sim_matrix, method);

% construct a cell for convenience
A(1) = {kern_miR};
% A(2) = {go_sim_matrix};
% A(3) = {seq_sim_matrix};

D(1) = {kern_dis};

filename = 'output/parameterAnalysis/Fbeta.txt';  
fp = fopen(filename,'w');
fprintf(fp,'%s\t%s\t%s\n','alpha','gamma','F_AUC');   
for alpha = [0.0001,0.001,0.01,0.1]
    for gamma = [0.01]
      fcvPosition = GetFiveFoldPosition(A, D, miR_disease_matrix, pIndex,alpha,gamma);%fcv_position = Get_fcv_position(siM_D,siM_M,Y, HMDD, X, gama, gama, alpha, alpha, beta, beta,delta);
      F_AUC = Fpositiontooverallauc(miR_disease_matrix, pIndex, fcvPosition);%F_AUC = Fpositiontooverallauc(Y,HMDD,fcv_position);
      fprintf(fp,'%f\t%f\t%f\n',alpha,gamma,F_AUC);   
    end
end
fclose(fp);