function PushImportFile( handles )
%PUSHIMPORTFILE Summary of this function goes here
%   Detailed explanation goes here
if ~isempty(get(handles.edit_path_file2,'String'))
    fid2=fopen(get(handles.edit_path_file2,'String'));
    tline = fgetl(fid2);
    tlines2=cell(0,1);
    while ischar(tline)
        tlines2{end+1,1} = tline;
        tline = fgetl(fid2);
    end
    fclose(fid2);
    [a,~]=size(tlines2);
    for i=1:a
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=tlines2{i,1};
        set(handles.listbox_all_lines,'String',liste);
    end
end

