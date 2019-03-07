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

 globalPosition = GetGlobalPosition(A, D, miR_disease_matrix, pIndex);

save('output/globalPosition.mat', 'globalPosition');

