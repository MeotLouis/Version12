function ImportBipolar( tline,handles )
%IMPORTBIPOLAR Summary of this function goes here
%   Detailed explanation goes here
name=tline{1,1};
E=tline{1,2};
B=tline{1,3};
C=tline{1,4};
model=tline{1,5};
foo={'a'};
BipolarCreator( handles,C,B,E,name,model,foo );

