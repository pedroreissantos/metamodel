function [ theta, breaks, resnorm, iter ] = minCn(xdata, ydata, degree, subs, tol, niter, display)
%MINCN - find best break points for a segmented polynomial
% xdata - vector of experimental points
% ydata - vector of responses at experimental points
% degree - vector with polynomial degree of each segment
% subs - vector of break point values
% tol - stopping criteria of absolute difference between iterations at each break (default=1e-6)
% niter - maximum number of iterations (default=100)
% display - display intermediate break values and total error at each iteration (default=false)
%
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Example:
% xdata=msg2log(:,2);
% ydata=mean(msg2log(:,3:22)')';
% [t, b, r, i] = minCn(xdata, ydata, [3 3 3], [[-.6 -.4]; [.4 .6]])
    if nargin < 6; tol = 1e-6; end
    if nargin < 7; niter = 100; end
    if size(subs,2) ~= 2 || size(subs,1) ~= length(degree) -1
        disp('invalid subs dimensions');
				theta = []; breaks = []; resnorm = Inf; iter = 0;
        return
    end
    breaks = mean(subs')';
    opt = optimset('TolX',1e-12,'Display','off');
    for iter = 1:niter
        for i = 1:length(breaks)
          brk(i) = fminbnd(@(x) func(x,i,breaks,xdata,ydata,degree),subs(i,1),subs(i,2),opt);
        end
        diff = abs(breaks-brk);
        tolres = sum(diff);
        if nargin > 6 && display > 0
           fprintf(1, '#%d tol=%G: ', iter, tolres); disp(brk);
        end
        if all(diff < tol); break; end
        breaks = brk;
    end
    [theta resnorm] = lsqCn(xdata, ydata, degree, breaks);
end

function x = func(x, i, breaks, xdata, ydata, degree)
    breaks(i) = x;
    [t,x] = lsqCn(xdata, ydata, degree, breaks);
end
    
