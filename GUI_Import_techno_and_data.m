function varargout = GUI_Import_techno_and_data(varargin)
% GUI_IMPORT_TECHNO_AND_DATA MATLAB code for GUI_Import_techno_and_data.fig
%      GUI_IMPORT_TECHNO_AND_DATA, by itself, creates a new GUI_IMPORT_TECHNO_AND_DATA or raises the existing
%      singleton*.
%
%      H = GUI_IMPORT_TECHNO_AND_DATA returns the handle to a new GUI_IMPORT_TECHNO_AND_DATA or the handle to
%      the existing singleton*.
%
%      GUI_IMPORT_TECHNO_AND_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_IMPORT_TECHNO_AND_DATA.M with the given input arguments.
%
%      GUI_IMPORT_TECHNO_AND_DATA('Property','Value',...) creates a new GUI_IMPORT_TECHNO_AND_DATA or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Import_techno_and_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Import_techno_and_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Import_techno_and_data

% Last Modified by GUIDE v2.5 26-Jan-2017 18:55:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Import_techno_and_data_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Import_techno_and_data_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_Import_techno_and_data is made visible.
function GUI_Import_techno_and_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Import_techno_and_data (see VARARGIN)

% Choose default command line output for GUI_Import_techno_and_data
handles.output = hObject;
handles.in=varargin{1};    
% Update handles structure
guidata(hObject, handles);
setappdata(0,'HandleMainGUI',hObject);
initialize_gui(hObject, handles, false);

% UIWAIT makes GUI_Import_techno_and_data wait for user response (see UIRESUME)
% uiwait(0);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Import_techno_and_data_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in push_generate.
function push_generate_Callback(hObject, eventdata, handles)
% hObject    handle to push_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Generate(handles);

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.

