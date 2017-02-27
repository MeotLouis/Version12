function listeTransitor = SignalExtractor(namelisfile)
fid=fopen(namelisfile);
tline = fgetl(fid);
data = cell(0,1);%Stocke chaque ligne du texte dans une ligne de la matrice tline
enregistre=0;
%%Boucle permettant de récupérer que les lignes concernants les transistors
while ischar(tline)
    if isequal(tline,' x')
        enregistre=1;
        data{end+1,1} = cell(0,1);
    end
    if isequal(tline,'x')
        enregistre=1;
        data{end+1,1} = cell(0,1);
    end
    if isequal(tline,'y')
        enregistre=0;
    end
    if (enregistre==1)&&(~isempty(tline))
        tline=strsplit(tline);
        if  isequal(tline{end},'')
            tline(:,end) = [];
        end
        if isequal(tline{1},'')
            tline(:,1) = [];
        end
        data{end,1}{end+1,1}=cell(1,length(tline));
        for i=1:length(tline)
            data{end,1}{end,1}{1,i}=tline{i};
        end
    end
    tline = fgetl(fid);
end
fclose(fid);
for i=1:length(data)
    data{i,1}(1)=[];
    data{i,1}{2,1}{1,end+1}='';
    for j=(length(data{i,1}{2,1})-1):-1:1
        data{i,1}{2,1}{1,j+1}=data{i,1}{2,1}{1,j};
    end
    data{i,1}{2,1}{1,1}='';
    if i~=1
        for j=1:length(data{i,1})
            data{i,1}{j,1}(1)=[];
            taille=length(data{1,1}{j,1});
            taille2=length(data{i,1}{j,1});
            k=1;
            while k<=taille2
                data{1,1}{j,1}{taille+k}=data{i,1}{j,1}{k};
                k=k+1;
            end
        end
    end
end
data=data{1,1};
for i=1:length(data)
    for j=1:length(data{i,1})
        data2{i,j}=data{i,1}{1,j};
    end
end
data=data2;
j=1;
[~,taille]=size(data);
while j<taille
    if isequal(data{1,j},'voltage')
        if isequal(data{1,j+1},'m')
            data{1,j}=['Voltage_Magnitude(',data{2,j},')'];
            for i=j+1:taille-1
                data{1,i}=data{1,i+1};
            end
            data(:,end)=[];
            taille = taille - 1;
        else
            data{1,j}=['Voltage(',data{2,j},')'];
        end
    end
    if isequal(data{1,j},'volt') && isequal(data{1,j+1},'phase')
        data{1,j}=['Voltage_Phase(',data{2,j},')'];
        for i=j+1:taille-1
            data{1,i}=data{1,i+1};
        end
        data(:,end)=[];
        taille = taille - 1;
    end
    if isequal(data{1,j},'volt') && isequal(data{1,j+1},'db')
        data{1,j}=['Voltage_Magnitude(',data{2,j},')'];
        for i=j+1:taille-1
            data{1,i}=data{1,i+1};
        end
        data(:,end)=[];
        taille = taille - 1;
    end
    j= j+1;
end
data(2,:)=[];
assignin('base','data',data);
listeTransitor=data;
end
