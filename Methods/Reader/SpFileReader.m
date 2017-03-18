function SpFileReader( file,handles )
%SPFILEREADER Summary of this function goes here
%   Detailed explanation goes here
%Gérer l'import de l'handles

%%Reader of file
%Data stored inside tlines
fid=fopen(file);
tline = fgetl(fid);
tlines=cell(0,1);
while ischar(tline)
    tlines{end+1,1}=tline;
    tline = fgetl(fid);
end
fclose(fid);

%%Tlines reader
[ligne,~]=size(tlines);
for i=1:ligne
    tlines{i,1}=strsplit(tlines{i,1});
end
%We import the element inside the data structure and we generate the
%graphical representation
SpLoader(tlines,handles);

%%We set the tlines inside the listbox all
set(handles.listbox_all_lines,'String',tlines);


