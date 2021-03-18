%function feature_trail(corrs_links)

origin = origin_TF{1}.idx_from;

feat_trails = cell(0,0);

feat_trail = cell(0,0);

for i = 1:length(corrs_links)
    link0 = corrs_links{i}; 
    
    for idx0 = 1:length(link0.corrs_from)

        trail = [];

        idx = idx0;
        link = link0;
        idx_list = zeros(1,6);

        idx_corr = link.corrs_from(idx);
        P = apply_H(link.H_from_to_origin,link.pts_from(:,idx_corr));

        trail = [trail, P];
        idx_list(link.idx_from) = idx;

        while true
            idx_corr = link.corrs_to(idx);
            P = apply_H(link.H_to_to_origin,link.pts_to(:,idx_corr));
            trail = [trail, P];
            idx_list(link.idx_to) = idx;
            
            if link.idx_to == origin
                break;
            end

            for j = 1:length(corrs_links)
                break_while = true;
                link2 = corrs_links{j};
                if link2.idx_from == link.idx_to
                    break_while = false;
                    break;
                end
            end

            if break_while
                break
            end

            for idx2 = 1:length(link2.corrs_from)
                break_while = true;
                if link2.corrs_from(idx2) == idx_corr
                    break_while = false;
                    break;
                end
            end

            if break_while
                break
            end

            link = link2;
            idx = idx2;
        end
        
        if size(trail,2) >= 3
            tr.trail = trail;
            tr.idx_list = idx_list;
            feat_trail = [feat_trail {tr}];
        end
    end
    feat_trails{i} = feat_trail;
end  

















