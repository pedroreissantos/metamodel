%crossnlfit - cross validation for nonlinear fitting (leave-one-out)
%
% Arguments: univariate design points 'xdata',
%            univariate responses 'ydata',
%            nonlinear 'func'tion,
%            initial guess for the parameters 'theta0'.
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Ex:
%   fatan = @(tt,x)  tt(1)+tt(2)*atan(tt(3)*x+tt(4));
%   ttzero = [ 90 -36 0.6 -14 ];
%   [ resnorm ] = crossnlfit(xdata,ydata,fatan,ttzero)
function [ resnorm ] = crossnlfit(xdata, ydata, func, theta0)
	npts = size(xdata,1);
	if npts ~= size(ydata,1)
		disp('different number of points in xdata and ydata')
		return
	end
	options = optimoptions('lsqcurvefit','Display','off');

	for pt = 1:npts
		y = [ydata(1:(pt-1)); ydata((pt+1):npts)];
		x = [xdata(1:(pt-1)); xdata((pt+1):npts)];
		theta = lsqcurvefit(func,theta0,x,y,[],[],options);
		yhat(pt) = feval(func, theta, xdata(pt));
	end
	resnorm = sqrt(sum((yhat - ydata').^2));
