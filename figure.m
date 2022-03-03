function fig = figure(name,varargin)
%FIGURE Return default figure handle
%
%  fig = default.figure(); % -> To use 'Name',value keyword pairs, must
%                          %    provide a value for `name` (can specify as
%                          %    '' to use default)
%  fig = default.figure(name);
%  fig = default.figure(name,'Name',value,...);
%
% Inputs
%  name     - Name of figure ('Name' figure property)
%  varargin - 'Name',value keyword argument pairs for Matlab figure builtin
%                 
% Output
%  fig      - Formatted Matlab figure handle
%
% See also: Contents, matlab.ui.Figure

if (nargin < 1) || isempty(name) || name==""
   name = "Untitled Figure";
end

iWidth = find(ismember(varargin(1:2:end), 'Width'));
if ~isempty(iWidth)
    iWidth = iWidth * 2 - 1;
    Width = varargin{iWidth + 1};
    varargin([iWidth, iWidth+1]) = [];
else
    Width = 0.4;
end


iHeight = find(ismember(varargin(1:2:end), 'Height'));
if ~isempty(iHeight)
    iHeight = iHeight * 2 - 1;
    Height = varargin{iHeight + 1};
    varargin([iHeight, iHeight+1]) = [];
else
    Height = 0.3;
end

r = groot;
if size(r.MonitorPositions,1) > 1
   pos = [1.2  0.22  Width  Height];
else
   pos = [ 0.25  0.25 Width  Height];
end
pos(1:2) = pos(1:2) + randn(1,2).*0.005; % Jitter figure position

fig = figure(...
   'Name',name,...
   'Units','Normalized',...
   'OuterPosition',pos,...
   'Color','w',...
   'PaperOrientation','portrait',...
   'PaperSize',[8.5 11],...
   'PaperUnits','inches',...
   'Renderer', 'painters', ...
   varargin{:}); % Insert the rest as "Name",value keyword pairs

end