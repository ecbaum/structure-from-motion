function sparse_map(origin_TF)
figure()
pts_p1 = apply_H(origin_TF{1}.H, origin_TF{1}.pts);
scatter(pts_p1(1,:),pts_p1(2,:),'.')
Legend = cell(1,6);
Legend{1} = num2str(origin_TF{1}.idx_from);
hold on
for i = 2:length(origin_TF)
   pts_p = apply_H(origin_TF{i}.H, origin_TF{i}.pts);
   scatter(pts_p(1,:),pts_p(2,:),'.')
   Legend{i} = [num2str(origin_TF{i}.idx_from) '->' num2str(origin_TF{1}.idx_from)];
end
legend(Legend)