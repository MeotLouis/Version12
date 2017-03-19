function ImportMOSFET( tlines,handles )
%IMPORTMOSFET Summary of this function goes here
%   Detailed explanation goes here
name=tlines{1,1};
D=tlines{1,2};
G=tlines{1,3};
S=tlines{1,4};
[~,largeur]=size(tlines);
if largeur > 4
    B='false';
    for i=5:largeur
        if ~isempty(strfind(tlines{1,i},'l='))||~isempty(strfind(tlines{1,i},'L='))
            l=tlines{1,i};
        elseif ~isempty(strfind(tlines{1,i},'w='))||~isempty(strfind(tlines{1,i},'W='))
            w=tlines{1,i};
        elseif ~isempty(strfind(tlines{1,i},'M='))||~isempty(strfind(tlines{1,i},'m='))
            w=tlines{1,i};
        elseif isstrprop(tlines{1,i},'upper')
            model=tlines{1,i};
        elseif ~isempty(strfind(tlines{1,i},'_'))
            model=tlines{1,i};
        else
            B=tlines{1,i};
        end
    end
end
foo={'a'};
MosfetCreator( handles,name,D,G,S,l,w,B,model,foo );

end

