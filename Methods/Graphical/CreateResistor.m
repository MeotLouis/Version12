function CreateResistor( x,y,w,l )
%CREATERESISTOR Summary of this function goes here
%   Detailed explanation goes here
line([x+w/2 x+w/3],[y y+l/7]);
line([x+w/3 x+2*w/3],[y+l/7 y+2*l/7]);
line([x+2*w/3 x+w/3],[y+2*l/7 y+3*l/7]);
line([x+w/3 x+2*w/3],[y+3*l/7 y+4*l/7]);
line([x+2*w/3 x+w/3],[y+4*l/7 y+5*l/7]);
line([x+w/3 x+2*w/3],[y+5*l/7 y+6*l/7]);
line([x+2*w/3 x+w/2],[y+6*l/7 y+l]);
end

