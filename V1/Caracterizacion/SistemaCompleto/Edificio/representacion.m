figure;
hold on;

% load('edificio_yagi_226_260')
% plot(x,y(1:end/2),'linewidth',2);
% 
% load('edificio_yagi_226_240')
% plot(x,y(1:end/2),'linewidth',2);

load('edificio_dipolo_226_260')
plot(x,y(1:end/2),'linewidth',2);

load('edificio_dipolo_226_240')
plot(x,y(1:end/2),'linewidth',2);

legend('Dipoles 2.26-2.6 GHz','Dipoles 2.26-2.4 GHz')
xlabel('Distance [m]')
ylabel('Amplitude [dB]')
title('Building at 31 m');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
grid on
xlim([0 100])
xticks([0:10:100])
yticks([-50:20:50])

print('SYS_Building','-depsc')
savefig('SYS_Building')