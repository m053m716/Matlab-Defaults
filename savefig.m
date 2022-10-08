function savefig(fig,filename,tag,skip_delete,formats)
%SAVEFIG Default figure-saving behavior
%
%  default.savefig(fig); -> % figure with handle `fig` to "Untitled__.fig"
%
%  default.savefig('name'); % saves current figure to "name.fig"
%
%  default.savefig(fig,filename,tag);
%  -> default.savefig(fig,'figures/path','file1');
%
% Inputs
%  fig         - Figure handle
%  filename    - Name of output file (char array or string)
%  tag         - Bit to "tag" onto standard name set by filename (for
%                 convenience, by default this is empty)
%  skip_delete - (Optional: default is false) set to `true` to prevent the
%                   default behavior of deleting the figure handle when
%                   done saving it.
%  formats     - (Optional: default is [".png", ".svg", ".fig"] but you can
%                   do a reduced subset of this to make it only save a
%                   certain type e.g. [".fig", ".png"] would only save the
%                   fig file and png but not the svg.)
%
% Output
%  - none -    - The figure will be saved and, if `skip_delete` is not
%                   manually set to `true`, deleted.
%
% See also: Contents, savefig

switch nargin
   case 0
      error('Requires at least one input argument.');
   case 1
      if isa(fig,'matlab.ui.Figure')
         outPath = pwd;
         filename = sprintf('Untitled_%s',...
            char(datetime('now','Format','yyyy-MM-d_HHmmss')));
      else
         [outPath,filename] = parseName(fig);
         fig = gcf;
      end
      skip_delete = false;
      formats = [".png", ".fig", ".svg"];
   case 2
      if isa(fig,'matlab.ui.Figure')
         [outPath,filename,~] = fileparts(filename);
      else
         [outPath,filename] = parseName(fig,filename);
         fig = gcf;
      end
      skip_delete = false;
      formats = [".png", ".fig", ".svg"];
   case 3
      if ~isa(fig,'matlab.ui.Figure')
         error('Too many input arguments. With three args, first arg to default.savefig must be a figure handle.');
      end
      [outPath,filename] = parseName(filename,tag);
      skip_delete = false;
      formats = [".png", ".fig", ".svg"];
    case 4
      if ~isa(fig,'matlab.ui.Figure')
         error('Too many input arguments. With four args, first arg to default.savefig must be a figure handle.');
      end
      [outPath,filename] = parseName(filename,tag);
      formats = [".png", ".fig", ".svg"];
    case 5
      if ~isa(fig,'matlab.ui.Figure')
         error('Too many input arguments. With five args, first arg to default.savefig must be a figure handle.');
      end
      [outPath,filename] = parseName(filename,tag);
    otherwise
      error('Too many input arguments. default.savefig takes up to 5 args.');
end

outPath = strrep(outPath,"\","/");
F = dir(outPath);

if isempty(F) && ~isempty(outPath) && outPath~=""
   mkdir(outPath);
end

fname = fullfile(outPath,filename);
set(fig, 'Renderer', 'painters', 'InvertHardCopy', 'off');
if isempty(fig.UserData) || isstruct(fig.UserData)
   fig.UserData = struct(...
       'VectorGraphicsExported', true, ...
       'VectorGraphicsName', fname, ...
       'VectorGraphicsExportFcn', @()default.savefig(fig, filename, tag) ...
       ); 
end
if contains(".fig",formats)
    savefig(fig,fname);
end
if contains(".svg",formats)
    try
        saveas(fig,strcat(fname, ".svg"),"svg");
    catch me
        disp(me);
        warning('Could not save %s', strcat(fname, ".svg"));
    end
end
if contains(".png",formats)
    try
        saveas(fig,strcat(fname, ".png"),"png");
    catch me
        disp(me);
        warning('Could not save %s', strcat(fname, ".png"));
    end
end
if ~skip_delete
    delete(fig);
end

% Helper function
   function [outPath,filename] = parseName(filename,tag)
      %PARSENAME Simple name parser for using `tag`
      %
      %  [outPath,filename] = parseName(filename);
      %  [outPath,filename] = parseName(filename,tag); % Both work
      %
      % See also: default.savefig
      
      [outPath,f,~] = fileparts(filename);
      
      if isempty(outPath) || outPath==""
         outPath = pwd;
      end
      
      if nargin < 2
         filename = f;
      else
         filename = strcat(f,"_",tag);
      end
   end
end