function img = read_as_grayscale(path_to_file)
    img = mean(im2double(imread(path_to_file)),3);
end
