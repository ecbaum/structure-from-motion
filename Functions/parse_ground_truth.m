function ground_truth = parse_ground_truth(name)

N = 6;

ground_truth = cell(1,N-1);

path1 = ['Data/' name '/'];


for i = 2:N
    filename = [path1, 'H1to', num2str(i), 'p.txt'];
    gt.H = str2num(fileread(filename));
    gt.idx = i;
    ground_truth{i-1} = gt;
    clear gt;
end

