
figure;
hold on;

% load('vivaldi_1600Mhz.mat')
% plot(x,data_power,'linewidth',1.5);
% load('vivaldi_400Mhz.mat')
% plot(x,data_power-20,'linewidth',2);

% load('matlab_edificio_1600_3200.mat')
% plot(x,data_power,'linewidth',2);
% load('matlab_edificio_1600_2600.mat')
% plot(x,data_power,'linewidth',2);
% load('matlab_edificio_2800_3200.mat')
% plot(x,data_power,'linewidth',2);

load('edificio_1600_3200_repisa3.mat')
plot(x,data_power+1,'linewidth',1.5);
load('edificio_1600_2600_repisa.mat')
plot(x,data_power,'linewidth',1.5);
load('edificio_2800_3200_repisa.mat')
plot(x,data_power,'linewidth',1.5);

xlim([0 70]);
xticks(0:5:70)
ylim([-65 -0]);
% yticks([-40:2:0])
grid on
title('Building at 31 m')
xlabel('Distance [m]')
ylabel('Power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

legend('Vivaldi 1.6-3.2 GHz','Vivaldi 1.6-2.6 GHz','Vivaldi 2.8-3.2 GHz','location','northeast');

print('V2_SYS_Building','-depsc')
savefig('V2_SYS_Building')
%%
xlim([24 38]);
xticks(0:2:50)
ylim([-65 -25]);
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end
legend('location','southeast');
print('V2_SYS_Building_zoom','-depsc')
savefig('V2_SYS_Building_zoom')

%% comparacion con v1


figure;
hold on;
% 
% load('edificio_2800_3200_repisa.mat')
% plot(x,data_power+31.59,'linewidth',2);
load('edificio_1600_2600_repisa.mat')
plot(x,data_power+27.0,'linewidth',2);

load('v1_edificio_dipolo_226_260.mat');
plot(x,y(1:end/2)-10,'linewidth',2);
% load('v1_edificio_dipolo_226_240.mat');
% plot(x,y(1:end/2)-55,'linewidth',2);

xlim([0 50]);
xticks(0:5:50)
ylim([-35 10]);
% yticks([-40:2:0])
grid on
title('Building at 31 m')
xlabel('Distance [m]')
ylabel('Normalized power [dBm]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

legend('V2','V1','location','northeast');

print('V2V1_SYS_building','-depsc')
savefig('V2V1_SYS_building')