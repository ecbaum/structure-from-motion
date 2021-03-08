function [coords, descriptors] = extractSIFT(img, upright)
% This functions builds SIFT-descriptors around interest points defined by
% input varaible points.
% INPUT:
% img - the grayscale image. 
% OUTPUT:
% coords - a 2xM matrix containing point data [row; column; scale;
% orientation].
% descriptors - a 128xM matrix, where the i-th column is the
% SIFT-descriptor for the i-th point in output frames.
%
% This file is based on VLSIFT-functions.

if nargin < 2
	upright = false;
end

% Set up image.
img = single(img) / max(img(:));

% Perform extraction
[coords, descriptors] = vl_sift(img, 'PeakThresh',0.003);

if upright
    coords(4,:)=0;
	[coords,descriptors] = vl_sift(img, 'Frames', coords,'PeakThresh',0.003);
end	
coords = coords([1 2],:);

% Normalize descriptors.
descriptors = single(descriptors);
for i = 1:size(descriptors,2)
    nn = norm(descriptors(:,i));
    if (nn > 0)
    	descriptors(:,i) = descriptors(:,i)/nn;
    end
end


