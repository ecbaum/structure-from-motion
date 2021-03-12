function imgs = read_data(name)
addpath('Functions')

path1 = ['Data/' name '/'];

N = 6;

imgs = cell(1,N);

if strcmp(name, 'boat')
    extension = '.pgm';
else
    extension = '.ppm';
end

for i = 1:N
    image_name = [path1, 'img', num2str(i), extension];
    imgs{i} = read_as_grayscale(image_name);
end

end