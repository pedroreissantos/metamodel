load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
yrep=msg2log(:,3:22);
format long e
ttzero = [ 90 -36 0.6 -14 ];
[tt,resnorm,residual,exitflag,output]  = lsqcurvefit(fatan,ttzero,xdata,ydata);
crossnlfit(xdata,yrep,fatan,ttzero)
