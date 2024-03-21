%% MainHV 
% HVEdges detection est conçu précisément aux images non traitées par la
% méthode de remplissage de zones connexes 
%% Main function 

clear all; close all; clc;

path = "./base/car6.jpg"

% Pre_process
[Igray, Idilate] = pre_process(path);
% Horizontal Edges 
[I, horz, max_horz] = processHorizontalEdges(Idilate);
% Vertical Edges
[I, vert, maximum, max_vert] = processVerticalEdges(I);
% Trouver la region d'interet 
[rows, cols] = size(I);
[I,column, row] = FindProbableRegion(I,horz, vert, cols, rows,max_vert,max_horz);
% Post traitement
[imgCropped]= post_process(I,path);
