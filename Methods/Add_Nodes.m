function Add_Nodes( node )
%ADD_NODES Summary of this function goes here
%   Detailed explanation goes here
data=getappdata(0,'data');
list_nodes=data{1,1};
[taille,~]=size(list_nodes);
presence=0;
for i=1:taille
    if isequal(list_nodes{i,1},node)
        presence=1;
    end
end
if presence==0
    list_nodes{end+1,1}=node;
    list_nodes=AlphabeticalSorter(list_nodes);
    data{1,1}=list_nodes;
    setappdata(0,'data',data);
end

