% rend('default','painters')


sp = dlmread('PA_Sparam_man.csv',',',2,0);%S11X 	S11Y S21X S21Y S22X S22Y

sp(sp==0) = nan;
figure;
hold on;

plot(sp(:,3),sp(:,4),'linewidth',2);
plot(sp(:,1),sp(:,2),'linewidth',2);
plot(sp(:,5),sp(:,6),'linewidth',2);

grid on;
% axis tight;

title('PA manufacturer S parameters')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('S_{21}','S_{11}','S_{22}','location','southwest')


ylim([-40 30])
xlim([2e9 3e9])

print('PA_Sparam_man','-depsc')
savefig('PA_Sparam_man')

% ylim([-40 30])
% xlim([2e9 3e9])
% 
% print('PA_Sparam_man_zoom','-depsc')
% savefig('PA_Sparam_man_zoom')