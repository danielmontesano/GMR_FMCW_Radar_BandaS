addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

%con bobina
PA_VCO = dlmread('Trace_0027.csv',',',46,0); 
%%
figure;
hold on;
plot(PA_VCO(:,1),smooth(PA_VCO(:,2),20),'linewidth',2);

grid on

 xlim([1.5e9 3.3e9])
xticks(1.5e9:0.2e9:3.3e9);
ylim([12 22])
yticks(12:1:24)
title('PA driven by VCO');
xlabel('Frequency [Hz]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_PA_VCO','-depsc')
savefig('V2_PA_VCO')

