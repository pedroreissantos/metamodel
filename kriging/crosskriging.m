%crosskriging - cross validation for kriging (leave-one-out)
%
% Arguments: univariate design points 'xdata',
%            univariate responses 'ydata',
%            regression 'pol'ynomial function,
%            'corr'elation function,
%            initial guess for the parameters 'theta0',
%            low bound for theta 'lob',
%            upper bound for theta 'upb'.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [ resnorm ] = crosskriging(xdata,ydata,pol,corr,theta0,lob,upb)
function [ resnorm ] = crosskriging(xdata, ydata, pol,corr,theta0,lob,upb)
	if nargin < 5; tol = 1e-6; end
	if nargin < 6; niter = 100; end

	npts = size(xdata,1);
	if npts ~= size(ydata,1)
		disp('different number of points in xdata and ydata')
		return
	end

	for pt = 1:npts
		y = [ydata(1:(pt-1)); ydata((pt+1):npts)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		model = dacefit(x, y, pol, corr, theta0, lob, upb);
		yhat(pt) = predictor(xdata(pt), model);
	end
	resnorm = sqrt(sum((yhat - ydata').^2));
