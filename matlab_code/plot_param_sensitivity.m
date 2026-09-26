clear;
% Generate sample data
% x = [0,0.1,0.2, 0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
% x = [0.1,0.2, 0.25, 0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
% x=  [1, 2, 3, 4, 5, 6]; 
% x=  [1, 2, 3, 4, 5, 6, 7]; 
x = [1, 2, 3, 4, 5];
%animal beta
% y = [0.1263,  0.1864,   0.1833,0.1745, 0.1800,  0.1793,  0.1735,0.2013,  0.1828, 0.1826, 0.1664];
%ytf10 beta
% y = [0.7022, 0.7020, 0.7644, 0.7626, 0.8188, 0.7664, 0.7609, 0.7562, 0.7649,0.8095, 0.8751];
% y2 = 3 * x - 2;
%animal graph 
% y = [0.1488, 0.1446, 0.2013,  0.0907,  0.0907,  0.0907,  0.0907,  0.0907,  0.0907, 0.0907,  0.0907];
%YTF10 graph 
% y = [0.1821, 0.5136, 0.8751,  0.1592,   0.1592,   0.1592,   0.1592,   0.1592,   0.1592,  0.1592,   0.1592];
%animal partition
% y = [0.2, 0.2, 0.2 ,0.2 ,0.2 ,0.18];
%YTF partition 
% y = [0.8751, 0.8751, 0.8751,0.8752, 0.8762,    0.8781];
%anmial A
% y = [0.1371, 0.1371,0.1545, 0.2013,0.194, 0.17244, 0.13];
% YTF A
%y = [0.5873, 0.6204,0.7425,  0.7955,0.8751, 0.5514, 0.53];
% animal l
% y = [0.1760, 0.2013, 0.1854, 0.17836, 0.17836];
%animal k
y = [0.1835, 0.2013, 0.1679, 0.1860, 0.1930];
%ytf10 l
% y = [0.8579, 0.8751, 0.6885, 0.8243, 0.7821];
%ytf10 k 
% y = [ 0.8751, 0.6878, 0.6360, 0.6343, 0.6584];
% Create the figure
figure;

% Plot the lines
plot(x, y, 'b-', 'LineWidth', 2);

% plot(x, y, 'b--', 'LineWidth', 2);
% line([2 2], [0 0.8751], 'Color', 'r', 'LineWidth', 2);
% Add labels and title
% xlabel('X-axis');
ylabel('Clustering Performance(ACC)', 'FontSize', 20);
xticks(x);
% set(gca, 'xtick', 0.1:90:1);
% set(gca, 'xticklabel', {'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1'});

% xticklabels(compose('%0.2f', x));
xticks(x);
 
% Set labels corresponding to the positions of x-axis ticks
% xticklabels({'Label1', 'Label3', 'Label5', 'Label7', 'Label9'});
% title("Animal","FontSize",20);
% xticklabels = {'0.1','', '1/v','','0.4','0.5','0.6','0.7','0.8','0.9','1'};
% xticklabels = {'10^{-4}','10^{-3}', '10^{-2}','10^{-1}','10^{0}','10^{1}', '10^{2}'};%,'0.6','0.7','0.8','0.9','1'};
% xticklabels = {'10^{-6}','10^{-5}', '10^{-4}','10^{-3}','10^{-2}','10^{-1}'};
xticklabels = {'k','2k', '3k','4k','5k'};%,'10^{-1}'};
set(gca, 'XTickLabel', xticklabels);
% Add a legend
% legend('Line 1', 'Line 2');
xlabel('(f) varying m on Animal', 'FontSize', 20);
% Grid and axis limits
grid on;
% xlim([min(x), max(x)]);
ylim([0, 0.25]);