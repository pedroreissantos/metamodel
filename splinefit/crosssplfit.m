%crosssplfit - cross validation for smoothing spline fitting
%
% Arguments: univariatedesign points 'xdata',
%            univariate responses 'yrep': number of replications per point,
%            break points.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [ resnorm ] = crosssplfit(xdata,yrep, [-.4 .4]])
function [ resnorm ] = crosssplfit(xdata, yrep, breaks)
	npts = size(xdata,1);
	if npts ~= size(yrep,1)
		disp('different number of points in xdata and yrep')
		return
	end
	nreps = size(yrep, 2);

	for pt = 1:npts
		y = [yrep(1:(pt-1),:); yrep((pt+1):npts,:)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		pp = splinefit(x, mean(y')', breaks);
		yhat(pt) = ppval(pp, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - mean(yrep')).^2));
