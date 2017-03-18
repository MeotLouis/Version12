function SubcircuitCreator( handles,name,base1,text1 )
%SUBCIRCUITCREATOR Summary of this function goes here
%   Detailed explanation goes here
%Test si le nom est déja utilisé et n'utilise pas une lettre non
%autorisée
data=getappdata(0,'data');
bool=0;
bool2=0;
for i=2:length(data);
    if isequal(name,data{i,1}{2,1})
        bool=1;
    end
end
pattern={'e','f','g','h','v','i','d','k','l','c','E','F','G','H','V','I','D','K','L','C'};
for i=1:length(pattern)
    if ~isempty(strfind(name,pattern{1,i}))
        bool2=1;
        letter=pattern{1,i};
    end
end
if bool==1
    errordlg('Name already in use');
elseif bool2==1
    errordlg(sprintf(['Invalid name, you can not use the letter ''',letter,''' at the beginning of the name\nYou can use X for example.']));
else   
    %----UPDATE DATA-----%

    dataNetlist=cell(5,1);
    dataNetlist{1,1}='netlist';
    dataNetlist{2,1}=name;
    dataNetlist{3,1}=cell(0,1);
    [~,a]=size(base1);
    for i=1:a
        if ~isequal(base1{1,i},'')
            dataNetlist{3,1}{end+1,1}=base1{1,i};
        end
    end
    dataNetlist{4,1}=cell(0,1);
    [~,b]=size(text1);
    for i=1:b
        if ~isequal(text1{1,i},'')
            dataNetlist{4,1}{end+1,1}=text1{1,i};
            Add_Nodes(text1{1,i});

        end
    end
    dataNetlist{5,1}={0,0};
    dataNetlist{6,1}={10,10};
    data=getappdata(0,'data');
    data{end+1,1}=dataNetlist;
    setappdata(0,'data',data);
    %----END UPDATE DATA---%
    set(handles.popup_node_netlist,'String',data{1,1});
    set(handles.popup_node1_element,'String',data{1,1});
    set(handles.popup_node2_element,'String',data{1,1});
    contents = cellstr(get(handles.popup_add_netlist,'String'));
    select=contents{get(handles.popup_add_netlist,'Value')};
    liste=get(handles.listbox_all_lines,'String');
    liste{end+1,1}=[name,' ',get(handles.edit_add_netlist,'String'),' ',select];
    set(handles.listbox_all_lines,'String',liste);
    [a,~]=size(liste);
    set(handles.listbox_all_lines,'Value',a);
    set(handles.popup_add_netlist,'Value',1);
    set(handles.static_add_netlist,'String','');
    set(handles.edit_add_netlist,'String','');
    set(handles.edit_name_netlist2,'String','');

    %-----Affichage graphique-----%
    CalculCoordonates(handles);
end


