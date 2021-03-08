addpath('Functions')

path1 = 'Data/wall/';

N = 6;

imgs = cell(1,N);

for i = 1:N
    image_name = [path1, 'img', num2str(i), '.ppm'];
    imgs{i} = read_as_grayscale(image_name);
end

clear path1; clear N; clear i; clear image_name;