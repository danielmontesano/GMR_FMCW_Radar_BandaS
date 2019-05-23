% rend('default','painters')

vco = csvread('vco_caracterizacion.txt');
voltaje = vco(:,1);
freq = vco(:,2)*1e9;
g = 3.3/4096;

vco = dlmread('TuningCurve_Manufacturer/VCO_TuninCurve_man.csv',',',2,0);

close;
figure;
hold on;

plot(vco(:,1),vco(:,2),'linewidth',2);
% plot(voltaje*g, freq, 'xk')
int_voltaje = 20:0.5:4095;
int_freq = spline(voltaje, freq, int_voltaje);
plot(int_voltaje*g, int_freq,'linewidth',2)

grid on;
xlim([0 3.3])
ylim([2.25e9 2.65e9])
 xticks([0:0.5:3 3.3])

title('VCO tuning curve')
xlabel('Voltage [V]')
ylabel('Frequency [HZ]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
% legend('Manufacturer','Measured','Interpolated from measurement','location','southeast')
legend('Manufacturer','Measured','location','southeast')



print('VCO_tuning','-depsc')
savefig('VCO_tuning')
