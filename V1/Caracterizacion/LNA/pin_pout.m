load('pin_pout.mat');
%p es Pin
p = p - 1;
figure
hold on
z=@(xx) interp1(p,f2300,xx,'spline');
fplot(z,[p(1),p(end)],'linewidth',2)
z=@(xx) interp1(p,f2450,xx,'spline');
fplot(z,[p(1),p(end)],'linewidth',2)
z=@(xx) interp1(p,f2600,xx,'spline');
fplot(z,[p(1),p(end)],'linewidth',2)
title('Output power vs input power of LNA')
xlabel('Input power [dBm]');
ylabel('Output power [dBm]');
xlim([p(1) p(end)]);
grid on
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('2,2 GHz','2,45 GHz','2,7 GHz','Location','northwest')
hold off

print('LNA_Pin_vs_Pout','-depsc')
savefig('LNA_Pin_vs_Pout')
%%
gain = zeros(3,length(p));
gain(1,:) = f2300 - p;
gain(2,:) = f2450 - p;
gain(3,:) = f2600 - p;

pout = zeros(3,length(p));
pout(1,:)=f2300;
pout(2,:)=f2450;
pout(3,:)=f2600;

figure
hold on
z=@(xx) interp1(p,gain(1,:),xx,'spline');
fplot(z,[p(1),p(end)],'linewidth',2)
z=@(xx) interp1(p,gain(2,:),xx,'spline');
fplot(z,[p(1),p(end)],'linewidth',2)
z=@(xx) interp1(p,gain(3,:),xx,'spline');
fplot(z,[p(1),p(end)],'linewidth',2)
ylabel('Gain [dB]');
xlabel('Input power [dBm]');
title('Gain vs input power of LNA')
grid on
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('2,2 GHz','2,45 GHz','2,7 GHz','Location','southwest')
xlim([min(min(p))-0.5,max(max(p)) + 0.5]);

hold off

print('LNA_Gain_vs_Pin','-depsc')
savefig('LNA_Gain_vs_Pin')