function SourceCreator( node1,node2,name,type2,type,value,handles )
%SOURCECREATOR Summary of this function goes here
%   Detailed explanation goes here

    %--------DATA-------%
    Add_Nodes(node1);
    Add_Nodes(node2);
    dataSource=cell(8,1);
    dataSource{1,1}='Source';
    dataSource{2,1}=name;
    dataSource{3,1}=node1;
    dataSource{4,1}=node2;
    dataSource{5,1}=type2;
    dataSource{6,1}=value;
    dataSource{7,1}={0,0};
    dataSource{8,1}={10,10};
    data=getappdata(0,'data');
    data{end+1,1}=dataSource;
    setappdata(0,'data',data);
    %On affiche la liste de nodes dans les popup d'element
    set(handles.popup_node1_element,'String',data{1,1});
    set(handles.popup_node2_element,'String',data{1,1});
    set(handles.popup_node_netlist,'String',data{1,1});
    
    %-----Reset edittext------%
    set(handles.edit_name_source,'String','');
    set(handles.edit_node1_source,'String','');
    set(handles.edit_node2_source,'String','');
    set(handles.edit_value_source,'String','');
    set(handles.edit_option_source,'String','');
    set(handles.popupmenu2,'Value',1);
    set(handles.edit_in1,'String','');
    set(handles.edit_in2,'String','');
    set(handles.edit_keyword,'String','');
    set(handles.edit_gain,'String','');
    set(handles.edit_vn1,'String','');
    set(handles.edit_transR,'String','');
    set(handles.edit_transC,'String','');
    
    %-----Update La listbox-----%
    liste=get(handles.listbox_all_lines,'String');
    liste{end+1,1}=type;
    [a,~]=size(liste);
    set(handles.listbox_all_lines,'Value',a);
    set(handles.listbox_all_lines,'String',liste);
    
    %-----Affichage graphique-----%
    CalculCoordonates(handles);
    %-------OLD APPDATA-----%
%     list_nodes=getappdata(0,'list_nodes');
%     list_nodes{end+1,1}=node1;
%     list_nodes{end+1,1}=node2;
%     setappdata(0,'list_nodes',list_nodes);
%     set(handles.popup_node1_element,'String',list_nodes);
%     set(handles.popup_node2_element,'String',list_nodes);
end

