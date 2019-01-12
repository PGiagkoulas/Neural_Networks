function labels = teacher_label_gen(features)
    % for the number of features
    num_of_features = size(features,2);
    % initialize teacher weights
    teacher = ones([1 num_of_features]);
    % calculate labels using sign()
    labels = sign(teacher*transpose(features));
end

