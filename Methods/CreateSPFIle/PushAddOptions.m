function PushAddOptions( handles )
PushAddOptions(handles);
option=get(handles.edit_option,'String');
if ~isempty(option)
    %Generate basics option to simplifie the use
    if isequal('.OPTION Default options',option)
        set(handles.edit_option,'String','');
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}='.option unwrap=1';
        liste{end+1,1}='.TEMP 27';
        liste{end+1,1}='.option post';
        liste{end+1,1}='.option ingold=1';
        liste{end+1,1}='.option converge=1';
        liste{end+1,1}='.global 0';
        liste{end+1,1}='';
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_options,'Value',1);
    else
        set(handles.edit_option,'String','');
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=option;
        liste{end+1,1}='';
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_options,'Value',1);
    end
end
end

