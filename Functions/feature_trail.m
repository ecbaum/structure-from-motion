%function feature_trail(corrs_links)
trail = [];

link = corrs_links{5};
next_idx = link.idx_to;


pt_idx = 6;

pt_idx_from = link.corrs_from(pt_idx);

H = link.H_from_to_origin;
trail = [trail, apply_H(H,link.pts_from(:,pt_idx_from))];

while true
    pt_idx_to = link.corrs_to(pt_idx);
    
    
    for i = 1:length(corrs_links)
        break_while = false;
        link = corrs_links{i};
        if link.idx_from == next_idx
            next_idx = link.idx_to;
            break;
        end
        break_while = true;
    end
    
    if break_while
        break
    end
    
    for pt_idx = 1:length(link.corrs_from)
        if link.corrs_from(pt_idx) == pt_idx_to
            break;
        end
    end
    
    pt_idx_from = link.corrs_from(pt_idx);
    H = link.H_from_to_origin;
    trail = [trail, apply_H(H,link.pts_from(:,pt_idx_from))];
end

trail