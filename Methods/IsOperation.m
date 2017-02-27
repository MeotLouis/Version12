function  valueout  = IsOperation( value )
%ISOPERATION Summary of this function goes here
%   Detailed explanation goes here
    pattern={'*','+','/','-'};
    a=0;
    for j=1:4
        if ~isempty(strfind(value,pattern{1,j}))
            a=a+1;
        end
    end
    if a~=0
        valueout=['''',value,''''];
    else
        valueout=value;
    end
end

