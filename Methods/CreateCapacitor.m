function CreateCapacitor( x,y,w,l )
%CREATECAPACITOR Summary of this function goes here
%   Detailed explanation goes here
line([x+w/2 x+w/2],[y+4*l/7 y+l]);
line([x x+w],[y+4*l/7 y+4*l/7]);
line([x+w/2 x+w/2],[y y+3*l/7]);
%Arc de cercle
r=1;
x1=x;
x2=x+w;
y1=y+2*l/7;
y2=y1;
d = sqrt((x2-x1)^2+(y2-y1)^2); % Distance between points
a = atan2(-(x2-x1),y2-y1); % Perpendicular bisector angle
b = asin(d/2/r); % Half arc angle
c = linspace(a+b,a-b); % Arc angle range
e = sqrt(r^2-d^2/4); % Distance, center to midpoint
xx = (x1+x2)/2-e*cos(a)+r*cos(c); % Cartesian coords. of arc
yy = (y1+y2)/2-e*sin(a)+r*sin(c);
for i=1:length(yy)
    yy(i)=yy(i)-((yy(i)-y1)*2);
end
xVars = linspace(x1,x2);
yVars = zeros(1,length(xVars));
totalDist = l/7;
currentDist = 0;
j=0;
for i=1:length(xVars)
    if i <= length(xVars)/2
          yVars(i) = y1 + l/7 - (l/7)/(i*1.5);
    else
          k=length(xVars)/2 - j;
          if k>0
            yVars(i) = yVars(k);
          else
            yVars(i) = y1;
          end
          j=j+1;
    end
end
hold on;
plot(xVars,yVars);
% %axis equal
end

