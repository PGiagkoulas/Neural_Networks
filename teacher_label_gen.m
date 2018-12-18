function labels = teacher_label_gen(features)
    num_of_features = size(features,2);
    teacher = ones([1 num_of_features]);
    labels = sign(teacher*transpose(features));
end

