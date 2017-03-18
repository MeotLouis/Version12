function PushAddName( handles )
%PUSHADDNAME Summary of this function goes here
%   Detailed explanation goes here
if isempty(get(handles.edit_name_netlist,'String'))
    errordlg('Missing name');
else
    text=get(handles.edit_name_netlist,'String');
    setappdata(0,'name_netlist',text);
    setappdata(0,'nb_netlist',getappdata(0,'nb_netlist')+1);
    set(hObject,'Enable','on');
    set(handles.edit_netlist_subckt,'String',[get(handles.edit_netlist_subckt,'String'),' ',text,' ']);
    
%     %----UPDATE DATA-----%
%     data=getappdata(0,'data');
%     dataNetlist=cell(5,1);
%     dataNetlist{1,1}='nelist';
%     dataNetlist{2,1}=text;
%     dataNetlist{3,1}=cell(0,1);
%     dataNetlist{4,1}=cell(0,1);
%     dataNetlist{5,1}={0,0};
%     dataNetlist{6,1}={10,10};
%     data{end+1,1}=dataNetlist;
%     setappdata(0,'data',data);
%     %----END UPDATE DATA---%
end

