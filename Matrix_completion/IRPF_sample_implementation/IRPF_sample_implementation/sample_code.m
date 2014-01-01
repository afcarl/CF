% This sample code shows how to use Incremented Rank PowerFactorization to
% perform rank-constrained matrix recovery for a couple different cases of
% reconstructing a 512x512 matrix from limited measurements
% (this implementation is not necessarily the fastest IRPF implementation for
% all of these cases -- other versions of IRPF available on request).
%
% Justin Haldar (jhaldar@usc.edu)
% May 21, 2012

clear;
close all;
clc;

%% Load Sample Data for Testing
disp('Loading and Displaying Example Data');
m = 512;
n = 512;
load('./DATA/X.mat');
figure;
set(gcf, 'Position', [0 0 640 640]);
imagesc(X);
title('Original Low Rank Matrix (true rank = 10)');
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
drawnow;

disp('*******************************************');
%% Matrix Completion Example
disp('Random Matrix Completion Example');
% A standard matrix completion example, with random sampling

L = 10;
fract = 3/20;
p = round(m*n*fract);

samplingMask = zeros(m,n);
P = randperm(m*n);
samplingMask(P(1:p)) = 1;

S.type = '()';
S.subs{:} = find(samplingMask);

A = @(X) subsref(X,S);
Ah = @(X) subsasgn(zeros(m,n),S,X);
AhA = @(X) X.*samplingMask;

b =A(X)+randn(p,1)/50;

DataSNR = norm(b)/norm(A(X)-b);

tic
Xrecon = irpf_operator_cg(A, Ah, AhA, b, [m,n], L,L+1);
toc

ReconSNR = norm(X)/norm(X-Xrecon);

figure;
set(gcf, 'Position', [0 0 640 640]);
subplot(2,2,1);imagesc(samplingMask);
title(['Sampling Mask  -- (' num2str(fract*100) '% sampling)']);
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
subplot(2,2,2);imagesc(abs(Ah(b)));
title(['Ah(b)  -- (data SNR=' num2str(DataSNR) ')']);
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
subplot(2,2,4);imagesc(abs(Xrecon));
title(['IRPF Result (Rank = ' num2str(L) ', reconstruction SNR=' num2str(ReconSNR) ')']);
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
drawnow;

disp('*******************************************');
%% Convolution Recovery Example
disp('Random Convolution Recovery Example'); 
% A matrix recovery example, where the matrix is convolved with a random 
% kernel and then undersampled.

fract = 3/40;
p = round(m*n*fract);
samplingMask = zeros(m,n);
P = randperm(m*n);
samplingMask(P(1:p)) = 1;

kernel = complex(randn(m,n),randn(m,n));
kernel = kernel/norm(kernel(:))*sqrt(m*n);

S.type = '()';
S.subs{:} = find(samplingMask);

A = @(X) subsref(ifft2(kernel.*fft2(reshape(X,[m,n]))),S);
Ah = @(X) ifft2(conj(kernel).*fft2(subsasgn(zeros(m,n),S,X)));
AhA = @(X) ifft2(conj(kernel).*fft2(samplingMask.*ifft2(kernel.*fft2(reshape(X,[m,n])))));

b =A(X)+complex(randn(p,1),randn(p,1))/40;

DataSNR = norm(b)/norm(A(X)-b);

tic
Xrecon = irpf_operator_cg(A, Ah, AhA, b, [m,n], L,10);
toc

ReconSNR = norm(X)/norm(X-Xrecon);

figure;
set(gcf, 'Position', [0 0 640 640]);
subplot(2,2,1);imagesc(samplingMask);
title(['Sampling Mask  -- (' num2str(p/m/n*100) '% sampling)']);
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
subplot(2,2,2);imagesc(abs(Ah(b)));
title(['Ah(b)  -- (data SNR=' num2str(DataSNR) ')']);
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
subplot(2,2,4);imagesc(abs(Xrecon));
title(['IRPF Result (Rank = ' num2str(L) ', reconstruction SNR=' num2str(ReconSNR) ')']);
axis equal;axis tight;colormap(gray);caxis([0,1.2]);
drawnow;