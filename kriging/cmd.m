load msg2log.txt
xdata=msg2log(:,2);
yrep=msg2log(:,3:22);
ydata=mean(yrep')';
format long e
[dmodel, perf]=dacefit(xdata, ydata, @regpoly0, @corrgauss, [10], [0.1], [20]);
[yp mse] = predictor(xdata, dmodel);
sqrt(sum((ydata-yp).^2)) % resnorm
crosskriging(xdata, yrep, @regpoly0, @corrgauss, [10], [0.1], [20])
