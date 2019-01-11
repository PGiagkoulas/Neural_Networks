% generate dataset. features from N(0,1)
function observations = rnd_feature_gen(P, N)
    observations = randn(round(P), N);
end