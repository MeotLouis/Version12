function PushAddBipolar( handles )
%PUSHADDBIPOLAR Summary of this function goes here
%   Detailed explanation goes here
name=get(handles.edit_name_bipolar,'String');
if isempty(name)
    name=inputdlg('Enter name of Bipolar transistor');
    name=name{1,1};
end
E=get(handles.edit_E_bipolar,'String');
if isempty(E)
    E=inputdlg('Enter name of node connected to Emettor');
    E=E{1,1};
end
B=get(handles.edit_B_bipolar,'String');
if isempty(B)
    B=inputdlg('Enter name of node connected to Base');
    B=B{1,1};
end
C=get(handles.edit_C_bipolar,'String');
if isempty(C)
    C=inputdlg('Enter name of node connected to Collector');
    C=C{1,1};
end
model='';
if ~isempty(get(handles.edit_path_technology,'String'))
    %Copie du fichier .lib
    foo=strsplit(get(handles.edit_path_technology,'String'),'\');
    foo=foo(end);
    destination=strcat(getappdata(0,'project_directory'),'\',foo);
    destination=destination{1,1};
    if ~isequal(get(handles.edit_path_technology,'String'),destination)
        copyfile(get(handles.edit_path_technology,'String'),destination,'f');
        %Bloc permettant de copier le fichier .mdl
        path_mld=get(handles.edit_path_technology,'String');
        path_mld=path_mld(1:end-3);
        path_mld=[path_mld,'mdl'];
        destination=destination(1:end-3);
        destination=[destination,'mdl'];
        assignin('base','path_mld',path_mld);
        if exist(path_mld, 'file') ~= 0
            copyfile(path_mld,destination,'f'); 
        end
    end
    
    model=getappdata(0,'current_models')';
    model=model{get(handles.popup_bipolar,'Value')};
end

%-----Data update-----%
Add_Nodes(C);
Add_Nodes(B);
Add_Nodes(E);
data_bipolar=cell(0,1);
data_bipolar{end+1,1}='Bipolar';
data_bipolar{end+1,1}=['G',name];
data_bipolar{end+1,1}=C;
data_bipolar{end+1,1}=B;
data_bipolar{end+1,1}=E;
data_bipolar{end+1,1}=model;
data=getappdata(0,'data');
data{end+1,1}=data_bipolar;
setappdata(0,'data',data);
set(handles.popup_node1_element,'String',data{1,1});
set(handles.popup_node2_element,'String',data{1,1});
set(handles.popup_node_netlist,'String',data{1,1});

%------ListBox Update----%
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
liste{end+1,1}=['G',name,' ',C,' ',B,' ',E,' ',model];
set(handles.listbox_all_lines,'String',liste);

%-----REset of fields------%
set(handles.edit_C_bipolar,'String','');
set(handles.edit_name_bipolar,'String','');
set(handles.edit_B_bipolar,'String','');
set(handles.edit_E_bipolar,'String','');
set(handles.popup_bipolar,'Value',1);

%-----Affichage graphique-----%
        CalculCoordonates(handles);

