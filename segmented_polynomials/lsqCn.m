function [theta, resnorm, residual, exitflag, output, lambda] = lsqCn(x, y, degree, breaks, noderiv, options)
%LSQCN - segmented polynomial fitting
% Ensures function continutity on breaks and first derivative continuity
% if both degrees on break are at least quadratic.
% x - vector of experimental points
% y - vector of responses at experimental points
% degree - vector with polynomial degree of each segment
% breaks - vector of break point values
% noderiv - do not impose first derivative continuity
%
% if a point coincides with a break, its value is used in both segments.
% Example:
% x = -30:2:30;
% y = atan(x);
% degree = [4 1 4]; % 3-segments
% breaks = [6 10]; % 2 breaks (between segments)
% [theta, resnorm, residual, exitflag, output, lambda] = lsqCn(x, y, degree, breaks)
	if nargin < 5; noderiv = false; end
	if nargin < 6
		options = optimoptions('lsqlin','Algorithm','interior-point','Display','off');
	end
	x = x(:); % ensure/convert x is a vertical vector
	if ~all(x == sort(x))
		disp('x values not sorted')
		return
	end
	y = y(:);
	if length(x) ~= length(y)
		disp('x and y not the same length');
		return
	end
	breaks = sort(breaks(:));
	if length(degree) ~= length(breaks)+1
		disp('breaks do not match degree')
		return
	end
	lim = [ min(x); breaks; max(x) ];
	A = []; b = []; C = []; xa = 1;
	for i = 1:length(degree)
		% select indexes of points in the segment
		pts = nonzeros((lim(i) <= x & x <= lim(i+1)) .* (1:length(x))');
		if degree(i) >= length(pts)
			fprintf('interval %d of degree %d with only %d points\n', i, degree(i), length(pts));
			return
		end
		aa = fliplr(vander(x(pts))); % mirror Vandermonde matrix
		xb = xa + length(pts) - 1;
		ya = sum(degree(1:(i-1))+1)+1;
		yb = ya + degree(i);
		A(xa:xb,ya:yb) = aa(:,1:(degree(i)+1)); % select Vandermode upto degree
		xa = xb + 1;
		b = [ b ; y(pts) ];
	end
	Ci = 1; Cj = 1;
	for i = 1:length(breaks)
		m = degree(i); % degree before break
		n = degree(i+1); % degree after break
		C(Ci,Cj:(Cj+m+n+1)) = [ breaks(i).^(0:m) -breaks(i).^(0:n) ];
		if ~noderiv && (m > 1 || n > 1) % include derivative continuity
			Ci = Ci + 1;
			C(Ci,Cj:(Cj+m+n+1)) = [ 0 (1:m).*breaks(i).^(0:(m-1)) 0 -(1:n).*breaks(i).^(0:(n-1))  ];
		end
		Ci = Ci + 1;
		Cj = Cj + m + 1;
	end
	d = zeros(size(C,1),1);
	[theta ,resnorm,residual,exitflag,output,lambda] = lsqlin(A,b,[],[],C,d,[],[],[],options);
end
