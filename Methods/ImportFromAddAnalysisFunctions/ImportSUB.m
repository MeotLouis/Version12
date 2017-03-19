function ImportSUB(tline,handles,subcircuitlist)
%IMPORTSUB Summary of this function goes here
%   Detailed explanation goes here
[nbsub,~]=size(subcircuitlist);
for i=1:nbsub
    if isequal(subcircuitlist{i,1}{1,2},tline{1,end})
        index=i;
    end
end
base2=subcircuitlist{index,1};
[~,a]=size(base2);
base=base2{1,3};
for i=4:a
    base=[base,' ',base2{1,i}];
end
text2=tline;
[~,a]=size(text2);
text=text2{1,2};
for i=3:a-1
    text=[text,' ',text2{1,i}];
end
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
name=tline{1,1};
type=tline{1,end};
SubcircuitCreator( handles,name,base1,text1 );


