load('DACout.mat')

DACout(:,1) = DACout(:,1)+2.348e-5;
DACout(:,2) = DACout(:,2)*10;

figure;
plot(DACout(:,1),DACout(:,2),'linewidth',2);

grid on
title('DAC output')
xlabel('Time [s]')
ylabel('Amplitude [V]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

xlim([0 100e-6])


print('DACout','-depsc')
savefig('DACout')