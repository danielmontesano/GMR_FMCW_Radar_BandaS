addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')


vco = dlmread('VCO_PhaseNoise_man.csv',',',2,0);


figure;
hold on;

plot(vco(:,1),vco(:,2),'linewidth',2);

grid on;
% axis tight;

title('VCO manufacturer phase noise')
xlabel('Frequency [Hz]')
ylabel('Phase noise [dBc]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
set(gca, 'XScale', 'log')
xticks(logspace(5,7,3))
ylim([-130 -90])


print('VCO_PhaseNoise_man','-dpng')
savefig('VCO_PhaseNoise_man')
