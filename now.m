function t = now(varargin)
%NOW  Return datetime for current time with preferred formatting.
%
% Syntax:
%   t = default.now();
%
% Inputs:
%   varargin - (Optional datetime formatting options)
%
% See also: Contents
t = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS', varargin{:});

end