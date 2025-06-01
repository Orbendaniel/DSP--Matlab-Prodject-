% x = [1,2,4,8];
% xr = IFFT_ALG(FFT_ALG(x));
% disp(xr);
% 
% %part ד
% N  = 32;
% M  = 64;
% B1 = 7;
% B2 = 7;
% 
% x = zeros(N, M);
% x(1:B1, 1:B2) = 1;
% 
% figure;
% imagesc(x);
% axis equal tight;
% xlabel('m');
% ylabel('n');
% title('x[n,m]');
% colorbar;

% % compute its 2-D DFT using your FFT2_ALG
% X_alg = FFT2_ALG(x);
% 
% % visualize the magnitude 2D
% figure;
% imagesc(abs(X_alg));
% axis equal tight;
% xlabel('k_2');
% ylabel('k_1');
% title('X[k1,k2] via FFT2ALG');
% colorbar;
% 
% % visualize the magnitude 3D 
% [K1, K2] = meshgrid(0:M-1, 0:N-1);
% figure;
% surf(K2, K1, abs(X_alg));
% shading interp;
% xlabel('k_2');
% ylabel('k_1');
% zlabel('|X[k_1,k_2]|');
% title('3D Surface of 2D DFT Magnitude');

[dist_image_1,dist_image_2,noised_image,imp_resp_image]=img_gen('IDO','ALON');
figure;
subplot(2,2,1);
imshow(dist_image_1, []);
title('dist\_image\_1');

subplot(2,2,2);
imshow(dist_image_2, []);
title('dist\_image\_2');

subplot(2,2,3);
imshow(noised_image, []);
title('noised\_image');

subplot(2,2,4);
imshow(imp_resp_image, []);
title('imp\_resp\_image');