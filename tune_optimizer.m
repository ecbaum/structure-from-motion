feat_trails = feature_trail(corrs_links, origin_TF);





%%
n = 0;
m = 0;
esum = 0;
for i = 1:length(feat_trails)
    if length(feat_trails{i}.trail) >= 3
        m = m +1;
        [~,e]=refine_estimation(convert_trail(feat_trails{i},origin_TF,TF_idx), 70, 0.0045, 0.001);
        if e > 0
            n = n+1;
            esum = esum + e;
        end
    end
end
frac = n/m
esum



%% wall
%  70, 0.0045, 0.001
%  

%% graf 
% 3, 0.002, 0.001