%crosspolyfit - cross validation for polynomial fitting (leave-one-out)
%
% Arguments: univariate design points 'xdata',
%            univariate responses 'ydata': number of replications per point,
%            polynomial degree.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [ resnorm ] = crosspolyfit(xdata,ydata, 4)
function [ resnorm ] = crosspolyfit(xdata, ydata, degree)
	npts = size(xdata,1);
	if npts ~= size(ydata,1)
		disp('different number of points in xdata and ydata')
		return
	end

	for pt = 1:npts
		y = [ydata(1:(pt-1)); ydata((pt+1):npts)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		pp = polyfit(x, y, degree);
		yhat(pt) = polyval(pp, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - ydata').^2));
