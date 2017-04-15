function Init_GUI_Parent(handles)
current=pwd;
current2=pwd;
path2=[current,'\'];
setappdata(0,'current_directory_project',path2);
display([path2,'Data\data.txt']);
fid=fopen([path2,'Data\data.txt']);
%fid=fopen('data.txt');
tline=fgetl(fid);
tline=strsplit(tline,'\');
path2='';
for i=1:length(tline)
    if ~isempty(strfind(tline{1,i},' '))&&isempty(strfind(tline{1,i},'"'))
        path2=[path2,'"',tline{1,i},'"\'];
    else
        path2=[path2,tline{1,i},'\'];
    end
end
path2=path2(1:end-1);
setappdata(0,'path_Adobe',path2);
tline=fgetl(fid);
tline=strsplit(tline,'\');
path2='';
for i=1:length(tline)
    if ~isempty(strfind(tline{1,i},' '))&&isempty(strfind(tline{1,i},'"'))
        path2=[path2,'"',tline{1,i},'"\'];
    else
        path2=[path2,tline{1,i},'\'];
    end
end
path2=path2(1:end-1);
setappdata(0,'path_LTSpice',path2);
tline=fgetl(fid);
tline=strsplit(tline,'\');
path2='';
for i=1:length(tline)
    if ~isempty(strfind(tline{1,i},' '))&&isempty(strfind(tline{1,i},'"'))
        path2=[path2,'"',tline{1,i},'"\'];
    else
        path2=[path2,tline{1,i},'\'];
    end
end
path2=path2(1:end-1);
setappdata(0,'path_Hspice',path2);
fclose(fid);
axes(handles.axes1)
path3=[current2,'\'];
matlabImage = imread([path3,'Data\IMG_200880.png']);
image(matlabImage)
axis off
axis image
if ~isempty(getappdata(0,'project_directory'));
    set(handles.edit_path_project,'String',getappdata(0,'project_directory'));
else
    set(handles.push_create,'enable','off');
end
setappdata(0,'file_press_back','false');
