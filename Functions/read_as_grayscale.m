function img = read_as_grayscale(path_to_file)
    img = mean(read_image(path_to_file),3);
end
