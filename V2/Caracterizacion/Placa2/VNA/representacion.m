addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

%% VCO

vco = sparameters('spltr.s2p');

figure;
hold on;

rfplot(vco,2,1);
rfplot(vco,1,1);
rfplot(vco,2,2);


lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-30 -5])
xlim([1.5e9 3.5e9])
title('Splitter S parameters');
legend('Isolation','Output 1 return loss','Output 2 return loss','location','northwest');

xlabel('Frequency [Hz]')
ylabel('S parameters [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_splitter_Sparam','-depsc')
savefig('V2_splitter_Sparam')

%% PA

pa = sparameters('PA_10pf_out_10pf_in.s2p');
pa_man = 
figure;
hold on;
% rfplot(sparameters('PA_ON.s2p'));
% rfplot(sparameters('PA_L.s2p'));
% rfplot(sparameters('PA_0ohm_out.s2p'));
% rfplot(sparameters('PA_33pf_out.s2p'));
% rfplot(sparameters('PA_10pf_out_10pf_in.s2p'));
% rfplot(sparameters('PA_15pf_out.s2p'));
% rfplot(sparameters('PA_3.3pf_out.s2p'));
% rfplot(sparameters('PA_10pf_out_330pf_in.s2p'));

rfplot(pa,2,1);
rfplot(pa,1,1);
rfplot(pa,2,2);

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-30 20])
xlim([1.5e9 3.5e9])
title('PA S parameters');
legend('Gain','Input return loss','Output return loss','location','southeast');
xlabel('Frequency [Hz]')
ylabel('S parameters [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('PA_comp','-depsc')
savefig('PA_comp')

%% LNA2

LNA2 = sparameters('LNA2.s2p');
figure;
hold on;
rfplot(LNA2,1,2);
rfplot(LNA2,1,1);
rfplot(LNA2,2,2);

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-15 15])
title('LNA 2 S parameters');
legend('Gain','Input return loss','Output return loss','location','northeast');

xlabel('Frequency [Hz]')
ylabel('S parameters [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('LNA2','-depsc')
savefig('LNA2')

%% LNA1

% LNA1 = sparameters('LNA1_L56nH_Caps10p.s2p')
LNA1 = sparameters('LNA1.s2p')


% figure;
% hold on
% rfplot(sparameters('LNA1.s2p'));
% pause()
% rfplot(sparameters('LNA1_bobinaCambiada1.5UH.s2p'));
% pause()
% rfplot(sparameters('LNA1_bobinaCambiada_Caps56pf.s2p'));
% pause()
% rfplot(sparameters('LNA1_bobinaCambiada_Capsp1nf.s2p'));
% pause()
% rfplot(sparameters('LNA1_L56nH_Caps10p.s2p'));

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
rfplot(LNA2,1,2);
rfplot(LNA2,1,1);
rfplot(LNA2,2,2);

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-25 15])
xlim([1.5e9 3.5e9])
title('LNAs S parameters');
legend({'Gain LNA1','Input R_{loss} LNA1','Output R_{loss} LNA1','Gain LNA2','Input R_{loss} LNA2','Output R_{loss} LNA2'},'fontsize',12,'location','southeast');

xlabel('Frequency [Hz]')
ylabel('S parameters [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('LNAs','-depsc')
savefig('LNAs')

%% MIX

mix = sparameters('MixRF_MixLO.s2p');
% vco = sparameters('MixRF.s2p');

figure;
hold on;
rfplot(mix,2,1);
rfplot(mix,1,2);



lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-100 -40])
title('Mixer isolation between ports');
legend('Isolation RF-LO','Isolation LO-RF','location','northeast');

xlabel('Frequency [Hz]')
ylabel('S parameters [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('Mixer_isol','-depsc')
savefig('Mixer_isol')

%% MIX

mix = sparameters('MixRF_MixLO.s2p');
% vco = sparameters('MixRF.s2p');

figure;
h1 = axes;
hold on;
rfplot(mix,1,1);
rfplot(mix,2,2);

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end


ylim([-30 0])
title('Mixer Return loss');
legend('RF port R_{loss}','LO port R_{loss}','location','southwest');

xlabel('Frequency [Hz]')
ylabel('Return loss [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)


print('V2_MIX_Rloss','-depsc')
savefig('V2_MIX_Rloss')

