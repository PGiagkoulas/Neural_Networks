clear;clc;
all_N = [5 15 50 100]; % dimensionality
a = 0.5:0.1:5; % values of alpha to test the generalization error on
n_d = 20; % number of datasets for every P
max_epochs = 350; % maximum number of training epochs
%{
for minover_gen_err_better:
all_N = [5 15 50 100];
a = 0.5:0.1:5;
n_d = 20;
max_epochs = 350;
%}
figure('Name', 'Error curve');
% test on different N
for N=all_N
    all_P = N*a; % number of examples
    learning_rate = 1/N; % standard learning rate for weights
    all_gen_err = zeros([1 length(all_P)]); % initialize generealization errors per value of P
    % for different P values
    for i=1:length(all_P)
        P = all_P(i);
        % initialize errors for current P
        gen_err = zeros([1 n_d]);
        % for n_d number of datasets
        for set = 1:n_d
            % randomly generated examples
            examples = rnd_feature_gen(P, N);
            % teacher-generated labels
            labels = teacher_label_gen(examples);
            % initialize weight vector
            w = examples(1,:);
            % initialize weight change high
            dw = 1;
            % initialize training epochs
            epoch = 0;
            while (epoch < max_epochs) && (dw > 0.001)
                % calculate examples' stabilities 
                k = w*transpose(examples).*labels;
                % calculate perceptron's stability (min of examples' stabilities)
                [min_val, min_ind] = min(k);
                % store previous weight
                prev_w = w;
                % Hebbian step with example of minimum stability
                w = w + learning_rate*examples(min_ind, :)*labels(min_ind);
                % normalize
                % store weight change
                dw = abs(norm(w) - norm(prev_w));
                % increment epochs
                epoch = epoch + 1;
            end
            teach = ones([1 N]);
            gen_err(set) = acos( ( w*transpose(teach) ) / ( norm(w)*norm(teach) ) ) / pi;
        end
        % average of errors for current P, over n_d datasets
        all_gen_err(i) = sum(gen_err)/n_d;
    end
    plot(a, all_gen_err);
    hold on;
end
title('Generalization error ')
xlabel('\alpha');
ylabel('Error rate');
legend('N=5', 'N=15', 'N=50', 'N=100', 'Location', 'southwest');

