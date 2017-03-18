function Reset(handles)
set(handles.listbox_all_lines,'String',{'******************'});
set(handles.listbox_all_lines,'Value',1);
% set(handles.popup_node2_element,'String','');
% set(handles.popup_node1_element,'String','');
% set(handles.popup_node_netlist,'String','');
Init(handles);
setappdata(0,'type_circuit','sub');
%set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'off')
%set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'on')
set(handles.Main_circuit_Checkbox,'Value',0);
set(handles.Subcircuit_Checkbox,'Value',1);
set(handles.edit_name_circuit,'enable','off');
set(handles.text_main_circuit,'enable','off');
set(handles.push_preset_sp_file,'enable','off');
a=get(handles.popup_add_netlist,'String');
display(a);
[n,m]=size(a);
if n>1
    set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'on')
end
set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'on')
%CalculCoordonates(handles);
