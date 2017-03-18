function PushAddSource(handles)
contents = cellstr(get(handles.popupmenu2,'String'));
select = contents{get(handles.popupmenu2,'Value')};
[~,b]=size(select);
if b==2
    errordlg('Missing type of source');
elseif isempty(get(handles.edit_name_source,'String'))
    errordlg('Missing name of source');
elseif isempty(get(handles.edit_node1_source,'String'))
    errordlg('Missing ports +');
elseif isempty(get(handles.edit_node2_source,'String'))
    errordlg('Missing ports -');
else
    if isequal(select,'V')||isequal(select,'I')
        if isempty(get(handles.edit_value_source,'String'));
            value=inputdlg('Please enter value of source:');
            value=value{1,1};
        else
            value=get(handles.edit_value_source,'String');
            value=IsOperation(value);
        end
        suite=value;
    else
        if isequal(select,'E')
            in1=get(handles.edit_in1,'String');
            if isempty(in1);
                in1=inputdlg('Please enter name of control node +:');
                in1=in1{1,1};
            end
            in2=get(handles.edit_in2,'String');
            if isempty(in2);
                in2=inputdlg('Please enter name of control node -:');
                in2=in2{1,1};
            end 
            gain=get(handles.edit_gain,'String');
            if isempty(gain);
                gain=inputdlg('Please gain of source value:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[in1,' ',in2,' ',gain];
            else
                suite=[keyword,' ',in1,' ',in2,' ',gain];
            end
            Add_Nodes(in1);
            Add_Nodes(in2);
        elseif isequal(select,'F')
            vn1=get(handles.edit_vn1,'String');
            if isempty(vn1);
                vn1=inputdlg('Please enter name of voltage source who take the flow:');
                vn1=vn1{1,1};
            end
            gain=get(handles.edit_gain,'String');
            if isempty(gain);
                gain=inputdlg('Please gain of source value:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[vn1,' ',gain];
            else
                suite=[keyword,' ',vn1,' ',gain];
            end
        elseif isequal(select,'G')
            in1=get(handles.edit_in1,'String');
            if isempty(in1);
                in1=inputdlg('Please enter name of control node +:');
                in1=in1{1,1};
            end
            in2=get(handles.edit_in2,'String');
            if isempty(in2);
                in2=inputdlg('Please enter name of control node -:');
                in2=in2{1,1};
            end 
            gain=get(handles.edit_transC,'String');
            if isempty(gain);
                gain=inputdlg('Please value of transconductance:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[in1,' ',in2,' ',gain];
            else
                suite=[keyword,' ',in1,' ',in2,' ',gain];
            end
            Add_Nodes(in1);
            Add_Nodes(in2);
        else
            vn1=get(handles.edit_vn1,'String');
            if isempty(vn1);
                vn1=inputdlg('Please enter name of voltage source who take the flow:');
                vn1=vn1{1,1};
            end
            gain=get(handles.edit_transR,'String');
            if isempty(gain);
                gain=inputdlg('Please value of transresistance:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[vn1,' ',gain];
            else
                suite=[keyword,' ',vn1,' ',gain];
            end
        end
    end
    
    type=select;
    name=get(handles.edit_name_source,'String');
    node1=get(handles.edit_node1_source,'String');
    node2=get(handles.edit_node2_source,'String');
    type2=type;
    type=[type,name,' ',node1,' ',node2,' ',suite];
    if ~isempty(get(handles.edit_option_source,'String'))
        type=[type,' ',get(handles.edit_option_source,'String')];
    end
    
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

end

