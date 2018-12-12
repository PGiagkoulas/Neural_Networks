% Clear the workspace and command window
clear; clc;

% Nr of independent datasets
nd = 500;

% Maximum number of epochs
nmax = 500;

% Parametrize P based on different values of a
amin = 0.75;
amax = 3;
astep = 0.25;

% Feature dimensions range
ns = [5 20 50 100];

% Perform the perceptron function
perceptronf(nd,nmax,amin,amax,astep,ns);