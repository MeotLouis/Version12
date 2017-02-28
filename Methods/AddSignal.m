function AddSignal(file,lignes)
%ADDSIGNAL Summary of this function goes here
%   Detailed explanation goes here
if ~isempty(lignes)
    fid=fopen(file,'r');
    tline = fgetl(fid);
    tlines=cell(0,1);
    while ischar(tline)
        tline = fgetl(fid);
        tlines{end+1,1}=tline;
    end
    fclose(fid);
    assignin('base','tlines',tlines);
    [a,b]=size(tlines);
    for k=1:a
        tline=tlines{k,1};
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
                if k==a
                    tlines{end+1,1}=tline;
                end
                tlines{k,1}=ligne;
            end
        end
    end
    tlines{end,1}='.end';
    assignin('base','tlines2',tlines);
    assignin('base','lignes',lignes);
    delete(file);
    fid=fopen(file,'wt');
    for i=1:length(tlines)
       fprintf(fid, strcat(tlines{i,1},'\n')); 
    end
    fclose(fid);
end


