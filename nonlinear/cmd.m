load msg2log.txt
xdata=msg2log(:,2);
yrep=msg2log(:,3:22);
ydata=mean(yrep')';
format long e
fatan = @(tt,x)  tt(1)+tt(2)*atan(tt(3)*x+tt(4));
ttzero = [ 90 -36 0.6 -14 ];
[tt,resnorm,residual,exitflag,output]  = lsqcurvefit(fatan,ttzero,xdata,ydata);
crossnlfit(xdata,yrep,fatan,ttzero)
