% FFT EXAMPLE
% x = [1,2,4,8];
% xr = IFFT_ALG(FFT_ALG(x));
% disp(xr);

%{
% %part ד
N  = 32;
M  = 64;
B1 = 7;
B2 = 7;

x = zeros(N, M);
x(1:B1, 1:B2) = 1;

figure;
imagesc(x);
axis equal tight;
xlabel('m');
ylabel('n');
title('x[n,m]');
colorbar;

% compute its 2-D DFT using your FFT2_ALG
X_alg = FFT2_ALG(x);

% visualize the magnitude 2D
figure;
imagesc(abs(X_alg));
axis equal tight;
xlabel('k_2');
ylabel('k_1');
title('X[k1,k2] via FFT2ALG');
colorbar;

% visualize the magnitude 3D 
[K1, K2] = meshgrid(0:M-1, 0:N-1);
figure;
surf(K2, K1, abs(X_alg));
shading interp;
xlabel('k_2');
ylabel('k_1');
zlabel('|X[k_1,k_2]|');
title('3D Surface of 2D DFT Magnitude');
%}

%part ה
[dist_image_1,dist_image_2,noised_image,imp_resp_image]=img_gen('IDO','ALON');
figure;
y1 = dist_image_1;
subplot(2,2,1);
imshow(y1, []);
title('y1[n,m]');

subplot(2,2,2);
y2 = dist_image_2;
imshow(y2, []);
title('y2[n,m]');

subplot(2,2,3);
y3 = noised_image;
imshow(y3, []);
title('y3[n,m]');

subplot(2,2,4);
h = imp_resp_image;
h0 = h(:,1);
disp(h0)
imshow(imp_resp_image, []);
title('imp\_resp\_image');

%{%
%part ו
pad_h0 = zeros(6,1);
for i = 1:6
    if i< 4
        pad_h0(i) = h0(i);
    else
        pad_h0(i) = 0;
    end
end
pad_H0 = fft(pad_h0);
H0 = zeros(4,1);
for i = 1:3
        H0(i) = pad_H0(i);
end
H0(4) = pad_H0(5);

disp(H0)
%}%

%{
% %part ז
% cyclic convelution - by fft
pad1_h0 = zeros(32,1);
for i = 1:32
    if i< 4
        pad1_h0(i) = h0(i);
    else
        pad1_h0(i) = 0;
    end
end


w = zeros(32,1);
w(1) = 1;
w(30) = 1;
H0_pad1 = fft(pad1_h0);
W = fft(w);
Z = H0_pad1.*W;
z = ifft(Z);

n = 1:1:32;      
    

plot(n, z);           
title('cyclic convolution (32) of w and h0');   
xlabel('n');          
ylabel('w*h0');   
grid on;             

% cyclic convelution - by definiton
n = 1:32;
delta0 = (n == 1);      % שקול ל-n==0 באינדוקס מ-1
delta29 = (n == 30);    % שקול ל-n==29
x = delta0 + delta29;   % כניסת דלתא


cyclic = zeros(1, 32);  % נאתחל את התוצאה

for j = 1:32
    for i = 1:32
        cyclic(j) = cyclic(j) + pad1_h0(mod(j - i, 32) + 1) * x(i);
    end
end

% הצגה
x_axis = 1:32;
plot(x_axis, cyclic, 'o-');
title('Cyclic Convolution (length 32) of delta0 + delta29 and h0');
xlabel('n');
ylabel('Result');
grid on;
figure;
plot(1:32, cyclic, 'o-', 'DisplayName', 'Manual Cyclic Convolution'); hold on;
plot(1:32, real(z), 'x--', 'DisplayName', 'FFT-based Convolution');
title('Comparison of Cyclic Convolution (Length 32)');
xlabel('n');
ylabel('Output');
legend;
grid on;
%}
%part ח

pad_h1 = zeros(128,128);
for i = 1:128
    for j = 1:128
        
        if i< 4 && j < 6
            pad_h1(i,j) = h(i,j);
        else
            pad_h1(i,j) = 0;
        end
    end
end

pad_h2 = zeros(70,170);
for i = 1:70
    for j = 1:170
        
        if i< 4 && j < 6
            pad_h2(i,j) = h(i,j);
        else
            pad_h2(i,j) = 0;
        end
    end
end


pad_H1 = FFT2_ALG(pad_h1);
pad_H2 = FFT2_ALG(pad_h2);
Y1 = FFT2_ALG(y1);
Y2 = FFT2_ALG(y2);
X1r = Y1./pad_H1;
X2r = Y2./pad_H2;
x1r = IFFT2_ALG(X1r);
x2r = IFFT2_ALG(X2r);

subplot(2,1,1);
imshow(x1r, []);
title('x1[n,m]');

subplot(2,1,2);
imshow(x2r, []);
title('x2[n,m]');


