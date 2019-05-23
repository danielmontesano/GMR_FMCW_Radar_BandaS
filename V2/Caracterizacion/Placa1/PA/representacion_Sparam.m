addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')


%% PA

pa = sparameters('Sparam/PA_10pf_out_10pf_in.s2p');
pa_man = sparameters('Manufacturer/TSS-53LNB+.S2P');
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
rfplot(pa_man,2,1,'--');
rfplot(pa_man,1,1,'--');
rfplot(pa_man,2,2,'--');

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

ylim([-25 25])
yticks(-25:5:25)
xlim([1.5e9 3.5e9])
xticks(1.5e9:0.25e9:3.5e9);
title('PA S parameters');
legend({'Measured gain','Measured Input R_{loss}','Measured Output R_{loss}','Manufacturer gain','Manufacturer Input R_{loss}','Manufacturer Output R_{loss}'},'Position',[0.25 0.5 0.2 0.2],'fontsize',14);
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)

print('V2_PA_Sparam','-depsc')
savefig('V2_PA_Sparam')

