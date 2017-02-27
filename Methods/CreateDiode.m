function CreateDiode( x,y,w,l )
%CREATEDIODE Summary of this function goes here
%   Detailed explanation goes here
line([x x+w],[y+l y+l]);
line([x+w/2 x+w],[y+l y]);
line([x x+w],[y y]);
line([x x+w/2],[y y+l]);
end

