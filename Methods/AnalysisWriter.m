function AnalysisWriter( tlines,path )
%ANALYSISWRITER Summary of this function goes here
%   Detailed explanation goes here
%/!\METTRE ICI LE CONDITION DE SUPPRESSION DE L'ANCIEN FICHIER S'IL EXISTE
if exist(path,'file')~=0
    delete(path);
end
fid=fopen(path,'at');
[lignes,~]=size(tlines);
for i=1:lignes
   fprintf(fid, strcat(tlines{i,1},'\n')); 
end
fclose(fid);
end

