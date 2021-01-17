load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
format long e
pp = splinefit(xdata,ydata,[-5 -.4 .4 5]); % 3x4+4
sqrt(sum((ydata-ppval(pp, xdata)).^2)) % resnorm
crosssplfit(xdata, ydata, [-5 -.4 .4 5])
