function PopupAddNetlist( hObject,handles )
%POPUPADDNETLIST Summary of this function goes here
%   Detailed explanation goes here
list=getappdata(0,'list_netlist');
if get(hObject,'Value')>1
    select=list{get(hObject,'Value')-1};
    select=strsplit(select);
    [~,b]=size(select);
    select1='';
    for i=3:b
        select1=[select1,select{i},' '];
    end
    set(handles.static_add_netlist,'String',select1);
else
    set(handles.static_add_netlist,'String','');
end

