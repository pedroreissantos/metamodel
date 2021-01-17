%crosssplfit - cross validation for smoothing spline fitting (leave-one-out)
%
% Arguments: univariate design points 'xdata',
%            univariate responses 'ydata',
%            break points.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [ resnorm ] = crosssplfit(xdata,ydata, [-5 -.4 .4 5]])
function [ resnorm ] = crosssplfit(xdata, ydata, breaks)
	npts = size(xdata,1);
	if npts ~= size(ydata,1)
		disp('different number of points in xdata and ydata')
		return
	end

	for pt = 1:npts
		y = [ydata(1:(pt-1)); ydata((pt+1):npts)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		pp = splinefit(x, y, breaks);
		yhat(pt) = ppval(pp, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - ydata').^2));
