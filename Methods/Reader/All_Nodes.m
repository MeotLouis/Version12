function listeNodes = All_Nodes(namespfile)

fid=fopen(namespfile);
tline = fgetl(fid);
tlines = cell(0,1);%Stocke chaque ligne du texte dans une ligne de la matrice tline
tlines{end+1,1}='0';
%%Boucle permettant de récupérer que les lignes concernants les transistors
while ischar(tline)
    
    if ~isempty(tline)
        %Cas des sources simples
        if tline(1)=='v' || tline(1)=='i' || tline(1)=='V' || tline(1)=='I'
            aux=strsplit(tline);
            tlines=Add_Nodes2(tlines,aux{2});
            tlines=Add_Nodes2(tlines,aux{3});
        end
        %Cas des subcircuits
        if tline(1)=='x' || tline(1)=='X'
            aux=strsplit(tline);
            taille=length(aux);
            for i=2:taille-1
                tlines=Add_Nodes2(tlines,aux{i});
            end
        end
        %Cas des transistors
        if tline(1)=='m' || tline(1)=='M'
            aux=strsplit(tline);
            taille=length(aux);
            for i=2:taille
                if ~isempty(aux{i}) && isempty(strfind(aux{i},'_')) && isempty(strfind(aux{i},'='))
                    tlines=Add_Nodes2(tlines,aux{i});
                end
            end
        end
         %Cas des sources complexes
        if tline(1)=='E' || tline(1)=='e' || tline(1)=='f' || tline(1)=='F' || tline(1)=='g' || tline(1)=='G' || tline(1)=='h' || tline(1)=='H'  
            aux=strsplit(tline);
            for i=2:(length(aux)-1)
                tlines=Add_Nodes2(tlines,aux{i});
            end
        end
         %Cas des elements simples
        if tline(1)=='r' || tline(1)=='R' || tline(1)=='d' || tline(1)=='D' || tline(1)=='L' || tline(1)=='c' || tline(1)=='C' || tline(1)=='l'  
            aux=strsplit(tline);
            for i=2:(length(aux)-1)
                tlines=Add_Nodes2(tlines,aux{i});
            end
        end
    end
    tline = fgetl(fid);
end
listeNodes=tlines;
end

