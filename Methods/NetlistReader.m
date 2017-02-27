function [ output_args,d ] = NetlistReader( input_args )
%NETLISTREADER Summary of this function goes here
%   Detailed explanation goes here
fid=fopen(input_args);
tline = fgetl(fid);
tlines=cell(0,1);
nodes=cell(0,1);
while ischar(tline)
    tlines{end+1,1}=tline;
    tline=strsplit(tline);
    [~,a]=size(tline);
    for i=2:a
        c=0;
        [b,~]=size(nodes);
        if isempty(strfind(tline{1,i},'='))&&~isempty(tline{1,i})&&isempty(strfind(tline{1,i},'_'))
            for j=1:b
                if isequal(tline{1,i},nodes{j,1})
                    c=c+1;
                end
            end
            if c==0
                nodes{end+1,1}=tline{1,i};
            end
        end
    end
    
    tline = fgetl(fid);
end
fclose(fid);
output_args=nodes;
output_args=AlphabeticalSorter(output_args);
tlines{end+1,1}='.ends';
d=tlines;
end

