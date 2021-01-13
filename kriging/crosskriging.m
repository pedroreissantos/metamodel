%crosskriging - cross validation for kriging
%
% Arguments: univariatedesign points 'xdata',
%            univariate responses 'yrep': number of replications per point,
%            regression 'pol'ynomial function
%            'corr'elation function
%            initial guess for the parameters 'theta0'
%            low bound for theta 'lob'
%            upper bound for theta 'upb'
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [resnorm]=crosskriging(xdata,yrep,pol,corr,theta0,lob,upb)
function [ resnorm ] = crosskriging(xdata, yrep, pol,corr,theta0,lob,upb)
	if nargin < 5; tol = 1e-6; end
	if nargin < 6; niter = 100; end

	npts = size(xdata,1);
	if npts ~= size(yrep,1)
		disp('different number of points in xdata and yrep')
		return
	end
	nreps = size(yrep, 2);

	for pt = 1:npts
		y = [yrep(1:(pt-1),:); yrep((pt+1):npts,:)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		model = dacefit(x, mean(y')', pol, corr, theta0, lob, upb);
		yhat(pt) = predictor(xdata(pt), model);
	end
	resnorm = sqrt(sum((yhat - mean(yrep')).^2));
