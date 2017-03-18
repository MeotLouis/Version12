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
B='false';
if ~isempty(get(handles.edit_B_MOSFET,'String'))
    Add_Nodes(get(handles.edit_B_MOSFET,'String'));
    B=get(handles.edit_B_MOSFET,'String');
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
MosfetCreator( handles,name,D,G,S,l,w,B,model,foo );