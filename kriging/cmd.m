load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
format long e
[dmodel, perf]=dacefit(xdata, ydata, @regpoly0, @corrgauss, [10], [0.1], [20]);
[yp mse] = predictor(xdata, dmodel);
sqrt(sum((ydata-yp).^2)) % resnorm
crosskriging(xdata, ydata, @regpoly0, @corrgauss, [10], [0.1], [20])
