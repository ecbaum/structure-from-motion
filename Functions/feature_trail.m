function feat_trails = feature_trail(corrs_links, origin_TF)

origin = origin_TF{1}.idx_from;

feat_trails = cell(0,0);

for i = 1:length(corrs_links)
    link0 = corrs_links{i}; 
    
    for idx0 = 1:length(link0.corrs_from)

        trail = [];

        idx_corr = idx0;
        link = link0;
        idx_list = zeros(1,length(origin_TF));

        idx_SIFT = link.corrs_from(idx_corr);
        P = apply_H(link.H_from_to_origin,link.pts_from(:,idx_SIFT));

        trail = [trail, P];
        idx_list(link.idx_from) = idx_SIFT;

        while true
            idx_SIFT = link.corrs_to(idx_corr);
            P = apply_H(link.H_to_to_origin,link.pts_to(:,idx_SIFT));
            trail = [trail, P];
            idx_list(link.idx_to) = idx_SIFT;
            
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
                if link2.corrs_from(idx2) == idx_SIFT
                    break_while = false;
                    break;
                end
            end

            if break_while
                break
            end

            link = link2;
            idx_corr = idx2;
        end
        
        tr = [];
        if size(trail,2) >= 3
            tr.trail = trail;
            tr.idx_list = idx_list;
        end
        
        if isempty(tr)
            continue;
        end
        
        match = false;
        
        for j = 1:length(feat_trails)
            feat_trail_cmp = feat_trails{j}; % To compare wth
            
            for k = 1:length(feat_trail_cmp.idx_list)
                if feat_trail_cmp.idx_list(k) == tr.idx_list(k) && tr.idx_list(k) ~= 0
                    match = true;
                    break;
                end
            end

            if match
                trail_sum = [tr.trail, feat_trail_cmp.trail].';
                feat_trails{j}.trail = unique(trail_sum,'rows').';

                for k = 1:length(tr.idx_list)
                    if tr.idx_list(k) ~= feat_trail_cmp.idx_list(k)
                        feat_trails{j}.idx_list(k) = tr.idx_list(k);
                    end
                end
                break;
            end 
        end
        if ~match && ~isempty(tr)
            feat_trails = [feat_trails, {tr}];
        end
    end
end  

for i = 1:length(feat_trails)
    feat_trails{i}.pos = mean(feat_trails{i}.trail,2);
end

