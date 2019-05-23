addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')


sp = dlmread('CP_Sparam_man.csv',',',2,0);%CouplingX CouplingY RlossX RlossY IsolX IsolY IlossX IlossY

sp(sp==0) = nan;
figure;
hold on;

plot(sp(:,1),sp(:,2),'linewidth',2);
plot(sp(:,3),sp(:,4),'linewidth',2);
plot(sp(:,5),sp(:,6),'linewidth',2);
plot(sp(:,7),sp(:,8),'linewidth',2);

grid on;
% axis tight;

title('Coupler manufacturer S parameters')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('Coupling','R_{loss}','Isol','I_{loss}')


%% 
print('CP_Sparam_man','-depsc')
savefig('CP_Sparam_man')

ylim([-55 0])
xlim([2e9 3e9])

print('CP_Sparam_man_zoom','-depsc')
savefig('CP_Sparam_man_zoom')