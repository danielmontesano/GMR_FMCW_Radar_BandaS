clear, close all

T1 = dlmread('VCO.csv',',',45,0);
f = T1(:,1);
data = T1(:,2)+6+3;
plot(f,data, 'LineWidth', 1.5)
title('VCO')

figure,
T2 = dlmread('VCO+PA.csv',',',45,0);
data = T2(:,2)+6;
plot(f,data, 'LineWidth', 1.5)
title('VCO+PA')