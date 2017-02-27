function CalculCoordonates(handles)
%import des data
data=getappdata(0,'data');

largeur=100;
hauteur=100;

%On efface le precedent
cla;
%Calcul du nombre d'éléments
data(1,:)=[];
[nb_elements,~]=size(data);
if mod(nb_elements,2)==0
    %Cas ou on a un nombre pair d'elements
    if nb_elements==2
        %Cas ou on a deux elements
        ratiolargeur=largeur/2;
        for i=1:nb_elements
            DisplayElement(data{i,1},{((i-1)*ratiolargeur),0},{ratiolargeur,hauteur},handles);
        end
    else
        %Cas ou en a plus que deux
        ratiolargeur=largeur/(nb_elements/2);
        ratiohauteur=hauteur/2;
        for i=1:(nb_elements/2)
            %partie sup
            DisplayElement(data{i,1},{((i-1)*ratiolargeur),ratiohauteur},{ratiolargeur,ratiohauteur},handles);
        end
        for j=(nb_elements/2):nb_elements
            %partie inf
            DisplayElement(data{j,1},{((j-(nb_elements/2)-1)*ratiolargeur),0},{ratiolargeur,ratiohauteur},handles);
        end
    end
else
    if nb_elements==1
    	DisplayElement(data{1,1},{0,0},{100,100},handles);
    else
        %Cas ou on en a 3,5,8
        nb_elements_superieur=(nb_elements-1)/2;
        nb_elements_inferieur=nb_elements_superieur+1;
        ratio_sup=largeur/nb_elements_superieur;
        ratio_inf=largeur/nb_elements_inferieur;
        nb_sup=1;
        nb_inf=1;
        for i=1:nb_elements
            if mod(i,2)==0
                DisplayElement(data{i,1},{ratio_sup*(nb_sup-1),hauteur/2},{ratio_sup,hauteur/2},handles);
                nb_sup=nb_sup+1;
            else
                DisplayElement(data{i,1},{ratio_inf*(nb_inf-1),0},{ratio_inf,hauteur/2},handles);
                nb_inf=nb_inf+1;
            end
        end
    end
end
end