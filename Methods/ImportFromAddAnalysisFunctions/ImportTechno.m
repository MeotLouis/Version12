function ImportTechno( tlines,handles,file )
%IMPORTTECHNO Summary of this function goes here
%   Detailed explanation goes here
[pathstr,name,ext] = fileparts(file);
filetechno=[pathstr,'\',tlines{1,2}];
set(handles.edit_path_technology,'string',filetechno);
setappdata(0,'file_technology',tlines{1,2});
setappdata(0,'full_file_technology',filetechno);
[a,b]=libraryReader(filetechno);
set(handles.popup_techno,'String',a);
setappdata(0,'list_models',b);
setappdata(0,'quelle_techno',a{1,1});
contents = cellstr(get(handles.popup_techno,'String'));
setappdata(0,'quelle_techno',contents{get(handles.popup_techno,'Value')});
b=getappdata(0,'list_models');
setappdata(0,'current_models',b(get(handles.popup_techno,'Value'),:));
set(handles.popup_JFET,'enable','on');
set(handles.popup_JFET,'String',getappdata(0,'current_models')');
set(handles.popup_MOSFET,'enable','on');
set(handles.popup_MOSFET,'String',getappdata(0,'current_models')');
set(handles.popup_bipolar,'enable','on');
set(handles.popup_bipolar,'String',getappdata(0,'current_models')');
setappdata(0,'import_techno_already_done',0);


