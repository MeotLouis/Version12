function AddSignal(file,lignes)
%ADDSIGNAL Summary of this function goes here
%   Detailed explanation goes here
fid=fopen(file,'r');
tline = fgetl(fid);
tlines=cell(0,1);
while ischar(tline)
    if ~isempty(strfind(tline,'.end'))
        if ~isequal(tline,'.ends')
            i=1;
            ligne='.PRINT';
            while i<=length(lignes)
                if ~isempty(strfind(lignes{i,1},'V('))
                    ligne=[ligne,' ','VM(',lignes{i,1}(3:end-1),')',' ','VP(',lignes{i,1}(3:end-1),')'];
                else
                    ligne=[ligne,' ',lignes{i,1}];
                end
                i=i+1;
            end
            tlines{end+1,1}=ligne;
        end
    end
    tlines{end+1,1}=tline;
    tline = fgetl(fid);
end
fclose(fid);

fid=fopen(file,'wt');
for i=1:length(tlines)
   fprintf(fid, strcat(tlines{i,1},'\n')); 
end
fclose(fid);

