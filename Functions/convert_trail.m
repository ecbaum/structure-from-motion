function struct = convert_trail(trail, origin_TF)



TF_idx = zeros(1,6);

for i = 1:length(origin_TF)
    TF_idx(origin_TF{i}.idx_from) = i;
end

P_m = trail.pos;

H_list = cell(0,0);
P_list = cell(0,0);
P_proj = cell(0,0);
img_idx = [];


for i = 1:length(origin_TF)
    idx = trail.idx_list(i);
    if idx ~= 0
        H = origin_TF{TF_idx(i)}.H;
        if isequal(H,eye(3))
            continue
        end
        P = origin_TF{TF_idx(i)}.pts(:,idx);
        H_list = [H_list, {H}];
        P_list = [P_list, {P}];
        P_proj = [P_proj,{apply_H(H,P)}];
        img_idx = [img_idx, TF_idx(i)];
    end
end

struct.P_m = P_m;
struct.H_list = H_list;
struct.P_list = P_list;
struct.P_proj = P_proj;
struct.img_idx = img_idx;
struct.TF_idx = TF_idx;



