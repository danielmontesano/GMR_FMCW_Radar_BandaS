addpath('/Users/danielmontesano/Documents/MATLAB/rend_v2')
rend('default','painters')

dipole = sparameters('DIPOLO_RECTO.s1p');

vivaldi = sparameters('VIVALDI.s1p');

figure;
hold on;
rfplot(vivaldi)
rfplot(dipole)

lines = findobj(gcf,'Type','Line');
for i = 1:numel(lines)
  lines(i).LineWidth = 2.0;
end

% xlim([1e9 4e9]);
% xticks(1e9:0.5e9:4e9)
% ylim([-15 25]);
% yticks([-40:5:30])
grid on
title('Measured return loss of vailable antennas ')
xlabel('Frequency [Hz]')
ylabel('Return loss [dB]');
set(gcf, 'color', 'w')
set(gca, 'fontsize', 18)
legend('Vivaldi antennas','Dipole antennas','location','southwest')

print('Vivaldi_S11','-depsc')
savefig('Vivaldi_S11')