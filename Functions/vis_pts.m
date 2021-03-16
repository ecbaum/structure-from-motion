function vis_pts(origin_TF,origin_TF_GT)
    figure()    
    subplot(2,3,1)
   
   scatter(origin_TF_GT{1}.pts(1,:),origin_TF_GT{1}.pts(2,:))
   hold on
   scatter(origin_TF{1}.pts(1,:),origin_TF{1}.pts(2,:),'.')
   title('origin')
   
   for i = 2:length(origin_TF)
       subplot(2,3,i)
       pts_GT = apply_H(origin_TF_GT{i}.H, origin_TF_GT{i}.pts);
       scatter(pts_GT(1,:),pts_GT(2,:))
       hold on

       pts = apply_H(origin_TF{i}.H, origin_TF{i}.pts);
       scatter(pts(1,:),pts(2,:),'.')  
       legend('GT', 'est.')
       title(origin_TF{i}.idx_from)
   end

end