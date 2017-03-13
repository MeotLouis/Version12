function PopUpMenu2(hObject, eventdata, handles)
set(handles.static_help,'String',sprintf(DisplayHelp('source',get(hObject,'Value'))));
contents = cellstr(get(hObject,'String'));
select=contents{get(hObject,'Value')};
if length(select)>1
    %------Default display-------%
    set(handles.push_add_source,'enable','off');
    set(handles.edit_name_source,'enable','off');
    set(handles.edit_node1_source,'enable','off');
    set(handles.edit_node2_source,'enable','off');
    set(handles.edit_option_source,'enable','off');
    set(handles.text7,'enable','off');
    set(handles.text8,'enable','off');
    set(handles.text9,'enable','off');
    set(handles.text10,'enable','off');
    set(handles.text11,'enable','off');
    %--------Panel Display-------%
    set(handles.text42,'enable','off');
    set(handles.text34,'enable','off');
    set(handles.text35,'enable','off');
    set(handles.text38,'enable','off');
    set(handles.text39,'enable','off');
    set(handles.text40,'enable','off');
    set(handles.text41,'enable','off');
    set(handles.text22,'enable','off');
    set(handles.edit_in1,'enable','off');
    set(handles.edit_in2,'enable','off');
    set(handles.edit_keyword,'enable','off');
    set(handles.edit_gain,'enable','off');
    set(handles.edit_vn1,'enable','off');
    set(handles.edit_transR,'enable','off');
    set(handles.edit_transC,'enable','off');
    set(handles.edit_value_source,'enable','off');
else
    %--------Reset Panel Display-------%
    set(handles.text42,'enable','off');
    set(handles.text34,'enable','off');
    set(handles.text35,'enable','off');
    set(handles.text38,'enable','off');
    set(handles.text39,'enable','off');
    set(handles.text40,'enable','off');
    set(handles.text41,'enable','off');
    set(handles.text22,'enable','off');
    set(handles.edit_in1,'enable','off');
    set(handles.edit_in2,'enable','off');
    set(handles.edit_keyword,'enable','off');
    set(handles.edit_gain,'enable','off');
    set(handles.edit_vn1,'enable','off');
    set(handles.edit_transR,'enable','off');
    set(handles.edit_transC,'enable','off');
    set(handles.edit_value_source,'enable','off');
    %----------Default display----------%
    set(handles.push_add_source,'enable','on');
    set(handles.edit_name_source,'enable','on');
    set(handles.edit_node1_source,'enable','on');
    set(handles.edit_node2_source,'enable','on');
    set(handles.edit_option_source,'enable','on');
    set(handles.text7,'enable','on');
    set(handles.text8,'enable','on');
    set(handles.text9,'enable','on');
    set(handles.text10,'enable','on');
    set(handles.text11,'enable','on');
    if isequal(select,'V')||isequal(select,'I')
        set(handles.edit_value_source,'enable','on');
        set(handles.text22,'enable','on');
    else
        set(handles.edit_keyword,'enable','on');
        set(handles.text42,'enable','on');
        if isequal(select,'E')
            set(handles.edit_in1,'enable','on');
            set(handles.edit_in2,'enable','on');
            set(handles.text34,'enable','on');
            set(handles.text35,'enable','on');
            set(handles.edit_gain,'enable','on');
            set(handles.text38,'enable','on');
        elseif isequal(select,'F')
            set(handles.edit_vn1,'enable','on');
            set(handles.text39,'enable','on');
            set(handles.edit_gain,'enable','on');
            set(handles.text38,'enable','on');
        elseif isequal(select,'G')
            set(handles.edit_in1,'enable','on');
            set(handles.edit_in2,'enable','on');
            set(handles.text34,'enable','on');
            set(handles.text35,'enable','on');
            set(handles.edit_transC,'enable','on');
            set(handles.text41,'enable','on');
        else
            set(handles.edit_vn1,'enable','on');
            set(handles.text39,'enable','on');
            set(handles.edit_transR,'enable','on');
            set(handles.text40,'enable','on');
        end
    end    
end