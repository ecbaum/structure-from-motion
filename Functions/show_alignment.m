function show_alignment(img1,img2,X1,X2)
[H, num_outliers, ratio] = ransac_homography2(X1, X2, 4)
X1p = dehom(H*hom(X1));

tform1 = projective2d(H.');

img1p = imwarp(img1,tform1);

figure()
subplot(2,3,1)
scatter(X2(1,:),X2(2,:))
subplot(2,3,2)
scatter(X1(1,:),X1(2,:),'x')

subplot(2,3,3)
scatter(X2(1,:),X2(2,:))
hold on
scatter(X1p(1,:),X1p(2,:),'x')


subplot(2,3,4)
imshow(img2); hold on; scatter(X2(1,:),X2(2,:))
subplot(2,3,5)
imshow(img1); hold on; scatter(X1(1,:),X1(2,:))

subplot(2,3,6)
imagesc(imfuse(img2,img1p)); hold on; 
scatter(X2(1,:),X2(2,:))
scatter(X1p(1,:),X1p(2,:),'x')
figure()
imagesc(imfuse(img2,img1p))
end