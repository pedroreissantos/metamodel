%EVALCN - segmented polynomial evaluation
% returns the value of a segmented polynomial
% degree - the degree of each polynomial segment
% breaks - break point values (between segments)
% theta - array of polynomial coefficients of each segment
% xx - values to be evaluated
% Author: Pedro Reis dos Santos, University of Lisbon, 2020
% Example:
% theta = [ a0 a1 a2 b0 b1 b2 b3 c0 c1 c2 ]
% evalCn( [ 2 3 2 ], [ -4 0 ], theta, xx)
% where the first segment is a quadratic: a0 + a1 * x + a2 * x^2
%       the second segment is a cubic: b0 + b1 * x + b2 *x^2 + b3 * x^3
%       the third segment is a quadratic: c0 + c1 * x + c2 * x^2
function pval = evalCn(degree, breaks, theta, xx)
   pval = [];
   breaks = sort(breaks(:)); % ensure/convert x is a vertical vector
   if length(degree) ~= length(breaks)+1
       disp('length of breaks does not match degree');
       return
   end
   theta = theta(:)';
   if length(theta) ~= sum(degree) + length(degree)
       disp('number of thetas does not match degree');
   end
   xx = sort(xx(:));
   brki = 1;
   tti = 1;
   for i = 1:length(xx)
       x = xx(i);
       while (brki <= length(breaks)) && (x > breaks(brki))
           tti = tti + degree(brki) + 1;
           brki = brki + 1;
       end
       pp = flip(theta(tti:(tti+degree(brki))));
       pval = [ pval, polyval(pp, x) ];
   end
end
