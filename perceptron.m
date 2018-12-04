% number of datasets
P = 40;
% feature dimensions
N = 20;
% epochs
n = 50;
% max epochs
nmax = 100;
% weights' initialization
w = zeros(1, N);
% generate features PxN matrix and labels in 1xP vector
features = rnd_feature_gen(P, N);
labels = rnd_label_gen(P);
% for every training epoch
for epoch = 1:nmax
    % for every dataset
    for t = 1:P
       % cacl E
       E = transpose(w)*(features(t,:))*labels(t);
       % decide based on E, how to update the weights
       if E <= 0
           w = w + (1/N).*features(t,:)*labels(t);
       end
    end    
end
fprintf("After %d epochs the weights are: \n", epoch);
w