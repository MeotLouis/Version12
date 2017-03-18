function PushAddElement( handles )
%PUSHADDELEMENT Summary of this function goes here
%   Detailed explanation goes here
contents = cellstr(get(handles.popup_type_element,'String'));
select = contents{get(handles.popup_type_element,'Value')};
if isequal(select,'-')
    errordlg('Missing type of element');
elseif isempty(get(handles.edit_name_element,'String'))
    errordlg('Missing name of element');
elseif isempty(get(handles.edit_value_element,'String'))
    errordlg('Missing value of element');
else
    type=select;
    contents = cellstr(get(handles.popup_node1_element,'String'));
    select = contents{get(handles.popup_node1_element,'Value')};
    node1=select;
    contents = cellstr(get(handles.popup_node2_element,'String'));
    select = contents{get(handles.popup_node2_element,'Value')};
    node2=select;
    value=get(handles.edit_value_element,'String');
    %On effectue cette boucle pour voir si la valeur est une équation et
    %mettre des '' si elle en est une
    pattern={'*','+','/','-'};
    a=0;
    for j=1:4
        if ~isempty(strfind(value,pattern{1,j}))
            a=a+1;
        end
    end
    if a~=0
        value=['''',value,''''];
    end
    %Test si le nom est déja utilisé
    name=get(handles.edit_name_element,'String');
    data=getappdata(0,'data');
    bool=0;
    for i=2:length(data);
        if isequal(name,data{i,1}{2,1})
            bool=1;
        end
    end
    if bool==1
        errordlg('Name already in use');
    else
        %---------UPDATE DATA----%
        data=getappdata(0,'data');
        dataElement=cell(8,1);
        dataElement{1,1}='element';
        dataElement{2,1}=name;
        dataElement{3,1}=node1;
        dataElement{4,1}=node2;
        dataElement{5,1}=type;
        dataElement{6,1}=value;
        dataElement{7,1}={0,0};
        dataElement{8,1}={10,10};
        data{end+1,1}=dataElement;
        setappdata(0,'data',data);
        %---------END UPDATE DATA----%

        type=[type,name,' ',node1,' ',node2,' ',value];
        if ~isempty(get(handles.edit_option_element,'String'))
            type=[type,' ',get(handles.edit_option_source,'String')];
        end
        %REset edit text
        set(handles.edit_name_element,'String','');
        set(handles.edit_value_element,'String','');
        set(handles.edit_option_element,'String','');
        set(handles.popup_type_element,'Value',1);
        %Update listbox all lines
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=type;
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        %-----Affichage graphique-----%
        CalculCoordonates(handles);
    end
end

