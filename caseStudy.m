clc;              
clear;            % clear all workspace variables
close all;        % close all windows
  
currentFolder = pwd;              
addpath(genpath(currentFolder));

load('datasets/miR_sim.mat');
load('datasets/disease_sim.mat');
load('datasets/miR_disease.mat');

% set the diagonal elements to 0
miR_sim_matrix(logical(eye(size(miR_sim_matrix)))) = 0;
disease_sim_matrix(logical(eye(size(disease_sim_matrix)))) = 0;

% kernelize both similarity matrices first
method = 'shift';
kern_miR = kernelization(miR_sim_matrix, method);
kern_dis = kernelization(disease_sim_matrix, method);

% construct a cell for convenience
A(1) = {kern_miR};
D(1) = {kern_dis};

predRes = GetCaseStudy(A, D, miR_disease_matrix);
save('output/case_study.mat', 'predRes');
fprintf('Case study process completed.');
