function labels = rnd_label_gen(P)
    labels = randn([1 P]);
    labels(labels<0) = -1;
    labels(labels>=0) = 1;
end

