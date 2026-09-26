x=[1 2 3 4 ];
 y=[ log(40)  log(400)  log(320) log(700) ;
     log(19)  log(331)  log(1440) log(448) ;
     log(37)  log(158)  log(1286) log(1132) ;
     log(40) log(179)  log(1321) log(1211) ; 
       log(20) log(70)  log(410) log(300); 
       log(114) log(337)   log(641) log(1140);  
        log(67) log(189)   log(421) log(1521) ;
          log(27) log(135)   log(421) log(370);
           log(41) log(200)   log(1413) log(1315) ; 
 ];

 bb = y(:,3);
 y(:,3) = y(:,1);
 y(:,1) = bb;

figureHandle = figure('Position', [100, 100, 1200, 200]);
 bar(x,y);
 hYLabel1 = ylabel(sprintf('Logarithm of\nRunning Time'), 'FontSize', 30);
 hLegend = legend('LMVSC','OPMC' ,'SMVSC','OMSC','AWMVC','FDAG','MVCGL','CMVC','Ours');

set(gca, 'FontName', 'Helvetica', 'FontSize', 10);

set(gca,'xTicklabel',{'Reuters', 'AwA', 'YTF10', 'YTF100'})
fileout = 'test';

set(gca, 'ColorOrder', hsv(9));