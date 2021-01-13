%crossnlfit - cross validation for nonlinear fitting
%
% Arguments: univariatedesign points 'xdata',
%            univariate responses 'yrep': number of replications per point,
%            nonlinear 'func'tion
%            initial guess for the parameters 'theta0'.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [Jm,ci2]=crosspolyfit(xdata,yrep, 4)
function [ resnorm ] = crosspolyfit(xdata, yrep, func, theta0)
	npts = size(xdata,1);
	if npts ~= size(yrep,1)
		disp('different number of points in xdata and yrep')
		return
	end
	nreps = size(yrep, 2);

	for pt = 1:npts
		y = [yrep(1:(pt-1),:); yrep((pt+1):npts,:)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		theta = lsqcurvefit(func,theta0,x,mean(y')');
		yhat(pt) = feval(func, theta, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - mean(yrep')).^2));