listParams=cell(0,1);
setappdata(0,'listParams',listParams);
setappdata(0,'check',0);
setappdata(0,'manual',0);
setappdata(0,'import',0);
setappdata(0,'options',0);
setappdata(0,'technobox',0);
setappdata(0,'path_fixe',strcat('C:\Users\',getenv('USERNAME'),'\Documents\'));
% Update handles structure
guidata(handles.GUI_1, handles);



function edit_path_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_netlist as text
%        str2double(get(hObject,'String')) returns contents of edit_path_netlist as a double


% --- Executes during object creation, after setting all properties.
function edit_path_netlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_path_param_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_param as text
%        str2double(get(hObject,'String')) returns contents of edit_path_param as a double


% --- Executes during object creation, after setting all properties.
function edit_path_param_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_browse_param.
function push_browse_param_Callback(hObject, eventdata, handles)
% hObject    handle to push_browse_param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[name_file,path] = uigetfile(strcat(getappdata(0,'path_fixe'),'\/*.dat'));
if name_file ~= 0
    set(handles.edit_path_param,'string',strcat(path,name_file));
    setappdata(0,'full_file_param',strcat(path,name_file));
    setappdata(0,'file_param',name_file);
    set(handles.push_generate,'enable','on');
end


% --- Executes on button press in check_import.
function check_import_Callback(hObject, eventdata, handles)
% hObject    handle to check_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_import
if (get(hObject,'Value') == get(hObject,'Max'))
    setappdata(0,'import',1);
else
    setappdata(0,'import',0);
end


function Generate(handles)
%%On va créer le répertoire de sortie avec le chemin passé en paramètre, si
%%le repertoire existe déjà , on le supprime
project_directory=getappdata(0,'file_output');%,'SP_file_output'];
%Création du fichier .sp
tlines = cell(0,1);
%%Import des paramètres
% if exist(project_directory, 'dir') == 7
%     rmdir(project_directory,'s');
% end
% mkdir(project_directory);
%%Copie des fichiers utiles dans le repertoire
%On copie le fichier .lib si l'utilisateur utilise une technologie
tlines{end+1,1} = '** PRESET **';
% if getappdata(0,'technobox')==1
%     if ~isempty(getappdata(0,'file_technology'))
%         %Copie du fichier .lib
%         if ~isequal(getappdata(0,'full_file_technology'),[project_directory,getappdata(0,'file_technology')])
%             copyfile(getappdata(0,'full_file_technology'),[project_directory,getappdata(0,'file_technology')],'f');
%             %Bloc permettant de copier le fichier .mdl
%             nom_techno=strsplit(getappdata(0,'file_technology'),'.');
%             nom_mld=[nom_techno{1,1},'.mdl'];
%             nom_techno2=strsplit(getappdata(0,'full_file_technology'),'.');
%             path_mld=[nom_techno2{1,1},'.mdl'];
%             if exist(path_mld, 'file') ~= 0
%                 display('true');
%                 t=[project_directory,'\',nom_mld];
%                 copyfile(path_mld,t,'f'); 
%             end
%         end
%         %Import du nom de la techno et ecriture dans le fichier
%         tlines{end+1,1} = '';
%         tlines{end+1,1} = '*Import libraries';
%         tlines{end+1,1} = '';
%         tlines{end+1,1} = '.prot';
%         tlines{end+1,1} = ['.LIB ',getappdata(0,'file_technology'),' ',getappdata(0,'quelle_techno')];
%         tlines{end+1,1} = '.unprot';
%         tlines{end+1,1} = '';
%     else
%         errordlg('Missing path to file');
%     end
% end

%Cas où l'import de paramètres est coché
if getappdata(0,'import')==1
    tlines{end+1,1} = '*Import parameters';
    tlines{end+1,1} = '';
    tlines{end+1,1} = ['.data',' ','dataSetHC1',' ','merge file=',getappdata(0,'file_param')];
    if ~isequal(getappdata(0,'full_file_param'),[getappdata(0,'project_directory'),'\',getappdata(0,'file_param')])
        copyfile(getappdata(0,'full_file_param'),[getappdata(0,'project_directory'),'\',getappdata(0,'file_param')],'f');
    end
    fid2=fopen(getappdata(0,'full_file_param'));
    tline = fgetl(fid2);
    tlines2=cell(0,1);
    while ischar(tline)
        tlines2{end+1,1} = tline;
        tline = fgetl(fid2);
    end
    fclose(fid2);
%     save('c:\Users\Desktop\data.mat','tlines2');
    tlines{end+1,1} = DatafileReader(tlines2);
    tlines{end+1,1} = '.enddata';
end    

%Cas où l'import d'options est coché
if getappdata(0,'options')==1
    lines=get(handles.listbox_all_lines,'String');
    if ~isempty(lines)
        tlines{end+1,1} = '*Import options';
        tlines{end+1,1} = '';
        for i=1:length(lines)
            tlines{end+1,1} = lines{i};
        end
    end
end
% 
% %On écrit dans le fichier
% nom_fichier_out=strcat(project_directory,'\',getappdata(0,'name_file_output'));
% setappdata(0,'nom_out',nom_fichier_out);
% %Si le fichier existe on le suprime
% if exist(nom_fichier_out, 'file') == 2
%     delete (nom_fichier_out);
% end
% fid=fopen(nom_fichier_out,'at');
% [lignes,~]=size(tlines);
% for i=1:lignes
%    fprintf(fid, strcat(tlines{i,1},'\n')); 
% end
% fclose(fid);
set(handles.in,'String',tlines);
set(handles.push_simulation1,'enable','on'); 


% --- Executes on button press in push_simulation1.
function push_simulation1_Callback(hObject, eventdata, handles)
% hObject    handle to push_simulation1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% a=getappdata(0,'nom_out');
% GUI_sim(a);
% display(a);
% close(GUI_Import_techno_and_data);
close(GUI_Import_techno_and_data(handles.in));


%  %Cas où le manual est coché
%     if getappdata(0,'manual')==1
%         %Cas où le manual est coché et l'utilisateur veut créer un fichier .dat
%         %Il faut alors géréer le cas s'il veut déjà importer un fichier .dat et
%         %si oui, il ne pourra pas générer de fichier car ça ferait deux
%         %datasources
%         if (getappdata(0,'check')==1)&&(getappdata(0,'import')==0)
%             name_file_dat=[project_directory,'\datasource.dat'];
%             if exist(name_file_dat, 'file') == 2
%                 delete (name_file_dat);
%             end
%             fid=fopen(name_file_dat,'w+');
%             hMainGui=getappdata(0,'HandleMainGUI');
%             listParams=getappdata(hMainGui,'listParams');
%             [lignes,~]=size(listParams);
%             name_param='';
%             value='';
%             ligne_complementaire='+';
%             for i=1:lignes
%                ligne_complementaire = [ligne_complementaire,listParams{i,1},'=',listParams{i,2},' '];
%                name_param = [name_param,' ',listParams{i,1}]; 
%                value = [value,' ',listParams{i,2}];
%             end
%             line = [name_param,value];
%             fprintf(fid,line);
%             fclose(fid);
%             tlines{end+1,1} = ['.data random merge file =',' ','datasource.dat'];
%             tlines{end+1,1} = ligne_complementaire;
%             tlines{end+1,1} = '.enddata';
%         else  
%             hMainGui=getappdata(0,'HandleMainGUI');
%             listParams=getappdata(hMainGui,'listParams');
%             [lignes,~]=size(listParams);
%             pattern={'*','+','/','-'};
%             a=0;
%             for i=1:lignes
%                 for j=1:4
%                     if ~isempty(strfind(listParams{i,2},pattern{1,j}))
%                         a=a+1;
%                     end
%                 end
%                 if a~=0
%                     listParams{i,2}=['''',listParams{i,2},''''];
%                 end
%                 a=0;
%             end
%             tlines{end+1,1} = ['.param ' ,listParams{1,1},'=',listParams{1,2}];
%             if lignes>1
%                 for i=2:lignes
%                    tlines{end,1} = [tlines{end,1},' ',listParams{i,1},'=',listParams{i,2}];
%                 end
%             end
%         end
%     end


% --- Executes on button press in data_Creator.
function data_Creator_Callback(hObject, eventdata, handles)
% hObject    handle to data_Creator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_data_creator();


% --- Executes on button press in check_option.
function check_option_Callback(hObject, eventdata, handles)
% hObject    handle to check_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_option
if (get(hObject,'Value') == get(hObject,'Max'))
    setappdata(0,'options',1);
else
    setappdata(0,'options',0);
end

% --- Executes on selection change in popup_options.
function popup_options_Callback(hObject, eventdata, handles)
% hObject    handle to popup_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_options
contents = cellstr(get(hObject,'String'));
select=contents{get(hObject,'Value')};
if isequal(select,'TEMP')||isequal(select,'GLOBAL')
    set(handles.edit_option,'String',['.',select]);
elseif ~isequal(select,'-')
    set(handles.edit_option,'String',['.OPTION ',select]);
end

% --- Executes during object creation, after setting all properties.
function popup_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_option_Callback(hObject, eventdata, handles)
% hObject    handle to edit_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_option as text
%        str2double(get(hObject,'String')) returns contents of edit_option as a double


% --- Executes during object creation, after setting all properties.
function edit_option_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add_options.
function push_add_options_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
option=get(handles.edit_option,'String');
if ~isempty(option)
    %Generate basics option to simplifie the use
    if isequal('.OPTION Default options',option)
        set(handles.edit_option,'String','');
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}='.option unwrap=1';
        liste{end+1,1}='.TEMP 27';
        liste{end+1,1}='.option post';
        liste{end+1,1}='.option ingold=1';
        liste{end+1,1}='.option converge=1';
        liste{end+1,1}='.global 0';
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_options,'Value',1);
    else
        set(handles.edit_option,'String','');
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=option;
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_options,'Value',1);
    end
end
set(handles.push_generate,'enable','on');

% --- Executes on selection change in listbox_all_lines.
function listbox_all_lines_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_all_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_all_lines contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_all_lines


% --- Executes during object creation, after setting all properties.
function listbox_all_lines_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_all_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
