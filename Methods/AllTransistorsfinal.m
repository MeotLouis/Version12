function listeTransitor = AllTransistorsfinal(namelisfile)
fid=fopen(namelisfile);
tline = fgetl(fid);
tlines = cell(0,1);%Stocke chaque ligne du texte dans une ligne de la matrice tline
enregistre=0;
tlines2 = cell(0,1);
numeroDeLindex=0; %regarde à quelle simulation on est
while ischar(tline)       
    tlines2{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
[nbligness , inutile]=size(tlines2);
assignin('base','tlines2',tlines2);
%%Boucle permettant de récupérer que les lignes concernants les transistors
for i=1:nbligness
    tline=tlines2{i};
    str1='element';
    str2='*';
    str3='index =';

    findSubckt=findstr(tline,str1);
    findEtoile=findstr(tline,str2);
    findIndex=findstr(tline,str3);

    if findIndex~=0
        tlines{end+1,1} = numeroDeLindex;
        numeroDeLindex = numeroDeLindex+1;
        A=numeroDeLindex;
    end

    if findSubckt~=0

        enregistre=1;
    end
    if findEtoile~=0
        enregistre=0;
    end
    if (enregistre==1)&&(~isempty(tline))
        if  ischar(tline)
            tline = strsplit(tline); %sépare les mots de la chaine de caractère mais comme 
            tline(:,1) = [];
            if  isequal(tline{end},'')
                tline(:,end) = [];
            end
            if isequal(tline{1},'gam')
              tline(:,1) = [];
              tline(:,1)={'gam eff'};
            end
        end
        tlines{end+1,1} = tline;
    end
end
assignin('base','tlines',tlines);
[nblignes , inutile]=size(tlines);

listeProvisoire={'indexExperience','element','model','region','id','ibs','ibd','vgs','vds','vbs','vth','vdsat','vod','beta','gam eff','gm','gds','gmb','cdtot','cgtot','cstot','cbtot','cgs','cgd'}';
%%Création de la structure de transistor
compteur1=1;
indexExperience = -1;
listTransistors = cell(0,1);
lignetotale = 1;
LimiteListeProvisoire=1;
while compteur1 <= nblignes
    string = tlines{compteur1,1};
    if  iscell(string)
        [ligneSurTlines,colonneSurTlines]=size(string);
        [ligneSurlisteProvisoire,colonneSurlisteProvisoire]=size(listeProvisoire);
        compteur2=0;
        A=0;
        while A~=1&&compteur2<=ligneSurlisteProvisoire
            compteur2=compteur2+1;
            A=isequal(string(1),listeProvisoire(compteur2));
        end
        if A==1
            i=1;
            j=LimiteListeProvisoire;
            while i <colonneSurTlines
                listeProvisoire{compteur2,j+1}=string{1,i+1};
                listeProvisoire{1,j+1}=indexExperience;
                i=i+1;
                j=j+1;
            end
            if compteur2==ligneSurlisteProvisoire
                 j=LimiteListeProvisoire;
                 LimiteListeProvisoire=LimiteListeProvisoire+colonneSurTlines-1;
            end
        else
            A=0;
        end
    else
        indexExperience=indexExperience+1;
        lignetotale=1;
    end
    compteur1 = compteur1 + 1;
    
end
assignin('base','listeProvisoire',listeProvisoire);
listeTransitor = cell(0,0);
[ligne,colonne]=size(listeProvisoire);
i=2;
ligneListeTransistor=0;
indexExperiencePrecendent=0;
while i<=colonne
    if isempty(listeTransitor)&&listeProvisoire{1,i}~=0
        for f=1:colonne
            listeProvisoire{1,f}=0;
        end
    end
    indexExperience=listeProvisoire{1,i};
    element=listeProvisoire{2,i};
    model=listeProvisoire{3,i};
    region=listeProvisoire{4,i};
    id=listeProvisoire{5,i};
    ibs=listeProvisoire{6,i};
    ibd=listeProvisoire{7,i};
    vgs=listeProvisoire{8,i};
    vds=listeProvisoire{9,i};
    vbs=listeProvisoire{10,i};
    vth=listeProvisoire{11,i};
    vdsat=listeProvisoire{12,i};
    vod=listeProvisoire{13,i};
    beta=listeProvisoire{14,i};
    gameff=listeProvisoire{15,i};
    gm=listeProvisoire{16,i};
    gds=listeProvisoire{17,i};
    gmb=listeProvisoire{18,i};
    cdtot=listeProvisoire{19,i};
    cgtot=listeProvisoire{20,i};
    cstot=listeProvisoire{21,i};
    cbtot=listeProvisoire{22,i};
    cgs=listeProvisoire{23,i};
    cgd=listeProvisoire{24,i};
    transistor=struct('indexExperience',indexExperience,'element',element,'model',model,'region',region,'id',id,'ibs',ibs,'ibd',ibd,'vgs',vgs,'vds',vds,'vbs',vbs,'vth',vth,'vdsat',vdsat,'vod',vod,'beta',beta,'gameff',gameff,'gm',gm,'gds',gds,'gmb',gmb,'cdtot',cdtot,'cgtot',cgtot,'cstot',cstot,'cbtot',cbtot,'cgs',cgs,'cgd',cgd);
    i= i+1;
    if indexExperience==indexExperiencePrecendent
        ligneListeTransistor=ligneListeTransistor+1;
    else
        ligneListeTransistor=1;
        indexExperiencePrecendent=indexExperience;
    end
    listeTransitor(ligneListeTransistor,indexExperience+1)={transistor};
end
assignin('base','listefianle',listeTransitor);

