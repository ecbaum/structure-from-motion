clear all; clc

addpath('Functions'); addpath('sift')
read_data

%[pts, descs] = extractSIFT(img); 
%corrs = matchFeatures(descs1', descs2', 'MaxRatio', 0.8, 'MatchThreshold', 100); 
