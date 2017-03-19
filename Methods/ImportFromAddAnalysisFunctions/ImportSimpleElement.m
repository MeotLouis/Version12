function ImportSimpleElement(tline,handles)
%IMPORTSIMPLEELEMENT Summary of this function goes here
%   Detailed explanation goes here
type=tline{1,1}(1);
if ~isempty(regexp(type,'[a-z]','ONCE'))
    upper(type);
end
type=tline{1,1}(1);
node1=tline{1,2};
node2=tline{1,3};
value=tline{1,4};
name=tline{1,1}(2:end);
SimpleElementCreator( handles,name,node1,node2,type,value)
end


