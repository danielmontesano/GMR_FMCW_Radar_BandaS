
figure;
hold on;
%se corrige el factor de distancia por ser el cable. 0.7 de la velocidad de
%la luz, y *2 por ser un cable y no tener trayecto de ida y vuelta
% load('matlab-cable-1600M-4-12-2018.mat')
% plot(x*0.7*2,data_power,'linewidth',2);
% load('matlab-cable-200M-4-12-2018.mat')
% plot(x*0.7*2,data_power,'linewidth',2);
  load('matlab_cable26metros_1600_3200.mat')
 plot(x*0.7*2/1.0385,data_power,'linewidth',2);
 load('matlab_cable26metros_1600_2600.mat')
 plot(x*0.7*2/1.0385,data_power,'linewidth',2);
%   load('matlab_cable26metros_1600_2800.mat')
%  plot(x*0.7*2/1.0385,data_power,'linewidth',2);
  load('matlab_cable26metros_2800_3200.mat')
 plot(x*0.7*2/1.0385,data_power,'linewidth',2);




xlim([0 36]);
xticks(-40:5:100)
ylim([-80 -10]);
% yticks([-40:5:100])
grid on
title('Cable')
xlabel('Distance [m]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

% legend('1.6-3.2 GHz','2.4-2.6 GHz','location','northeast');
% legend('1.6-3.2 GHz','1.6-2.6 GHz','1.6-2.8 GHz','2.8-3.2 GHz','location','northeast');
legend('1.6-3.2 GHz','1.6-2.6 GHz','2.8-3.2 GHz','location','northeast');

print('V2_SYS_cable_26m','-depsc')
savefig('V2_SYS_cable_26m')
%%
ylim([-75 -35]);
xlim([22 32]);
xticks(-40:1:100)
print('V2_SYS_cable_26m_zoom','-depsc')
savefig('V2_SYS_cable_26m_zoom')

%% 
figure;
hold on;
%se corrige el factor de distancia por ser el cable. 0.7 de la velocidad de
%la luz, y *2 por ser un cable y no tener trayecto de ida y vuelta
% load('matlab-cable-1600M-4-12-2018.mat')
% plot(x*0.7*2,data_power,'linewidth',2);
% load('matlab-cable-200M-4-12-2018.mat')
% plot(x*0.7*2,data_power,'linewidth',2);
  load('matlab_cable8metros_1600_3200.mat')
 plot(x*0.7*2,data_power,'linewidth',2);
 load('matlab_cable8metros_1600_2600.mat')
 plot(x*0.7*2,data_power,'linewidth',2);
  load('matlab_cable8metros_1600_2800.mat')
 plot(x*0.7*2,data_power,'linewidth',2);
  load('matlab_cable8metros_2800_3200.mat')
 plot(x*0.7*2,data_power,'linewidth',2);




xlim([0 15]);
xticks(-40:2:100)
ylim([-80 -10]);
% yticks([-40:5:100])
grid on
title('Cable')
xlabel('Distance [m]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

% legend('1.6-3.2 GHz','2.4-2.6 GHz','location','northeast');
legend('1.6-3.2 GHz','1.6-2.6 GHz','1.6-2.8 GHz','2.8-3.2 GHz','location','northeast');

print('V2_SYS_cable_8m','-depsc')
savefig('V2_SYS_cable_8m')

ylim([-70 -20]);
xlim([6 11]);
xticks(-40:0.5:100)
print('V2_SYS_cable_8m_zoom','-depsc')
savefig('V2_SYS_cable_8m_zoom')

%% comparacion con v1

% 
% figure;
% hold on;
% 
% load('vivaldi_1600Mhz.mat')
% plot(x,data_power,'linewidth',1.5);
% 
% load('v1_edificio_dipolo_226_260.mat');
% plot(x,y(1:end/2)-52,'linewidth',2);
% % load('v1_edificio_dipolo_226_240.mat');
% % plot(x,y(1:end/2)-55,'linewidth',2);
% 
% xlim([0 50]);
% xticks(0:5:50)
% ylim([-65 -35]);
% % yticks([-40:2:0])
% grid on
% title('Bulding at 31 m')
% xlabel('Distance [m]')
% ylabel('Normalized power [dBm]');
% set(gcf, 'color', 'w')
% set(gca, 'fontsize', 18)
% 
% legend('V2','V1','location','northeast');
% 
% print('V2V1_SYS_building','-depsc')
% savefig('V2V1_SYS_building')