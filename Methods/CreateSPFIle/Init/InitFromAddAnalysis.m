function InitFromAddAnalysis( handles )
setappdata(0,'type_circuit','main');
set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'off')
set(handles.Subcircuit_Checkbox,'Value',0);
set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'on')
set(handles.text_help_sub,'enable','on');
%On va essayer de tout stocker dans 'data'
data=cell(0,1);
data{end+1}=cell(0,1);
setappdata(0,'data',data);
setappdata(0,'type_circuit','main');
setappdata(0,'nb_ports',0);
setappdata(0,'list_nodes',cell(0,1));
setappdata(0,'list_nodes_netlist',cell(0,1));
setappdata(0,'name_netlist',[]);
setappdata(0,'nb_netlist',0);
setappdata(0,'list_netlist',cell(0,1));
setappdata(0,'import_techno_already_done',0);
axes(handles.axes1);
axis off;

%Now we load the sp file
fileToLoad=getappdata(0,'file_press_back');
setappdata(0,'file_press_back','false');
SpFileReader(fileToLoad,handles);


% % IMPORT OF .INC FILES
% list_files=cellstr(ls(getappdata(0,'project_directory')));
% list2=cell(0,1);
% nb=0;
% list_netlist2=cell(0,1);
% [nb_ligne,~]=size(list_files);
% if nb_ligne>2
%     for i=3:nb_ligne
%         aux2=list_files{i,1};
%         aux=strsplit(list_files{i,1},'.');
%         if isequal(aux{1,2},'inc')
%             list2{end+1,1}=aux{1,1};
%             nb=nb+1;
%             display(aux2);
%             presence=0;
%             fid=fopen([getappdata(0,'project_directory'),'\',aux2]);
%             tline=fgetl(fid);
%             while ischar(tline)&&presence==0
%                 if ~isempty(strfind(tline,'.subckt'))
%                     list_netlist=getappdata(0,'list_netlist');
%                     list_netlist{end+1,1}=tline;
%                     setappdata(0,'list_netlist',list_netlist);
%                     presence=1;
%                 end
%                 tline=fgetl(fid);
%             end
%             fclose(fid);
%         end
%     end
% %     list=get(handles.popup_add_netlist,'String');
% %     if ~iscell(list)
% %         list3=cell(0,1);
% %         list3{end+1,1}=list;
% %         list=list3;
% %     end
%     list={'-'};
%     for i=1:nb
%         list{end+1,1}=list2{i,1};
%     end
%     set(handles.popup_add_netlist,'String',list);
%     
% end
% 
