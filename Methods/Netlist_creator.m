function Netlist_creator( file_asc,file_net,file_out)
%NETSLIST_CREATOR Summary of this function goes here
%   Detailed explanation goes here
fid=fopen(file_asc,'r','n','utf-8');
tline = fgetl(fid);
tlines=cell(0,1);
while ischar(tline)
    if ~isempty(strfind(tline,'SYMATTR'))
        tline=strsplit(tline);
        tlines{end+1,1} = tline{1,1};
        for i=2:length(tline)
            tlines{end,i} = tline{1,i};
        end
    end
    tline = fgetl(fid);
end
fclose(fid);
struct=cell(0,1);
for i=1:(length(tlines))
    if mod(i,2)==1
        struct{end+1,1}=tlines{i,3};
    else
        tlines_provisoire=cell(1,3);
        [~,taille]=size(tlines);
        for j=1:taille
            if strfind(tlines{i,j},'m=')
                tlines_provisoire{1,1}=tlines{i,j};
            end
            if strfind(tlines{i,j},'l=')
                tlines_provisoire{1,3}=tlines{i,j};
            end
            if strfind(tlines{i,j},'w=')
                tlines_provisoire{1,2}=tlines{i,j};
            end
        end
        if isempty(tlines_provisoire{1,1})
            model = inputdlg(['Please enter the model of element ',struct{end,1}]);
            tlines_provisoire{1,3}=['m=',model{1,1}] ;
        end
        if isempty(tlines_provisoire{1,2})
            width = inputdlg(['Please enter the width of element ',struct{end,1}]);
            tlines_provisoire{1,2}=['w=',width{1,1}] ;
        end
        if isempty(tlines_provisoire{1,3})
            width = inputdlg(['Please enter the length of element ',struct{end,1}]);
            tlines_provisoire{1,3}=['l=',width{1,1}] ;
        end
        struct{end,6}=tlines_provisoire{1,1}(3:end);
        struct{end,7}=tlines_provisoire{1,2};
        struct{end,8}=tlines_provisoire{1,3};
    end
end
assignin('base', 'data', struct);
fid=fopen(file_net,'r','n','utf-8');
tline = fgetl(fid);
tlines=cell(0,1);
enregistre=0;
while ischar(tline)
    if ~isempty(strfind(tline,'NETS'))
        enregistre=1;
    end
    if enregistre==1
        tline=strsplit(tline);
        tlines{end+1,1} = tline{1,1};
        for i=2:length(tline)
            tlines{end,i} = tline{1,i};
        end
    end
    tline = fgetl(fid);
end
tlines(1,:)=[];
tlines(end,:)=[];
[lignes,colonnes]=size(tlines);
for i=1:lignes
    for j=1:colonnes
        if j==1
            tlines{i,j}=strrep(tlines{i,j},';','');
        else
            if ~isempty(tlines{i,j})
                tlines{i,j}=strsplit(tlines{i,j},'.');
            end
        end
    end
end
[lignes,colonnes]=size(tlines);
[lignes2,colonnes2]=size(struct);
for i=1:lignes
    for j=2:colonnes
        if ~isempty(tlines{i,j})
            for k=1:lignes2
                if isequal(struct{k,1},tlines{i,j}{1,1})
                    struct{k,1+str2double(tlines{i,j}{1,2})}=tlines{i,1};
                end
            end
        end
    end
end
assignin('base', 'data', struct);
fid=fopen(file_out,'wt');
for i=1:lignes2
    ligne='';
    for j=1:colonnes2
        ligne=[ligne,struct{i,j},' '];
    end
    ligne=strcat(ligne,'\n');
    fprintf(fid,ligne); 
end
fclose(fid);
end