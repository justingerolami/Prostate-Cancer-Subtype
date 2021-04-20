function plotScatterForData(data, plot_title, ylbl, datalbl)

alpha = 0.204*log(length(data))+ 1.123;

%find outliers
qupper = quantile(data, 0.75)+alpha*iqr(data);
qlower = quantile(data, 0.25)-alpha*iqr(data);

flag1 = data<qlower;
flag2 = data>qupper;

x = 1:length(data);
figure, hold on

plot(x, data, 'b.', 'markersize', 16);
plot([0 length(data)+1], [qupper qupper], '-r', 'linewidth', 2);
plot([0 length(data)+1], [qlower qlower], '-r', 'linewidth', 2);
% plot(x(flag1), data(flag1), '*m', 'markersize', 15);
plot(x(flag2), data(flag2), '*m', 'markersize', 15);
% text(x(flag1)+0.7, data(flag1), datalbl(flag1));
text(x(flag2)+0.7, data(flag2), datalbl(flag2));

axis([0 length(data)+1 nanmin(data)-nanstd(data) nanmax(data)+nanstd(data)]);
title(plot_title, 'FontSize',16, 'FontName', 'Helvetica');
%xlabel('Samples', 'FontSize',14, 'FontName', 'Helvetica');
set(gca, 'XTick', 1:length(datalbl));
set(gca, 'XTickLabel', datalbl);
ax = gca;
ax.XTickLabelRotation=90;
ylabel(ylbl, 'FontSize',14, 'FontName', 'Helvetica');
hold off;
