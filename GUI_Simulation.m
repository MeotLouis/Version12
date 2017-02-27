function varargout = GUI_Simulation(varargin)
% GUI_SIMULATION MATLAB code for GUI_Simulation.fig
%      GUI_SIMULATION, by itself, creates a new GUI_SIMULATION or raises the existing
%      singleton*.
%
%      H = GUI_SIMULATION returns the handle to a new GUI_SIMULATION or the handle to
%      the existing singleton*.
%
%      GUI_SIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SIMULATION.M with the given input arguments.
%
%      GUI_SIMULATION('Property','Value',...) creates a new GUI_SIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Simulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Simulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Simulation

% Last Modified by GUIDE v2.5 10-Jan-2017 23:37:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Simulation_OutputFcn, ...
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


% --- Executes just before GUI_Simulation is made visible.
function GUI_Simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Simulation (see VARARGIN)

% Choose default command line output for GUI_Simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Simulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_path_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_input as text
%        str2double(get(hObject,'String')) returns contents of edit_path_input as a double


% --- Executes during object creation, after setting all properties.
function edit_path_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_browse.
function push_browse_Callback(hObject, eventdata, handles)
% hObject    handle to push_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[simu,path] = uigetfile('C:\/*.sp'); %% for HSPICE files only currently.
if(simu ~= 0)
   set(handles.edit_path_input,'String',fullfile(path,simu));
   list_signal=All_Nodes(fullfile(path,simu));
   list_signal=AlphabeticalSorter(list_signal);
   set(handles.listbox_all,'String',list_signal);
end

% --- Executes on button press in push_simulate.
function push_simulate_Callback(hObject, eventdata, handles)
% hObject    handle to push_simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fileName = get(handles.edit_path_input,'string');
fileInputSimulation=fileName;
setappdata(0,'path_input',fileName);
AddSignal(fileName,get(handles.listbox_selected,'String'));
% %Construction du chemin du fichier de sortie
% fileOutputSimulation=strcat(fileInputSimulation(1:end-3),'.lis');
% 
% %Suppression du fichier de sortie s'il existe
% if exist(fileOutputSimulation,'file')==2
%   delete(fileOutputSimulation);
% end
% 
% %Lancement de Hspice
% command=[getappdata(0,'path_Hspice'),' ','-C',' ',fileInputSimulation,' -o',' ',fileOutputSimulation];
% system(command);
% 
% %Put the extracted signal in the listbox
% listeSignal=SignalExtractor(fileOutputSimulation);
% setappdata(0,'listeSignaux',listeSignal);
% listeNoms=listeSignal(1,:)';
% set(handles.listbox_signal_out,'String',listeNoms);
% set(handles.listbox_transistor,'String',Displaytransistor(fileOutputSimulation));
% listeSignaux=getappdata(0,'listeSignaux');
% set(handles.listbox_signal_out,'Value',2);
% % %On plot le signal selectionn?(XAXIS)
% axes(handles.axes1);
% temps=listeSignaux(2:end,1);
% temps=cellfun(@str2num,temps); 
% assignin('base','temps',temps);
% %temps=cell2mat(temps);
% 
% %On plot le signal selectionn?(YAXIS)
% data2=listeSignaux(2:end,2);
% data2=cellfun(@str2num,data2); 
% semilogx(temps,data2);
% axes(handles.axes1);
% xlabel(listeSignaux{1,1}, 'FontSize', 10);
% ylabel(listeSignaux{1,2}, 'FontSize', 10);
% set(handles.uitoolbar1,'visible','on');
% guidata(hObject, handles);


% --- Executes on selection change in listbox_all.
function listbox_all_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_all contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_all


% --- Executes during object creation, after setting all properties.
function listbox_all_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_selected.
function listbox_selected_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_selected contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_selected


% --- Executes during object creation, after setting all properties.
function listbox_selected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add.
function push_add_Callback(hObject, eventdata, handles)
% hObject    handle to push_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = cellstr(get(handles.listbox_all,'String'));
selection = selection{get(handles.listbox_all,'Value')};
selection2 = cellstr(get(handles.listbox_selected,'String'));
if get(handles.checkbox_volt,'Value')==0 && get(handles.checkbox_current,'Value')==0
    errordlg('Please choose voltage or current to simulate');
elseif get(handles.checkbox_volt,'Value')==1 && get(handles.checkbox_current,'Value')==1
    if isequal(selection2{1,1},'')
        selection2{1,1}=['V(',selection,')'];
        selection2{end+1,1}=['I(',selection,')'];
    else
        selection2{end+1,1}=['V(',selection,')'];
        selection2{end+1,1}=['I(',selection,')'];
        set(handles.listbox_selected,'Value',length(selection2));
    end
elseif get(handles.checkbox_volt,'Value')==1 && get(handles.checkbox_current,'Value')==0
    if isequal(selection2{1,1},'')
        selection2{1,1}=['V(',selection,')'];
    else
        selection2{end+1,1}=['V(',selection,')'];
        set(handles.listbox_selected,'Value',length(selection2));
    end
else
    if isequal(selection2{1,1},'')
        selection2{1,1}=['I(',selection,')'];
    else
        selection2{end+1,1}=['I(',selection,')'];
        set(handles.listbox_selected,'Value',length(selection2));
    end
end
set(handles.listbox_selected,'String',selection2);



% --- Executes on button press in push_remove.
function push_remove_Callback(hObject, eventdata, handles)
% hObject    handle to push_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = cellstr(get(handles.listbox_selected,'String'));
if ~isempty(selection)
    selection(get(handles.listbox_selected,'Value'))=[];
    set(handles.listbox_selected,'String',selection);
    set(handles.listbox_selected,'Value',1);
end

