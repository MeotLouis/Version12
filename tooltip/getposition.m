function position = getposition(hObject, units)
% GETPOSITION returns the size of the handle object in the requested units.
%  If no units are supplied, then returns the default.  If there is more
%  than one hObject, then the units can be scalar.

% checks the number of arguments
error(nargchk(1, 2, nargin))

% checks the handles
if any(~ishandle(hObject)) || ~isscalar(hObject)
    % error
    error('Must supply valid handle object.')
end

% checks the units
if nargin < 2 || isempty(units)
    % special case
    if hObject
        % use the default
        position = get(hObject, 'Position');

    else
        % monitor
        position = get(hObject, 'MonitorPositions');
    end
    
    % leave
    return
    
elseif ischar(units)
    % convert it
    units = repmat({units}, numel(hObject), 1);

elseif ~iscellstr(units)
    % error
    error('Invalid monitor location data type.')
    
elseif ~isscalar(units) && numel(units) ~= numel(hObject)
    % error
    error('Units must be a scalar or the same size as hObject.')
end

% checks it properly
if any(~ismember(units, {'inches', 'centimeters', 'normalized', 'points', 'pixels', 'characters'}))
    % errors
    error('Invalid units.')
end

% gets the old units
oldUnits = get(hObject, 'Units');

% set the units
set(hObject, {'Units'}, units)

% special case
% get the position
position = get(hObject, 'Position');

% if its a scalar, convert it
if isscalar(hObject)
    % convert
    oldUnits = {oldUnits};
end

% and set the units back
set(hObject, {'Units'}, oldUnits)