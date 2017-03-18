function PushAddPortNetlist(handles)
%PUSHADDPORTNETLIST Summary of this function goes here
%   Detailed explanation goes here
if isempty(getappdata(0,'name_netlist'))
     errordlg('Missing name of netlist');
else
    %update de la list de port du panel add subcircuit
    contents = cellstr(get(handles.popup_node_netlist,'String'));
    port=contents{get(handles.popup_node_netlist,'Value')};
    display(port);
    if isequal(port,'')
        errordlg('Please add at least one element to generate port');
    else
        list_nodes=getappdata(0,'list_nodes');
        list_nodes{end+1,1}=port;
        setappdata(0,'list_nodes',list_nodes);
        set(handles.popup_node1_element,'String',list_nodes);
        set(handles.popup_node2_element,'String',list_nodes);
        ligne=get(handles.edit_netlist_subckt,'String');
        ligne=[ligne,port,' '];
        setappdata(0,'nb_ports',getappdata(0,'nb_ports')+1);
        set(handles.edit_netlist_subckt,'String',ligne);
        list_nodes_netlist=getappdata(0,'list_nodes_netlist');
        list_nodes_netlist{end+1,1}=port;
        setappdata(0,'list_nodes_netlist',list_nodes_netlist);

        %----UPDATE DATA-----%
        Add_Nodes(port);
        data=getappdata(0,'data');
        %update popup node elements
        set(handles.popup_node1_element,'String',data{1,1});
        set(handles.popup_node2_element,'String',data{1,1});
        set(handles.popup_node_netlist,'String',data{1,1});

        %data{end,1}{5,1}{end+1,1}=port;
        %setappdata(0,'data',data);
        %----END UPDATE DATA---%
    end
end


