function CreateTransistor( x,y,l,w,element )
%CREATERESISTOR Summary of this function goes here
%   Detailed explanation goes here
if isequal(element{1,1},'Bipolar')
    line([x x+2*l/7],[y+w/2 y+w/2]);
    line([x+2*l/7 x+2*l/7],[y+w/4 y+3*w/4]);
    line([x+4*l/7 x+2*l/7],[y+w/4 y+3*w/8]);
    line([x+2*l/7 x+4*l/7],[y+5*w/8 y+3*w/4]);
    line([x+4*l/7 x+4*l/7],[y+w/4 y]);
    line([x+4*l/7 x+4*l/7],[y+3*w/4 y+w]);
    C=element{3,1};
    B=element{4,1};
    E=element{5,1};
    text(x+l/2,y+w+2,C);
    text(x-5,y+w/2,B);
    text(x+l/2,y-2,E);
    name=element{2,1};
    text(x+5*l/7,y+5*w/8,name);
    model=['[',element{6,1},']'];
    text(x+5*l/7,y+3*w/8,model);
elseif isequal(element{1,1},'JFET')
    line([x x+3*l/8],[y+w/2 y+w/2]);
    line([x+3*l/8 x+3*l/8],[y+w/4 y+3*w/4],'LineWidth',3);
    line([x+3*l/8 x+5*l/8],[y+3*w/8 y+3*w/8]);
    line([x+3*l/8 x+5*l/8],[y+5*w/8 y+5*w/8]);
    line([x+5*l/8 x+5*l/8],[y y+3*w/8]);
    line([x+5*l/8 x+5*l/8],[y+5*w/8 y+w]);
    rectangle('Position',[x+l/8,y+w/8,6*l/8,6*w/8],'Curvature',[1 1]);
    C=element{3,1};
    B=element{4,1};
    E=element{5,1};
    text(x+5*l/8,y+w+2,C);
    text(x-5,y+w/2,B);
    text(x+5*l/8,y-2,E);
    name=element{2,1};
    text(x+5*l/7,y+5*w/8,name);
    model=['[',element{6,1},']'];
    text(x+5*l/7,y+3*w/8,model);
else
    line([x-l/4 x+3*l/8],[y+3*w/16 y+3*w/16]);
    line([x+3*l/8 x+3*l/8],[y+3*w/16 y+w-3*w/16]);
    line([x+l/2 x+l/2],[y+w-3*w/16 y+w-5*w/16],'LineWidth',3);
    line([x+l/2 x+l/2],[y+w/2+w/16 y+w/2-w/16],'LineWidth',3);
    line([x+l/2 x+l/2],[y+3*w/16 y+w/2-3*w/16],'LineWidth',3);
    line([x+l/2 x+l/2+l/8],[y+w-2*w/8 y+3*w/4]);
    line([x+l/2 x+l/2+l/8],[y+w/2 y+w/2]);
    line([x+l/2 x+l/2+l/8],[y+w/4 y+w/4]);
    if isequal(element{6,1},'false')
        line([x+5*l/8 x+5*l/8],[y-w/4 y+w/2]);
    else
        line([x+5*l/8 x+5*l/8],[y-w/4 y+w/4]);
        text(x+5*l/8,y+w/2,element{6,1});
    end
    line([x+5*l/8 x+5*l/8],[y+3*w/4 y+w+1*w/4]);
    rectangle('Position',[x,y,l,w],'Curvature',[1 1]);
    D=element{3,1};
    G=element{4,1};
    S=element{5,1};
    text(x-l/4,y+3*w/16,G);
    text(x+5*l/8, y+w+1*w/4,D);
    text(x+5*l/8,y-w/4,S);
    name=element{2,1};
    text(x+l,y+5*w/8,name);
    model=['[',element{7,1},']'];
    text(x+l,y+3*w/8,model);
end

