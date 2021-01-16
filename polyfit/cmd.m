load msg2log.txt
xdata=msg2log(:,2);
yrep=msg2log(:,3:22);
ydata=mean(yrep')';
format long e
for degree=1:19
 [P,S] = polyfit(xdata,ydata,degree);
 S.normr
 crosspolyfit(xdata,yrep,degree)
end
