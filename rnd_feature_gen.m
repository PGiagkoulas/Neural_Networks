% generate dataset. features from N(0,1) and labels of +/-1 with 0.5 probability
function observations = rnd_feature_gen(P, N)
    observations = randn(P, N);
end