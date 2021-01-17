load msg2log.txt
xdata=msg2log(:,2);
ydata=mean(msg2log(:,3:22)')';
format long e
for degree=1:19
 [P,S] = polyfit(xdata,ydata,degree);
 S.normr
 crosspolyfit(xdata,ydata,degree)
end
