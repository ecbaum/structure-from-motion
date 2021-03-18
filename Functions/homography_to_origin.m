function [origin_TF, corrs_links] = homography_to_origin(img_hom)


origin = img_hom{1}.idx_to;         % Select origin

disp([newline 'Calculating homografy paths to global origin'])
disp(['img' num2str(img_hom{1}.idx_to) ' selected as origin'])

% Manually add the first two.

TF.idx_from = img_hom{1}.idx_to;
TF.H = eye(3);
TF.route = [origin];
TF.pts = img_hom{1}.pts_to;
origin_TF = {TF};

TF.idx_from = img_hom{1}.idx_from;  % origin_TF is a list from transforms
TF.H = img_hom{1}.H;                % from an image index to origin
TF.route = [origin, img_hom{1}.idx_from];
TF.pts = img_hom{1}.pts_from;

origin_TF = [origin_TF, {TF}];                   % here we add the index from the first hom



corrs_link.idx_from = img_hom{1}.idx_from;
corrs_link.corrs_from = img_hom{1}.inlier_corrs(1,:);
corrs_link.pts_from = img_hom{1}.pts_from;
corrs_link.H_from_to_origin = origin_TF{1}.H;
corrs_link.idx_to = img_hom{1}.idx_to;
corrs_link.corrs_to = img_hom{1}.inlier_corrs(2,:);
corrs_link.pts_to = img_hom{1}.pts_to;
corrs_link.H_to_to_origin = origin_TF{1}.H;

corrs_links = {corrs_link};


included_image_indices = [img_hom{1}.idx_to, img_hom{1}.idx_from]; % Store some necessary information
disp(['img' num2str(TF.idx_from) ':   inl. to ' num2str(origin) ': ' num2str(img_hom{1}.num_inliers) ',    path: ' num2str(origin)])


N = 0;
for k = 1:length(img_hom) % Get the number of images
    if img_hom{k}.idx_from > N
        N = img_hom{k}.idx_from;
    end
    if img_hom{k}.idx_to > N
        N = img_hom{k}.idx_to;
    end
end

for k = 1:N-2
    for i=1:length(img_hom) % Select first index which has some transform from outside to included_image_indices
        hom = img_hom{i};   % because img_hom is sorted according to inliers the first selected will have the most

        to_in_self = ismember(hom.idx_to, included_image_indices);
        from_in_self = ismember(hom.idx_from, included_image_indices);

        if xor(to_in_self,from_in_self)
            break;
        end
    end

    if from_in_self          % Establish where we came from and where we are going
        H = inv(hom.H);      % and which way the transform is 
        connection_to = hom.idx_from;
        connection_from = hom.idx_to;
        pts_from = hom.pts_to;
        pts_to = hom.pts_from;
        
        corrs_from = hom.inlier_corrs(2,:);
        corrs_to = hom.inlier_corrs(1,:);
    else
        H = hom.H;
        connection_to = hom.idx_to;
        connection_from = hom.idx_from;
        pts_from = hom.pts_from;
        pts_to = hom.pts_to;
        
        corrs_from = hom.inlier_corrs(1,:);
        corrs_to = hom.inlier_corrs(2,:);
    end



    for i = 1:length(origin_TF)      % Find a transform from the connection to origin
        if origin_TF{i}.idx_from == connection_to
            route = origin_TF{i}.route;
            H_origin = origin_TF{i}.H*H; % Calculate a transform to origin from current image
            break;
        end
    end
    included_image_indices = [included_image_indices, connection_from];
    TF.idx_from = connection_from;  
    TF.H = H_origin; 
    TF.route = [route, connection_from];
    TF.pts = pts_from;
    origin_TF = [origin_TF {TF}];
    
    
    corrs_link.idx_from = connection_from;
    corrs_link.corrs_from = corrs_from;
    corrs_link.pts_from = pts_from;
    corrs_link.H_from_to_origin = H_origin;
    corrs_link.idx_to = connection_to;
    corrs_link.corrs_to = corrs_to;
    corrs_link.pts_to = pts_to;
    corrs_link.H_to_to_origin = origin_TF{i}.H;
    
    corrs_links = [corrs_links, corrs_link];
    
    route_str = sprintf('%.0f,' , flip(route)); route_str = route_str(1:end-1);
    disp(['img' num2str(connection_from) ':   inl. to ' num2str(connection_to) ': ' pad([num2str(hom.num_inliers),','],5) '    path: ' route_str])
    
end



