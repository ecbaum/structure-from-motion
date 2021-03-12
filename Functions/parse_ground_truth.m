function ground_truth = parse_ground_truth(name)

N = 6;

ground_truth = cell(1,N-1);

path = ['Data/' name '/'];


for i = 2:N
    filename = [path, 'H1to', num2str(i), 'p.txt'];
    
    gt.H = str2num(fileread(filename));
    gt.idx = i;
    ground_truth{i-1} = gt;
end

