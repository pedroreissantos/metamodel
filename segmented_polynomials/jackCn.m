%jackCn - jackknifing for segmented polynomials
% jackknifing solves two types of problems (Kleijnen06wsc)
%   1- How to compute confidance intervals for nonnormal observations
%   2- How to reduce possible bias of estimators
%
% Arguments: univariate (x), univariate(y), number of replicatios per x (r),
%			function (f ='mean' or 'var'), alpha
% Returns central value (Jm), half-length CI (ci2)
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex: [Jm,ci2]=jackCn(xdata,yrep,[3 3 3], [[-.6 -.4]; [.4 .6]])
function [ Jm, ci2, J ] = jackCn(xdata, yrep, degree, sub, noderiv, tol, niter, alpha)
  if nargin < 5; noderiv = false; end
	if nargin < 6; tol = 1e-6; end
	if nargin < 7; niter = 100; end
	if nargin < 8; alpha = .05; end

	npts = size(xdata,1);
	if npts ~= size(yrep,1)
		disp('different number of points in xdata and yrep')
		return
	end
	nreps = size(yrep, 2);

	[ theta, breaks, resnorm, iter ] = minCn(xdata, mean(yrep')', degree, sub, noderiv, tol, niter);
	base = [ breaks theta' ];
	for r = 1:nreps
		y = [yrep(:,1:(r-1)) yrep(:,(r+1):nreps)];
		[ t(r,:), b(r,:) ] = minCn(xdata, mean(y')', degree, sub, noderiv, tol, niter);
    end
    J = nreps .* base - (nreps-1) .* [b t];
    Jm = mean(J);
	ci2 = sqrt(var(J)./nreps) * tinv(1-alpha/2, nreps-1);
