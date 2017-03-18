function PushAddJFET( handles )
name=get(handles.edit_name_JFET,'String');
if isempty(name)
    name=inputdlg('Enter name of JFET transistor');
    name=name{1,1};
end
D=get(handles.edit_D_JFET,'String');
if isempty(D)
    D=inputdlg('Enter name of node connected to D');
    D=D{1,1};
end
G=get(handles.edit_G_JFET,'String');
if isempty(G)
    G=inputdlg('Enter name of node connected to G');
    G=G{1,1};
end
S=get(handles.edit_S_JFET,'String');
if isempty(S)
    S=inputdlg('Enter name of node connected to S');
    S=S{1,1}; 
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
JfetCreator( handles,name,D,G,S,model,foo );

