function sparse_map(origin_TF)
figure()
pts_p = apply_H(origin_TF{2}.H, origin_TF{2}.inl);
scatter(pts_p(1,:),pts_p(2,:),'.')
hold on

for i = 3:length(origin_TF)
   pts_p = apply_H(origin_TF{i}.H, origin_TF{i}.inl);
   scatter(pts_p(1,:),pts_p(2,:),'.')
end