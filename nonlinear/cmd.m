load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
format long e
fatan = @(tt,x)  tt(1)+tt(2)*atan(tt(3)*x+tt(4));
ttzero = [ 90 -36 0.6 -14 ];
[tt,resnorm,residual,exitflag,output]  = lsqcurvefit(fatan,ttzero,xdata,ydata);
crossnlfit(xdata,ydata,fatan,ttzero)
