function [] = formatcorrplots (x_lim, y_lim, plot_title, x_title, ...
    y_title, xline1, yline1, xline2, yline2, xline3, yline3)

xlim(x_lim);
ylim(y_lim);

title(plot_title, 'FontSize', 14, 'FontWeight', 'bold');

xlabel(x_title, 'FontSize', 12, 'FontWeight', 'bold');
ylabel(y_title, 'FontSize', 12, 'FontWeight', 'bold');

line(xline1, yline1, ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line(xline2, yline2, ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line(xline3, yline3, ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;


end