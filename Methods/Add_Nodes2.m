function tlines_out = Add_Nodes2(tlines,node )
%ADD_NODES Summary of this function goes here
%   Detailed explanation goes here
list_nodes=tlines;
[taille,~]=size(list_nodes);
presence=0;
for i=1:taille
    if isequal(list_nodes{i,1},node)
        presence=1;
    end
end
if presence==0
    list_nodes{end+1,1}=node;
end
tlines_out=list_nodes;

