function [ ligne_propre ] = DatafileReader( tlines2 )
    split=strsplit(tlines2{1,1});
    [~,a]=size(split);
    ligne_propre='+';
    if isequal(split{1,a},'')||isequal(split{1,a},' ')
        a=a-1;
    end
    for i=1:a
        ligne_propre=[ligne_propre,split{1,i},'=',num2str(i),' '];
    end
end

