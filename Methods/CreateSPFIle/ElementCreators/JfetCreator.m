function JfetCreator( handles,name,D,G,S,model,foo )

%-----Data update-----%
Add_Nodes(D);
Add_Nodes(G);
Add_Nodes(S);
data_bipolar=cell(0,1);
data_bipolar{end+1,1}='JFET';
data_bipolar{end+1,1}=['J',name];
data_bipolar{end+1,1}=D;
data_bipolar{end+1,1}=G;
data_bipolar{end+1,1}=S;
data_bipolar{end+1,1}=model;
data=getappdata(0,'data');
data{end+1,1}=data_bipolar;
setappdata(0,'data',data);
set(handles.popup_node1_element,'String',data{1,1});
set(handles.popup_node2_element,'String',data{1,1});
set(handles.popup_node_netlist,'String',data{1,1});

liste=get(handles.listbox_all_lines,'String');
%Import du nom de la techno et ecriture dans le fichier
if ~isempty(model)&&getappdata(0,'import_techno_already_done')==0;
    liste{end+1,1} = '';
    liste{end+1,1} = '*Import libraries';
    liste{end+1,1} = '';
    liste{end+1,1} = '.prot';
    liste{end+1,1} = ['.LIB ','./',foo{1,1},' ',getappdata(0,'quelle_techno')];
    liste{end+1,1} = '.unprot';
    liste{end+1,1} = '';
    setappdata(0,'import_techno_already_done',1);
end
liste{end+1,1}=['J',name,' ',D,' ',G,' ',S,' ',model];
set(handles.listbox_all_lines,'String',liste);
set(handles.edit_D_JFET,'String','');
set(handles.edit_G_JFET,'String','');
set(handles.edit_S_JFET,'String','');
set(handles.edit_name_JFET,'String','');
set(handles.popup_JFET,'Value',1);

%-----Affichage graphique-----%
        CalculCoordonates(handles);


