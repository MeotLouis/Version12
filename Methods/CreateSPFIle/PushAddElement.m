function PushAddElement( handles )
%PUSHADDELEMENT Summary of this function goes here
%   Detailed explanation goes here
contents = cellstr(get(handles.popup_type_element,'String'));
select = contents{get(handles.popup_type_element,'Value')};
if isequal(select,'-')
    errordlg('Missing type of element');
elseif isempty(get(handles.edit_name_element,'String'))
    errordlg('Missing name of element');
elseif isempty(get(handles.edit_value_element,'String'))
    errordlg('Missing value of element');
else
    type=select;
    contents = cellstr(get(handles.popup_node1_element,'String'));
    select = contents{get(handles.popup_node1_element,'Value')};
    node1=select;
    contents = cellstr(get(handles.popup_node2_element,'String'));
    select = contents{get(handles.popup_node2_element,'Value')};
    node2=select;
    value=get(handles.edit_value_element,'String');
    %On effectue cette boucle pour voir si la valeur est une équation et
    %mettre des '' si elle en est une
    pattern={'*','+','/','-'};
    a=0;
    for j=1:4
        if ~isempty(strfind(value,pattern{1,j}))
            a=a+1;
        end
    end
    if a~=0
        value=['''',value,''''];
    end
    name=get(handles.edit_name_element,'String');
    SimpleElementCreator( handles,name,node1,node2,type,value)
end

