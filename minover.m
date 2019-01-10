clear;clc;
N = 10; % dimensionality
P = 15; % number of examples
learning_rate = 0.001; % standard learning rate for weights
max_epochs = 50; % maximum number of training epochs

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
while (epoch < P*max_epochs) && (dw > 0.001)
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




