function vis_pts(origin_TF)
    figure()
    subplot(2,3,1)
    
   scatter(origin_TF{1}.inl(1,:),origin_TF{1}.inl(2,:),'x','linewidth',1)
   title('origin')
   for i = 2:length(origin_TF)
       subplot(2,3,i)
       scatter(origin_TF{1}.inl(1,:),origin_TF{1}.inl(2,:),'x','linewidth',1)
       hold on
       pts_p = apply_H(origin_TF{i}.H, origin_TF{i}.inl);
       scatter(pts_p(1,:),pts_p(2,:),'.')
       title(num2str(i))
   end

end