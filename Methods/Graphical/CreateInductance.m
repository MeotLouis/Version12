function CreateInductance(x,y,w,l)
%CREATEINDUCTANCE Summary of this function goes here
%   Detailed explanation goes here

r=2;
a=1;
n=4.75;
k=2;
phi=0.1*k;
t=0.25:0.01:n;

xh = a*t;
yh = r*cos(2*pi*t);
zh=r*sin(2*pi*t);

xe=xh*cos(phi)-zh*sin(phi);
ye=yh;

hauteur_xe=xe(end)-xe(1);
ratio=l/hauteur_xe;
xe=xe*ratio;
xe=xe+y;
test=y-xe(1);
xe=xe+test;

largeur_ye=r;
ratio=(w/4)/largeur_ye;
ye=ye*ratio;
ye=ye+x+w/2;

hold on;
plot(ye,xe);
hold on;
end

