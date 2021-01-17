%crossCn - cross validation for segmented polynomials (leave-one-out)
%
% Arguments: univariate design points 'xdata',
%            univariate responses 'ydata',
%            polynomial 'degree' of each segment,
%            break points 'sub'-intervals,
%            noderiv - do not impose first derivative continuity,
%            maximum 'tol'erance,
%            maximum number of iterations 'niter'.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [ resnorm ] = crossCn(xdata,ydata,[1 3 2], [[-.6 -.4]; [.4 .6]])
function [ resnorm ] = crossCn(xdata, ydata, degree, sub, noderiv, tol, niter)
	if nargin < 5; noderiv = false; end
	if nargin < 6; tol = 1e-6; end
	if nargin < 7; niter = 100; end

	npts = size(xdata,1);
	if npts ~= size(ydata,1)
		disp('different number of points in xdata and ydata')
		return
	end

	for pt = 1:npts
		y = [ydata(1:(pt-1)); ydata((pt+1):npts)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		[ t, b ] = minCn(x, y, degree, sub, noderiv, tol, niter);
		yhat(pt) = evalCn(degree, b, t, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - ydata').^2));
