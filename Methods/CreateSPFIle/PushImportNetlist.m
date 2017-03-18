function PushImportNetlist( handles)
display(get(handles.popup_node_netlist,'String'),'');
if isempty(getappdata(0,'project_directory'))
    errordlg('Missing project directory');
    project_directory=uigetdir();
    setappdata(0,'project_directory',project_directory);
elseif isempty(get(handles.edit_name_netlist,'String'))
    errordlg('Missing name of Sub circuit');
elseif isempty(get(handles.popup_node_netlist,'String'))
    errordlg('You need to add at least one port to generate a subcircuit');
else
    path=getappdata(0,'project_directory');
    name=get(handles.edit_name_netlist,'String');

    name_file=[path,'\',name,'.inc'];
    if exist(name_file,'file')~=0
        delete(name_file);
    end

    fid=fopen(name_file,'at');
    tlines=get(handles.listbox_all_lines,'String');
    [lignes,~]=size(tlines);
    fprintf(fid,strcat(get(handles.edit_netlist_subckt,'String'),'\n'));
    for i=1:lignes
       fprintf(fid, strcat(tlines{i,1},'\n')); 
    end
    fprintf(fid,'.ends');
    fprintf(fid,'\n');
    fclose(fid);

%     set(handles.popup_add_netlist,'Enable','on');
%     set(handles.edit_add_netlist,'Enable','on');
%     set(handles.push_add_netlist,'Enable','on');
%     type=get(handles.edit_name_netlist,'String');
%     list=get(handles.popup_add_netlist,'String');
%     if ~iscell(list)
%         list2=cell(0,1);
%         list2{end+1,1}=list;
%         list=list2;
%     end
%     list{end+1,1}=type;
%     set(handles.popup_add_netlist,'String',list);
%     [a,~]=size(list);
%     set(handles.listbox_all_lines,'Value',a);
    set(handles.edit_path_file,'String','');
    set(handles.popup_node_netlist,'String',{' '});
    set(handles.edit_name_netlist2,'String','');
    list_netlist=getappdata(0,'list_netlist');
    list_netlist{end+1,1}=get(handles.edit_netlist_subckt,'String');
    setappdata(0,'list_netlist',list_netlist);
    set(handles.edit_netlist_subckt,'String','.subckt');
    set(handles.edit_name_netlist,'String','');
    set(handles.push_add_name,'Enable','on');
    setappdata(0,'name_netlist',[]);
    %Enalble all edit and popup disabled because of the use of the create tool
    set(handles.edit_path_file,'enable','on');
    set(handles.edit_name_netlist,'enable','on');
    set(handles.edit_netlist_subckt,'enable','on');
    set(handles.popup_node_netlist,'enable','on');
    Reset(handles);
end
end

