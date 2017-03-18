function PushGenerate(handles)
if isequal(getappdata(0,'type_circuit'),'main')
    if isempty(get(handles.edit_name_circuit,'String'))
        errordlg('Missing name of circuit');
    end
    if isempty(getappdata(0,'project_directory'))
        errordlg('Missing project directory');
        project_directory=uigetdir();
        setappdata(0,'project_directory',project_directory);
    end
    path=getappdata(0,'project_directory');
    name=get(handles.edit_name_circuit,'String');
    %/!\METTRE ICI LE CONDITION DE SUPPRESSION DE L'ANCIEN FICHIER S'IL EXISTE
    name_file=[path,'\',name,'.sp'];
    if exist(name_file,'file')~=0
        delete(name_file);
    end

    fid=fopen(name_file,'at');
    tlines=get(handles.listbox_all_lines,'String');
    [lignes,~]=size(tlines);
    for i=1:lignes
       fprintf(fid, strcat(tlines{i,1},'\n')); 
    end
    fprintf(fid,'\n');
    fclose(fid);
    close(GUI_create_sp_file);
    GUI_Parent()
else
    errordlg('You circuit must be the Main Circuit to be generated as a sp file');
end