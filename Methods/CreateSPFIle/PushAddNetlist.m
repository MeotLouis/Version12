function PushAddNetlist( handles )
%PUSHADDNETLIST Summary of this function goes here
%   Detailed explanation goes here
base=get(handles.static_add_netlist,'String');
text=get(handles.edit_add_netlist,'String');
base1=strsplit(base);
text1=strsplit(text);
[~,a]=size(base1);
aa=a;
for i=1:a
    if isequal(base1{1,i},'')
        aa=aa-1;
    end
end
[~,b]=size(text1);
bb=b;
for i=1:b
    if isequal(text1{1,i},'')
        bb=bb-1;
    end
end
name=get(handles.edit_name_netlist2,'String');
contents = cellstr(get(handles.popup_add_netlist,'String'));
type=contents{get(handles.popup_add_netlist,'Value')};
if aa~=bb
    errordlg(['You must connect all ports of the netlist. Number required: ',num2str(aa),' Number you have submited:',num2str(bb)]);
elseif isempty(name)
     errordlg('Missing name of element');   
elseif isequal(type,'-')
    errordlg('Missing type of subcircuit');
else
   SubcircuitCreator( handles,name,base1,text1 );
end

