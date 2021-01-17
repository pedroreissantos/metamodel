load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
format long e
[t b r i] = minCn(xdata,ydata,[1 1 1],[[-1 -.3];[.3 1]])
[t2 r2] = lsqCn(xdata,ydata,[2 2 2], b)
[t b r i] = minCn(xdata,ydata,[1 3 1],[[-1 -.3];[.3 1]])
[t b r i] = minCn(xdata,ydata,[2 3 2],[[-1 -.3];[.3 1]])
[t b r i] = minCn(xdata,ydata,[3 3 3],[[-1 -.3];[.3 1]])
[t b r i] = minCn(xdata,ydata,[1 3 1],[[-1 -.3];[.3 1]],true) % C^0
[t b r i] = minCn(xdata,ydata,[2 3 2],[[-1 -.3];[.3 1]],true) % C^0
[t b r i] = minCn(xdata,ydata,[3 3 3],[[-1 -.3];[.3 1]],true) % C^0
[t b r i] = minCn(xdata,ydata,[2 2 2 2],[[-1 -.5];[-.025 .025];[.5 1]])
[t b r i] = minCn(xdata,ydata,[2 1 2],[[-1 -.3];[.3 1]])
[t b r i] = minCn(xdata,ydata,[1 2 1],[[-.8 -.2];[.2 .8]])
[t b r i] = minCn(xdata,ydata,[2 2 2],[[-1 -.3];[.3 1]])
[t b r i] = minCn(xdata,ydata,[2 2],[[-.4 .4]])
crossCn(xdata,ydata,[1 1 1],[[-1 -.3];[.3 1]])
crossCn(xdata,ydata,[1 1 1],[[-1 -.3];[.3 1]],true) % C^0
yrep=msg2log(:,3:22);
[Jm ci2] = jackCn(xdata,yrep,[1 1 1],[[-1 -.3];[.3 1]])
[Jm ci2] = jackCn(xdata,yrep,[1 1 1],[[-1 -.3];[.3 1]],true) % C^0
