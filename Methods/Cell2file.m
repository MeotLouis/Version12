function Cell2file( list, file )
[nbRow,nbCol]=size(list);
ligne='';
fileID = fopen(file,'w');
for j=1:nbCol
    for i=1:nbRow
        ligne=[ligne,list{i,j},' '];
    end
    ligne=[ligne,'\n'];
    fprintf(fileID,ligne);
    ligne='';
end
fclose(fileID);