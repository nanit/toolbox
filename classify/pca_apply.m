% Companion function to pca.
%
% Use pca to retrieve the principal components U and the mean mu from a
% set fo vectors X1 via [U,mu,vars] = pca(X1).  Then given a new
% vector x, use y = pca_apply( x, U, mu, vars, k ) to get the first k
% coefficients of x in the space spanned by the columns of U. See pca for
% general information.
%
% This may prove useful:
%   siz = size(X);  k = 100;
%   Uim = reshape( U(:,1:k), [ siz(1:end-1) k ]  );
%
% INPUTS
%   X           - array for which to get PCA coefficients
%   U           - [returned by pca] -- see pca
%   mu          - [returned by pca] -- see pca
%   vars        - [returned by pca] -- see pca
%   k           - number of principal coordinates to approximate X with
%
% OUTPUTS
%   Yk          - first k coordinates of X in column space of U
%   Xhat        - approximation of X corresponding to Yk
%   avsq        - measure of squared error normalized to fall between [0,1]
%
% DATESTAMP
%  10-Jan-2007  4:00pm
%
% See also PCA, PCA_APPLY_LARGE, PCA_VISUALIZE

% Piotr's Image&Video Toolbox      Version 1.03   
% Written and maintained by Piotr Dollar    pdollar-at-cs.ucsd.edu 
% Please email me if you find bugs, or have suggestions or questions! 
 
function [ Yk, Xhat, avsq, avsq_orig ] = pca_apply( X, U, mu, vars, k )
  siz = size(X); nd = ndims(X);  [N,r]  = size(U);
  if(N==prod(siz) && ~(nd==2 && siz(2)==1)); siz=[siz, 1]; nd=nd+1; end;
  inds = {':'}; inds = inds(:,ones(1,nd-1));   
  d= prod(siz(1:end-1));

  % some error checking
  if(isa(X,'uint8')); X = double(X); end;
  if(k>r); warning(['Only ' int2str(r) '<k comp. available.']); k=r; end;
  if(d~=N); error('incorrect size for X or U'); end;

  % subtract mean, then flatten X
  Xorig = X;
  murep = mu( inds{:}, ones(1,siz(end)));
  X = X - murep;
  X = reshape(X, d, [] );

  % Find Yk, the first k coefficients of X in the new basis
  k = min( r, k );
  Uk = U(:,1:k);
  Yk = Uk' * X;

  % calculate Xhat - the approx of X using the first k princ components
  if( nargout>1 ) 
    Xhat = Uk * Yk; 
    Xhat = reshape( Xhat, siz );
    Xhat = Xhat + murep;
  end;

  % caclulate average value of (Xhat-Xorig).^2 compared to average value
  % of X.^2, where X is Xorig without the mean.  This is equivalent to 
  % what fraction of the variance is captured by Xhat.
  % Note: the 4 output version of this function is for pca_apply_large
  if( nargout>2 )
    avsq = Xhat - Xorig; 
    avsq = dot(avsq(:),avsq(:));
    avsq_orig = dot(X(:),X(:)); 
    if (nargout==3)
      avsq = avsq / avsq_orig;
    end
  end;