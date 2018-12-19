% Clear the workspace and command window
clear; clc;

% Nr of independent datasets
n_d = 50;

% Maximum number of epochs
nmax = 200;

% Parametrize P based on different values of a
all_a = 0.75:.25:3;

% Feature dimensions range
ns = [5 20 100];

% define epsilon for training termination
epsilon = 0.1;

% Stores the plots
plotx = [];
ploty = [];
% FOR LOOP COMMENTED OUT
%{
% For all dimensions in range
for N = ns
    % Stores the accumulated successes for given parameter settings
    all_successes = zeros(1, length(all_a));
    
    % For all different number of points
    for a = all_a
        % Generate a*N number of points
        P = a*N;
        
        % n_d datasets with these configurations
        for set = 1:n_d 
%}
            N = 10;
            P = 5;
            % Generate features PxN matrix and labels in 1xP vector
            features = rnd_feature_gen(round(P), N);
            labels = rnd_label_gen(round(P));
            %initialize first weight to be the first data point to be able to calculate kappa
            w = features(1,:);
            % high prev_w initialization
            prev_w = ones(N).*10;
            % Initialize local potentials
            all_e = zeros(1, round(P));            
            % Counts the number of epochs
            epoch = 0;      
            
            % Train for nmax epochs or until weights "stabilize"
            while epoch<=nmax*P && abs(norm(prev_w - w)) > epsilon
                % calculate kappas for all points given current weights
                kappa = (w*transpose(features).*labels)/norm(w);
                % get minimum kappa = stability of given weights and the
                % point it corresponds to
                [stability, point] = min(abs(kappa));
                % keep previous weight
                prev_w = w;
                % re-calculate weights based on the point of minimum
                % stability
                w = w + (1/N)*features(point,:)*labels(point);
                % Increase the epoch
                epoch = epoch + 1;
                fprintf("Epoch %d \n", epoch);
                w
            end
% FOR LOOP COMMENTED OUT            
%{            
        end
    end
    % Store the data for later plot-usage
    plotx = [plotx;all_a];
    ploty = [ploty;(all_successes/50)];
end
%}
% PLOTS COMMENTED OUT
% Generate a plot for all N
%{
hold on;
[nscolumns, nsrows] = size(ns);
for dimension = 1:nsrows
    linename = sprintf('N = %i',ns(dimension));
    plot(plotx(dimension,:),ploty(dimension,:),'DisplayName', linename);
end
xlim([all_a(1) all_a(end)])
title('Success Rate based on Alpha and number of N')
legend('Location','southwest');
xlabel('Alpha');
ylabel('Success Rate');
hold off;
%}