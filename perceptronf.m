function perceptronf(nrofdatasets,maxepoch,minA,maxA,stepA,ns)
%PERCEPTRONF Will use perceptron to measure the number of successes
%nrofdatasets How many independent datasets will be used
%maxepoch Maximum number of epochs the perceptron will run
%minA The minimum value of alpha
%maxA The maximum value of alpha
%stepA How much A will increase per step
%bs The number of N's the perceptron will use ([5 20 100] for example)

% Stores the plots
plotx = [];
ploty = [];

% Parametrize P based on different values of a
all_a = minA:stepA:maxA;

% For all dimensions in range
for N = ns
    % Stores the accumulated successes for given parameter settings
    all_successes = zeros(1, length(all_a));
    
    % For all different number of points
    for a = all_a
        % Generate a*N number of points
        P = a*N;
        
        % Initialize successes of current a among the nrofdatasets different
        % randomly generated datasets
        successes = 0;
        
        % nrofdatasets datasets with these configurations
        for set = 1:nrofdatasets
            % Generate features PxN matrix and labels in 1xP vector
            features = rnd_feature_gen(round(P), N);
            labels = rnd_label_gen(round(P));
            
            % Initialize weights
            w = zeros(1, N);
            
            % Initialize local potentials
            all_e = zeros(1, round(P));
            
            % Counts the number of epochs
            epoch = 1;
            
            % Train for maxepoch epochs or until all E are positive
            while epoch<=maxepoch && (length(all_e(all_e>0)) < round(P))
                % For every point
                for t = 1:round(P)
                   % Calculate E
                   all_e(t) = w*(transpose(features(t,:)))*labels(t);                  
                   % Decide based on E, how to update the weights
                   if all_e(t) <= 0
                       w = w + (1/N).*features(t,:)*labels(t);
                   end                  
                end            
                % Increase the epoch
                epoch = epoch +1;
            end
            % Check if training with given parameters N, P, nrofdatasets(i) succeeded
            if length(all_e(all_e>0))== round(P)
               successes = successes + 1; 
            end
        end
        all_successes(all_a == a) = successes;
    end
    
    % For debugging purposes
    fprintf("============== \n")
    fprintf("For N = %d \n", N);
    for i = 1:length(all_a)
        fprintf("For a = %f we have %d successes \n",all_a(i),all_successes(i));
    end
    
    % Store the data for later plot-usage
    plotx = [plotx;all_a];
    ploty = [ploty;(all_successes/nrofdatasets)];
end

% Generate a plot for all N
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

end

