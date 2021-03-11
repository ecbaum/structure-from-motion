function fuse = homography_fuse(imgA, imgB, H_AB)

tf = projective2d(H_AB');

imgA_B = imwarp(imgA,tf); % Image A in B coordinate system, but offset

imgA_B_tr = align_images(imgA_B, imgB, 2, 1); % Translated 

fuse = imfuse(imgB,imgA_B_tr,'blend','Scaling','joint');