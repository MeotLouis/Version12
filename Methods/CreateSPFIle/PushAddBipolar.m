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
BipolarCreator( handles,C,B,E,name,model,foo );
