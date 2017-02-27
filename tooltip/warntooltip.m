function warntooltip(hObject, message, displayTime, varargin)
% WARNTOOLTIP temporarily displays a warning message below a uicontrol

% first stage argument check
error(nargchk(2, nargin, nargin))

% error handling
if nargin <= 2
    % define the display time as the default
    displayTime = [];
end

% if there are extra arguments
if nargin <= 3
    % uses the tooltip function but modifies the colours
    tooltip(hObject, message, displayTime, 'BackgroundColor', 'y')
    
else
    % uses the tooltip function but modifies the colours and adds the extra
    % formatting on the end
    tooltip(hObject, message, displayTime, 'BackgroundColor', 'y', varargin{:})
end