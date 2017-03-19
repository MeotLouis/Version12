function ImportSource(tline,handles)
%IMPORTSOURCE Summary of this function goes here
%   Detailed explanation goes here
select = tline{1,1}(1);
if isequal(select,'V')||isequal(select,'I')||isequal(select,'v')||isequal(select,'i')
    value=tline{1,4};
    suite='';
else
    if isequal(select,'E')||isequal(select,'e')
        in1=tline{1,4};
        in2=tline{1,5};
        gain=tline{1,6};
        value=gain;
        suite=[in1,' ',in2,' ',gain];
        Add_Nodes(in1);
        Add_Nodes(in2);
    elseif isequal(select,'F')||isequal(select,'f')
        vn1=tline{1,4};
        gain=tline{1,5};
        value=gain;
        suite=[vn1,' ',gain];
    elseif isequal(select,'G')||isequal(select,'g')
        in1=tline{1,4};
        in2=tline{1,5};
        gain=tline{1,6};
        value=gain;
        suite=[in1,' ',in2,' ',gain];
        Add_Nodes(in1);
        Add_Nodes(in2);
    else
        vn1=tline{1,4};
        gain=tline{1,5};
        value=gain;
        suite=[vn1,' ',gain];
    end
end
type=select;
name=tline{1,1}(2:end);
node1=tline{1,2};
node2=tline{1,3};
type2=type;
type=[type,name,' ',node1,' ',node2,' ',suite];

SourceCreator( node1,node2,name,type2,type,value,handles );

