clear 
clc
% number of datasets
P = 100;
% feature dimensions
N = 80;
% epochs
n = 50;
% max epochs
nmax = 100;
% weights' initialization
w = zeros(1, N);
% generate features PxN matrix and labels in 1xP vector
features = rnd_feature_gen(P, N);
labels = rnd_label_gen(P);
epoch = 0;
all_e = zeros(1, P);
% until you have trained for nmax epochs or all E are positive
while epoch<=nmax && (length(all_e(all_e>0)) < P)
    pos_e = 0;
    epoch = epoch +1;
    % for every dataset
    for t = 1:P
       % cacl E
       all_e(t) = w*(transpose(features(t,:)))*labels(t);
       % decide based on E, how to update the weights
       if all_e(t) <= 0
           w = w + (1/N).*features(t,:)*labels(t);
       end
    end
end
fprintf("After %d epochs the weights are: \n", epoch);
w