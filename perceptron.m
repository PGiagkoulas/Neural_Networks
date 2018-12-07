clear 
clc
% feature dimensions are constant
N = 20;
% independent datasets
n_d = 50;
% max epochs
nmax = 100;
% parametrize P based on different values of a
all_a = 0.75:.25:3;
% will store the accumulated successes for given parameter settings
all_successes = zeros(1, length(all_a));
% different number of points
for a = all_a
    % generate number of points
    P = a*N;
    % generate features PxN matrix and labels in 1xP vector
    features = rnd_feature_gen(P, N);
    labels = rnd_label_gen(P);
    % initialize successes of current a among the n_d different
    % randomly generated datasets
    successes = 0;
    % n_d datasets with these configurations
    for set = 1:n_d
        % weights' initialization
        w = zeros(1, N);
        % initialize local potentials
        all_e = zeros(1, ceil(P));
        % initialize epoch counter
        epoch = 0;
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
        % check if training with given parameters N, P, n_d(i) succeeded
        if length(all_e(all_e>0))== P
           successes = successes + 1; 
        end
    end
    all_successes(all_a == a) = successes;
end
for i = 1:length(all_a)
    fprintf("For a = %f we have %d successes \n",all_a(i),all_successes(i));
end
