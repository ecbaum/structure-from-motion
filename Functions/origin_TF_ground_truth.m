function origin_TF_GT = origin_TF_ground_truth(origin_TF, ground_truth)


% structure of the ground truth is H from image1 to all other
% we can use image1 as a gate to all other images

origin = origin_TF{1}.idx_from; % First element transform from origin to origin with H = eye(3);

if origin == 1 
    to_origin = eye(3);
    
    for i = 1:length(ground_truth)
        ground_truth{i}.H = inv(ground_truth{i}.H);
    end
    
else % Flip direction of all H which doesnt lead to origin, so it goes from idx -> 1
     % save transform from 1 -> origin as to_origin
     % that way one can apply to_origin*inv(H) for anyone to get to origin
     % in case origin == 1, flip all and set to_origin eye(3)
    for i = 1:length(ground_truth)
        if ground_truth{i}.idx ==  origin
            to_origin = ground_truth{i}.H;
        else
            ground_truth{i}.H = inv(ground_truth{i}.H);
        end
    end
end

origin_TF_GT = origin_TF;

for i = 2:length(origin_TF) % Reassign the H to be the ground truth to origin
    from = origin_TF{i}.idx_from;
    if from == 1
        gt_T = eye(3);
    else
        gt_T = ground_truth{from-1}.H;
    end
    origin_TF_GT{i}.H = to_origin*gt_T;
end


