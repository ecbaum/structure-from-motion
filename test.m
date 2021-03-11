clear all; clc

addpath('Functions'); addpath('sift')
imgs = read_data('wall');

img_hom = homography_estimation_images(imgs, 0.5, 3);






















