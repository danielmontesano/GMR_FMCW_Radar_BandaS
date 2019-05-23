
% T1 = dlmread('Trace_1007.csv',',',55,0);
T2 = dlmread('Trace_1008.csv',',',55,0);
T3 = dlmread('Trace_1009.csv',',',55,0);
T4 = dlmread('Trace_1010.csv',',',55,0);
manuf = dlmread('PhaseNoise_manufacturer.csv',',',2,0);

figure
hold on
% plot(T1(:,1),T1(:,2),'LineWidth', 1.5)
plot(T2(:,1),T2(:,2),'LineWidth', 2)
plot(T3(:,1),T3(:,2),'LineWidth', 2)
plot(T4(:,1),T4(:,2),'LineWidth', 2)
plot(manuf(:,1), manuf(:,2), '-', 'LineWidth', 2)

xlim([1e3 1e6])
xlabel('Frequency offset [Hz]')
ylabel('Phase noise [dBc]')
title('VCO phase noise')

set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)


legend('Tone at 1.47 GHz','Tone at 2.12 GHz','Tone at 3.49 GHz','location','southwest')
set(gca, 'XScale', 'log')
grid on


