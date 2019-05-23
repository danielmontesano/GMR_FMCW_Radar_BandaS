rend('default','painters')


vco = dlmread('VCO_TuninCurve_man.csv',',',2,0);


figure;
hold on;

plot(vco(:,1),vco(:,2),'linewidth',2);

grid on;
% axis tight;

title('VCO manufacturer tuning curve')
xlabel('Volts [V]')
ylabel('Frequency [HZ]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
% set(gca, 'XScale', 'log')
% xticks(logspace(5,10,6))


print('VCO_tuning_man','-depsc')
savefig('VCO_tuning_man')
