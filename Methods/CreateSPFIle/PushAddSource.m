function PushAddSource(handles)
contents = cellstr(get(handles.popupmenu2,'String'));
select = contents{get(handles.popupmenu2,'Value')};
[~,b]=size(select);
if b==2
    errordlg('Missing type of source');
elseif isempty(get(handles.edit_name_source,'String'))
    errordlg('Missing name of source');
elseif isempty(get(handles.edit_node1_source,'String'))
    errordlg('Missing ports +');
elseif isempty(get(handles.edit_node2_source,'String'))
    errordlg('Missing ports -');
else
    if isequal(select,'V')||isequal(select,'I')
        if isempty(get(handles.edit_value_source,'String'));
            value=inputdlg('Please enter value of source:');
            value=value{1,1};
        else
            value=get(handles.edit_value_source,'String');
            value=IsOperation(value);
        end
        suite=value;
    else
        if isequal(select,'E')
            in1=get(handles.edit_in1,'String');
            if isempty(in1);
                in1=inputdlg('Please enter name of control node +:');
                in1=in1{1,1};
            end
            in2=get(handles.edit_in2,'String');
            if isempty(in2);
                in2=inputdlg('Please enter name of control node -:');
                in2=in2{1,1};
            end 
            gain=get(handles.edit_gain,'String');
            if isempty(gain);
                gain=inputdlg('Please gain of source value:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[in1,' ',in2,' ',gain];
            else
                suite=[keyword,' ',in1,' ',in2,' ',gain];
            end
            Add_Nodes(in1);
            Add_Nodes(in2);
        elseif isequal(select,'F')
            vn1=get(handles.edit_vn1,'String');
            if isempty(vn1);
                vn1=inputdlg('Please enter name of voltage source who take the flow:');
                vn1=vn1{1,1};
            end
            gain=get(handles.edit_gain,'String');
            if isempty(gain);
                gain=inputdlg('Please gain of source value:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[vn1,' ',gain];
            else
                suite=[keyword,' ',vn1,' ',gain];
            end
        elseif isequal(select,'G')
            in1=get(handles.edit_in1,'String');
            if isempty(in1);
                in1=inputdlg('Please enter name of control node +:');
                in1=in1{1,1};
            end
            in2=get(handles.edit_in2,'String');
            if isempty(in2);
                in2=inputdlg('Please enter name of control node -:');
                in2=in2{1,1};
            end 
            gain=get(handles.edit_transC,'String');
            if isempty(gain);
                gain=inputdlg('Please value of transconductance:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[in1,' ',in2,' ',gain];
            else
                suite=[keyword,' ',in1,' ',in2,' ',gain];
            end
            Add_Nodes(in1);
            Add_Nodes(in2);
        else
            vn1=get(handles.edit_vn1,'String');
            if isempty(vn1);
                vn1=inputdlg('Please enter name of voltage source who take the flow:');
                vn1=vn1{1,1};
            end
            gain=get(handles.edit_transR,'String');
            if isempty(gain);
                gain=inputdlg('Please value of transresistance:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[vn1,' ',gain];
            else
                suite=[keyword,' ',vn1,' ',gain];
            end
        end
    end
    
    type=select;
    name=get(handles.edit_name_source,'String');
    node1=get(handles.edit_node1_source,'String');
    node2=get(handles.edit_node2_source,'String');
    type2=type;
    type=[type,name,' ',node1,' ',node2,' ',suite];
    if ~isempty(get(handles.edit_option_source,'String'))
        type=[type,' ',get(handles.edit_option_source,'String')];
    end
    
    SourceCreator( node1,node2,name,type2,value );
end

