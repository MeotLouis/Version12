function errortooltip(hObject, message, displayTime, varargin)
% ERRORTOOLTIP temporarily displays a message below a uicontrol

% checks the number of arguments
error(nargchk(2, Inf, nargin))

% error handling
if nargin <= 2
    % define the display time as the default
    displayTime = [];
end

% if no extra arguments
if nargin <= 3
    % uses the tooltip function but modifies the colours
    tooltip(hObject, message, displayTime, 'BackgroundColor', 'r', 'ForegroundColor', 'w')
    
else
    % uses the tooltip function but modifies the colours
    tooltip(hObject, message, displayTime, 'BackgroundColor', 'r', 'ForegroundColor', 'w', varargin{:})
end