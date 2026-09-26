% Create sample data
clear;
data = [
    0.8579  0.8751  0.6885;
    0.7394 0.6878 0.6399;
     0.6173 0.6360 0.6218;
];

labels_x = {'1k', '2k', '3k'};
labels_y = {'1k', '2k', '3k'};
% Create figure window
figure;
% Plot 3D bar chart
bar3(data);
title("YTF10",'FontSize', 15);
% Set axis labels and title
xlabel('l','FontSize', 15);
ylabel('m','FontSize', 15);
zlabel('Clustering Performance(ACC)', 'FontSize', 10);
