load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
format long e
[t b r i] = minCn(xdata,ydata,[1 1 1],[[-.8 -.4];[.4 .6]])
[t2 r2] = lsqCn(xdata,ydata,[2 2 2], b)
[t b r i] = minCn(xdata,ydata,[1 3 1],[[-.8 -.4];[.4 .6]])
[t b r i] = minCn(xdata,ydata,[2 3 2],[[-.8 -.4];[.4 .6]])
[t b r i] = minCn(xdata,ydata,[3 3 3],[[-.8 -.4];[.4 .6]])
[t b r i] = minCn(xdata,ydata,[1 3 1],[[-.8 -.4];[.4 .6]],true) % C^0
[t b r i] = minCn(xdata,ydata,[2 3 2],[[-.8 -.4];[.4 .6]],true) % C^0
[t b r i] = minCn(xdata,ydata,[3 3 3],[[-.8 -.4];[.4 .6]],true) % C^0
[t, b, r, i] = minCn(xdata,ydata,[2 2 2 2],[[-1 -.5];[-.025 .025];[.5 1]])
[t, b, r, i] = minCn(xdata,ydata,[2 1 2],[[-1 -.3];[.3 1]])
[t, b, r, i] = minCn(xdata,ydata,[1 2 1],[[-1 -.2];[.2 1]])
[t, b, r, i] = minCn(xdata,ydata,[2 2 2],[[-1 -.3];[.3 1]])
[t, b, r, i] = minCn(xdata,ydata,[2 2],[[-.4 .4]])
yrep=msg2log(:,3:22);
crossCn(xdata,yrep,[1 1 1],[[-.8 -.4];[.4 .6]])
crossCn(xdata,yrep,[1 1 1],[[-.8 -.4];[.4 .6]],true) % C^0
[Jm, ci2] = jackCn(xdata,yrep,[1 1 1],[[-.8 -.4];[.4 .6]])
[Jm, ci2] = jackCn(xdata,yrep,[1 1 1],[[-.8 -.4];[.4 .6]],true) % C^0
