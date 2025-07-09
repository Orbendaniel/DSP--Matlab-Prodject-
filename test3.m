%part 3 - audio signal 
fs = 16000;           % sampling rate
N  = 2^16;            % number of samples
%{
rec = audiorecorder(fs, 16, 1);     % 16-bit, mono
recordblocking(rec, N/fs);          % record N samples = N/fs seconds
x = getaudiodata(rec);              % x is N×1 vector
filename = 'myRecording3.wav';
audiowrite(filename, x, fs);
% Play it
sound(x, fs);   % fs is your 16 000 Hz sampling rate
%
%}

d1=0.323132571;
d=0.148346148;
w1=1.6 +0.1*d1;
w2=1.6 +0.1*d;
w3=3;

[xn, fs] = audioread('myRecording2.wav');
%Calculating the average power of the signal formally
Pn= sum(xn.^2,1)/N;

%Calculating the average power of the signal using the value of the fft at
%f=1
%{
X=fft(xn.^2);
Pn_F=X(1)/N;
%}

n = (0:N-1).';                        % column index 0..N–1
zn = 10*sqrt(Pn) .* (cos(w1*n) + cos(w2*n) + cos(w3*n));

%define input signal
yn=xn+zn;

%plotting yn
t = (0:N-1)/fs; % define the time axis in seconds
figure;
plot(t, yn);
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy Signal y[n] = x[n] + z[n]');
%xlim([0, N/fs]);   % if we want to plot only a part of the signal 

Yf=fft(yn);

%sample Yf
idx_s = 1:512:N;
Ysub = Yf(idx_s);

%swap between the first N/2 values of Ysub and the last N/2 values
L = length(Ysub);
half = L/2;
Ysub_shifted = [Ysub(half+1 : L); Ysub(1 : half)];

wdx = -(64*2*pi)/128:(2*pi)/128:(63*2*pi)/128;
figure;
plot(wdx, abs(Ysub_shifted));
xlabel('Frequency (2pi*Hz)');
ylabel('Amplitude');
title('Y(exp(jw))');

%%plotting y2n in the time domain

idx_dec =1:2:N;
yn_dec=yn(idx_dec);
Yf_dec=fft(yn_dec);
idx_s_dec = 1:256:N/2;
Ysub_dec = Yf_dec(idx_s_dec);
L_dec = length(Ysub_dec);
half_dec = L_dec/2;
Ysub_shifted_dec = ([Ysub_dec(half_dec+1 : L_dec); Ysub_dec(1 : half_dec)]);
figure;
%dont forget normalization by 2
plot(wdx, abs(Ysub_shifted_dec/2));
xlabel('Frequency (2pi*Hz)');
ylabel('Amplitude');
title('Y2(exp(jw))');

%plotting y2n in the time domain
t = (0:(N-1)/2)/(fs/2); % define the time axis in seconds
figure;
plot(t, yn_dec);
xlabel('Time (s)');
ylabel('Amplitude');
title('Noisy decimated Signal y2[n] = x[n] + z[n]');
%sound(yn, fs)


