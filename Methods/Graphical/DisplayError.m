function [ bool ] = DisplayError( handles )
%DISPLAYERROR Summary of this function goes here
%   Detailed explanation goes here
[~,taille]=size(handles.editText);
a=0;
for i=1:taille
    if isequal(get(handles.editText(i),'Style'),'edit')
        if isempty(get(handles.editText(i),'String'))&&(a==0)
            a=a+1;
            errordlg(['Missing',' ',get(handles.staticText(i),'String')]); 
        end
    end
end
bool=a;

