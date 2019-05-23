addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')


LNA_man = sparameters('Manufacturer/MPGA-105+.s4p');
%% LNA1

LNA1 = sparameters('Sparameters/LNA1_Repetido.s2p');
figure;
hold on;
rfplot(LNA1,1,2);
rfplot(LNA1,1,1);
rfplot(LNA1,2,2);

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-15 15])
title('LNA 1 S parameters');
legend('Gain','Input return loss','Output return loss','location','northeast');

xlabel('Frequency [Hz]')
ylabel('S parameters [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('LNA1','-depsc')
savefig('LNA1')


%% LNAs comp
figure;
hold on;
rfplot(LNA1,1,2);
rfplot(LNA1,1,1);
rfplot(LNA1,2,2);
lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).YData = smooth(lines(i).YData,100);
end
rfplot(LNA_man,2,1,'--');
rfplot(LNA_man,2,2,'--');
rfplot(LNA_man,1,1,'--')

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-25 15])
yticks(-25:5:25)
xlim([1.5e9 3.5e9])
xticks(1.5e9:0.25e9:3.5e9);
title('LNA S parameters');
% legend({'Gain LNA1','Input R_{loss} LNA1','Output R_{loss} LNA1','Gain LNA2','Input R_{loss} LNA2','Output R_{loss} LNA2','Manufacturer gain','Manufacturer input R_{loss} LNA2','Manufacturer output R_{loss} LNA2'},'fontsize',12,'location','eastoutside');
legend({'Measured gain','Measured input R_{loss}','Measured output R_{loss}','Manufacturer gain','Manufacturer input R_{loss}','Manufacturer output R_{loss}'},'fontsize',14,'position',[0.25 0.6 0.2 0.2]);

xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_LNA_Sparam','-depsc')
savefig('V2_LNA_Sparam')


