x=[1 2 3 4 5];
 y=[0.6092 0.3816    0.3232 0.5932 0.6092;
     0.8744  0.7401 0.744233   0.874491 0.8900 ;
     0.1934  0.1510 0.1526 0.1751 0.2013;
    0.6213 0.5874  0.5745 0.3764 0.6420; 
   0.8751 0.7106 0.7117 0.6595 0.8751; 
 ];

figureHandle = figure('Position', [100, 100, 1400, 200]);
 bar(x,y);
 hYLabel1 = ylabel(sprintf('ACC'), 'FontSize', 20);
 hLegend = legend('SMVC-VRA-O','SMVC-VRA-R' ,'SMVC-VRA-U','SMVC-VRA-D','SMVC-VRA');%,'FDAG','MVCGL','CMVC','Ours');

set(gca, 'FontName', 'Helvetica', 'FontSize', 13);

set(gca,'xTicklabel',{'BDGP', 'Caltech101-7', 'Animal', 'Reuters',   'YTF10'})
fileout = 'test';

set(gca, 'ColorOrder', hsv(9));