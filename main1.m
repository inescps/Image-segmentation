clc;
clear all;

load('sar_image.mat');
%% 1.b
figure;
imagesc(I);
title('SAR Image');

%% 1.c
figure;
water = imcrop(I,[0 0 600 1300]);
imagesc(water);
title('Water Area');

figure;
ice = imcrop(I,[700 2200 1000 500]);
imagesc(ice);
title('Ice Area');

% Exponential Distribution
mean_ice = mean2(ice);
lambda_ice = 1/mean_ice;

mean_water = mean2(water);
lambda_water = 1/mean_water;

% Rayleigh distribution
sq_ice = ice.^2;
b_ice = sqrt(0.5*mean2(sq_ice));

sq_water = water.^2;
b_water = sqrt(0.5*mean2(sq_water));

% Normal distribution
mu_ice = mean_ice;
mu_water = mean_water;

var_ice = (ice - mu_ice).^2;
sigma_ice = mean2(var_ice);

var_water = (ice - mu_water).^2;
sigma_water = mean2(var_water);


%% 1.d
% Water region
figure;
histogram(water,'Normalization','pdf');
title('Water Area Histogram');

% Exponential Distribution
e_water = exppdf(water,mu_water);
figure;
subplot(1,3,1);
plot(water, e_water);
title('Exponential');

% Rayleigh Distribution
r_water = raylpdf(water,b_water);
subplot(1,3,2);
plot(water, r_water);
title('Rayleigh');

% Normal Distribution
n_water = normpdf(water,mu_water,sigma_water);
subplot(1,3,3);
plot(water, n_water);
title('Normal');

% Ice region
figure;
histogram(ice,'Normalization','pdf');
title('Ice Area Histogram');

% Exponential Distribution
e_ice = exppdf(ice,mu_ice);
figure;
subplot(1,3,1);
plot(ice, e_ice);
title('Exponential');

% Rayleigh Distribution
r_ice = raylpdf(ice,b_ice);
subplot(1,3,2);
plot(ice, r_ice);
title('Rayleigh');

% Normal Distribution
n_ice = normpdf(ice,mu_ice,sigma_ice);
subplot(1,3,3);
plot(ice, n_ice);
title('Normal');


%% 2.a
figure;
imagesc(ice);
hold on;
imcontour(log(r_ice),3);

% figure;
% imagesc(water);
% hold on;
% imcontour(r_water,3);

