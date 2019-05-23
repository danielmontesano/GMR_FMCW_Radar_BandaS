rend('default','painters')


s21hg = dlmread('S21HG.csv',',',2,0);
s11hg = dlmread('S11HG.csv',',',2,0);
s22hg = dlmread('S22HG.csv',',',2,0);

figure;
hold on;

plot(s21hg(:,1),s21hg(:,2),'linewidth',2);
plot(s11hg(:,1),s11hg(:,2),'linewidth',2);
plot(s22hg(:,1),s22hg(:,2),'linewidth',2);


grid on;
% axis tight;

title('LNA manufacturer S parameters')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('S_{21}','S_{11}','S_{22}','location','west')



print('LNA_Sparam_man','-depsc')
savefig('LNA_Sparam_man')
%% 
ylim([-20 40])
xlim([2e9 3e9])
print('LNA_Sparam_man_zoom','-depsc')
savefig('LNA_Sparam_man_zoom')