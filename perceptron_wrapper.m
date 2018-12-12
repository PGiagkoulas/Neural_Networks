% Clear the workspace and command window
clear; clc;

% Nr of independent datasets
n = 50;

% Maximum number of epochs
maxepoch = 200;

% Parametrize P based on different values of a
amin = 0.75;
amax = 3;
astep = 0.25;

% Feature dimensions range
ns = [5 20 100];

% Perform the perceptron function
perceptronf(50,maxepoch,amin,amax,astep,ns);