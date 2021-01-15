%crossCn - cross validation for segmented polynomials
%
% Arguments: univariatedesign points 'xdata',
%            univariate responses 'yrep': number of replications per point,
%            polynomial 'degree' of each segment,
%            break points 'sub'-intervals,
%            noderiv - do not impose first derivate continuity
%            maximum 'tol'erance,
%            maximum number of iterations 'niter'.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [resnorm]=crossCn(xdata,yrep,[3 3 3], [[-.6 -.4]; [.4 .6]])
function [ resnorm ] = crossCn(xdata, yrep, degree, sub, noderiv, tol, niter)
  if nargin < 5; noderiv = false; end
	if nargin < 6; tol = 1e-6; end
	if nargin < 7; niter = 100; end

	npts = size(xdata,1);
	if npts ~= size(yrep,1)
		disp('different number of points in xdata and yrep')
		return
	end
	nreps = size(yrep, 2);

	for pt = 1:npts
		y = [yrep(1:(pt-1),:); yrep((pt+1):npts,:)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		[ t, b ] = minCn(x, mean(y')', degree, sub, noderiv, tol, niter);
		yhat(pt) = evalCn(degree, b, t, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - mean(yrep')).^2));
