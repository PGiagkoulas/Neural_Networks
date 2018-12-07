function labels = rnd_label_gen(P)
    labels = randn([1 ceil(P)]);
    labels(labels<0) = -1;
    labels(labels>=0) = 1;
end

