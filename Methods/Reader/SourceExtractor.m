function [ source,tlines ] = SourceExtractor( input_args )
%SOURCEEXTRACTOR Summary of this function goes here
%   Detailed explanation goes here
fid=fopen(input_args);
tline = fgetl(fid);
tlines=cell(0,1);
source=cell(0,1);
source{end+1,1}='-';
while ischar(tline)
    tlines{end+1,1}=tline;
     tline=strsplit(tline);
     premier=tline{1,1};
     if ~isempty(premier)
        pattern={'v','V','i','I','e','E','f','F','g','G','h','H'};
        for i=1:12
            if premier(1)==pattern{1,i}
                 source{end+1,1}=premier;
            end
        end
    end
    tline = fgetl(fid);
end
fclose(fid);
end



