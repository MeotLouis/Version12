function string = Displaytransistor( file )
%DISPLAYTRANSISTOR Summary of this function goes here
%   Detailed explanation goes here
listeTransitor = AllTransistorsfinal(file);
assignin('base','liste',listeTransitor);
listeTrans=cell(0,1);
[hauteur,largeur]=size(listeTransitor);
for i=1:hauteur
    for j=1:largeur
        listeTrans{end+1,1}=listeTransitor{i,j}.element;
    end
end
string=listeTrans;
end