% --- Executes on button press in push_add_manual.
function push_add_manual_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
if ~isempty(get(handles.edit_manual,'String'))
    selection2 = cellstr(get(handles.listbox_selected,'String'));
    if isequal(selection2{1,1},'')
        selection2{1,1}=get(handles.edit_manual,'String');
        set(handles.edit_manual,'String','');
    else
        selection2{end+1,1}=get(handles.edit_manual,'String');
        set(handles.edit_manual,'String','');
        set(handles.listbox_selected,'Value',length(selection2));
    end
    set(handles.listbox_selected,'String',selection2);
end


function edit_manual_Callback(hObject, eventdata, handles)
% hObject    handle to edit_manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_manual as text
%        str2double(get(hObject,'String')) returns contents of edit_manual as a double


% --- Executes during object creation, after setting all properties.
function edit_manual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_volt.
function checkbox_volt_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_volt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_volt


% --- Executes on button press in checkbox_current.
function checkbox_current_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_current


% --- Executes on selection change in listbox_signal_out.
function listbox_signal_out_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_signal_out contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_signal_out
indice_signal=get(hObject,'Value');
listeSignaux=getappdata(0,'listeSignaux');
% %On plot le signal selectionn?(XAXIS)
axes(handles.axes1);
temps=listeSignaux(2:end,1);
temps=cellfun(@str2num,temps); 
assignin('base','temps',temps);
%temps=cell2mat(temps);

%On plot le signal selectionn?(YAXIS)
data2=listeSignaux(2:end,indice_signal);
data2=cellfun(@str2num,data2); 
semilogx(temps,data2);
axes(handles.axes1);
xlabel(listeSignaux{1,1}, 'FontSize', 10);
ylabel(listeSignaux{1,indice_signal}, 'FontSize', 10);
set(handles.uitoolbar1,'visible','on');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox_signal_out_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_remove2.
function push_remove2_Callback(hObject, eventdata, handles)
% hObject    handle to push_remove2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = cellstr(get(handles.listbox_signal_out,'String'));
if ~isempty(selection)
    list=getappdata(0,'listeSignaux');
    list(:,get(handles.listbox_signal_out,'Value'))=[];
    setappdata(0,'listeSignaux',list);
    selection(get(handles.listbox_signal_out,'Value'))=[];
    set(handles.listbox_signal_out,'String',selection);
    set(handles.listbox_signal_out,'Value',1);
end

% --- Executes on button press in push_save.
function push_save_Callback(hObject, eventdata, handles)
% hObject    handle to push_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%On teste si le dossier output existe déj?et on le créé
dirpath2=getappdata(0,'path_input');
display(dirpath2);
allPath = strsplit(dirpath2,filesep);
parPath = allPath(1:end-1);
[~,a]=size(parPath);
dirpath=parPath{1,1};
for i=2:a
   dirpath=[dirpath,'\',parPath{1,i}]; 
end
display(dirpath);
if ~exist(dirpath,'dir') 
    mkdir(dirpath); 
end

listeSignaux=getappdata(0,'listeSignaux');
[FileName1,PathName2]=uiputfile('C:\/List_Signals.mat');
save(fullfile(PathName2,FileName1),'listeSignaux');
fileName = getappdata(0,'path_input');
namelisfile=strcat(fileName(1:end-3),'.lis');
listeTransitor = AllTransistorsfinal(namelisfile);
[FileName1,PathName2]=uiputfile('C:\/List_Transistor.mat');
save(fullfile(PathName2,FileName1),'listeTransitor');

% --- Executes on button press in push_leave.
function push_leave_Callback(hObject, eventdata, handles)
% hObject    handle to push_leave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Simulation());
GUI_Parent();

% --- Executes on selection change in listbox_transistor.
function listbox_transistor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_transistor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_transistor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_transistor


% --- Executes during object creation, after setting all properties.
function listbox_transistor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_transistor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_revove_transistor.
function push_revove_transistor_Callback(hObject, eventdata, handles)
% hObject    handle to push_revove_transistor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = cellstr(get(handles.listbox_transistor,'String'));
if ~isempty(selection)
    selection(get(handles.listbox_transistor,'Value'))=[];
    set(handles.listbox_transistor,'String',selection);
    set(handles.listbox_transistor,'Value',1);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_analysis.
function pop_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pop_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_analysis


% --- Executes during object creation, after setting all properties.
function pop_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_signal_out.
function listbox_freq_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_signal_out contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_signal_out


% --- Executes during object creation, after setting all properties.
function listbox_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function push_ac_metrics_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
[DCgain, f3db, UGF, PM, PR] = AC_metrics(handles.metricdata.frequency,handles.metricdata.magnitude,handles.metricdata.phase)
set(handles.DCgain, 'String', DCgain);
set(handles.f3db, 'String', f3db);
set(handles.UGF, 'String', UGF);
set(handles.PM, 'String', PM);
set(handles.PR, 'String', PR);

function acmetrics_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

indice_frequency=get(hObject,'Value');
freq_aux=getappdata(0,'listeSignaux');

frequency=freq_aux(2:end,indice_frequency);
frequency=cellfun(@str2num,frequency)
handles.metricdata.frequency = frequency;
guidata(hObject,handles)

function acmetrics_magnitude_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

indice_magnitude=get(hObject,'Value');
mag_aux=getappdata(0,'listeSignaux');

magnitude=mag_aux(2:end,indice_magnitude);
magnitude=cellfun(@str2num,magnitude)
handles.metricdata.magnitude = magnitude;
guidata(hObject,handles)

function acmetrics_phase_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

indice_phase=get(hObject,'Value');
phase_aux=getappdata(0,'listeSignaux');

phase=phase_aux(2:end,indice_phase);
phase=cellfun(@str2num,phase)
handles.metricdata.phase = phase;
guidata(hObject,handles)
