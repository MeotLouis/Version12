function listeSignaux=signal(nomfichier)

listeSignaux=cell(0,1);
ac=loadsig(nomfichier);
name=lssig(ac);
[longueur,~]=size(name);
i=1;

while i<=longueur
    nomencours=name(i,:);
    listeSignaux{end+1,1}=nomencours(4:end);
    touteexperiencedunsignal=evalsig(ac,nomencours(4:end));
    [ligne,colonne]=size(touteexperiencedunsignal);
    j=1;
    while j<=colonne
        if ~isreal(touteexperiencedunsignal(1,j))
            listeSignaux{end,j+1}=cell(0,0);
            k=1;
            while k<=ligne
                listeSignaux{end,j+1}{end+1,1}=abs(touteexperiencedunsignal(k,j));
                listeSignaux{end,j+1}{end,2}=phase(touteexperiencedunsignal(k,j));
            k=k+1;
            end    
        else
            listeSignaux{end,j+1}=touteexperiencedunsignal(:,j);
        end
        j=j+1;
    end
    i=i+1;
end