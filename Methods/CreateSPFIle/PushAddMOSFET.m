function PushAddMOSFET( handles )
%PUSHADDMOSFET Summary of this function goes here
%   Detailed explanation goes here
name=get(handles.edit_name_MOSFET,'String');
if isempty(name)
    name=inputdlg('Enter name of MOSFET transistor');
    name=name{1,1};
end
D=get(handles.edit_D_MOSFET,'String');
if isempty(D)
    D=inputdlg('Enter name of node connected to D');
    D=D{1,1};
end
G=get(handles.edit_G_MOSFET,'String');
if isempty(G)
    G=inputdlg('Enter name of node connected to G');
    G=G{1,1};
end
S=get(handles.edit_S_MOSFET,'String');
if isempty(S)
    S=inputdlg('Enter name of node connected to S');
    S=S{1,1}; 
end
l=get(handles.edit_l_MOSFET,'String');
if isempty(l)
    l=inputdlg('Enter length of MOSFET');
    l=l{1,1}; 
end
w=get(handles.edit_w_MOSFET,'String');
if isempty(w)
    w=inputdlg('Enter width of MOSFET');
    w=w{1,1}; 
end
if ~isempty(get(handles.edit_B_MOSFET,'String'))
    Add_Nodes(get(handles.edit_B_MOSFET,'String'));
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
    model=model{get(handles.popup_MOSFET,'Value')};
end

%-----Data update-----%
Add_Nodes(D);
Add_Nodes(G);
Add_Nodes(S);
data_bipolar=cell(0,1);
data_bipolar{end+1,1}='MOSFET';
data_bipolar{end+1,1}=['M',name];
data_bipolar{end+1,1}=D;
data_bipolar{end+1,1}=G;
data_bipolar{end+1,1}=S;
if ~isempty(get(handles.edit_B_MOSFET,'String'))
    data_bipolar{end+1,1}=get(handles.edit_B_MOSFET,'String');
    S=[S,' ',get(handles.edit_B_MOSFET,'String')];
else
    data_bipolar{end+1,1}='false';
end
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
a=['M',name,' ',D,' ',G,' ',S,' ',model,' ','l=',l,' ','w=',w];
if ~isempty(get(handles.edit_m,'String'))
    a=[a,' ','M=',get(handles.edit_m,'String')];
end
liste{end+1,1}=a;
set(handles.listbox_all_lines,'String',liste);
set(handles.edit_D_MOSFET,'String','');
set(handles.edit_G_MOSFET,'String','');
set(handles.edit_S_MOSFET,'String','');
set(handles.edit_B_MOSFET,'String','');
set(handles.edit_name_MOSFET,'String','');
set(handles.edit_l_MOSFET,'String','');
set(handles.edit_w_MOSFET,'String','');
set(handles.edit_m,'String','');
set(handles.popup_MOSFET,'Value',1);

%-----Affichage graphique-----%
        CalculCoordonates(handles);

