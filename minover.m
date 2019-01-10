clear;clc;
N = 10; % dimensionality
all_P = 10:10:500; % number of examples
n_d = 10; % number of datasets for every P
learning_rate = 1/N; % standard learning rate for weights
max_epochs = 100; % maximum number of training epochs
all_gen_err = zeros([1 length(all_P)]);
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
figure('Name', 'Error curve')
plot(all_P, all_gen_err)
xlabel('P')
ylabel('Error rate')


