function varargout = Setting(varargin)
% SETTING MATLAB code for Setting.fig
%      SETTING, by itself, creates a new SETTING or raises the existing
%      singleton*.
%
%      H = SETTING returns the handle to a new SETTING or the handle to
%      the existing singleton*.
%
%      SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTING.M with the given input arguments.
%
%      SETTING('Property','Value',...) creates a new SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Setting

% Last Modified by GUIDE v2.5 22-Nov-2016 17:17:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Setting_OpeningFcn, ...
                   'gui_OutputFcn',  @Setting_OutputFcn, ...
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


% --- Executes just before Setting is made visible.
function Setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Setting (see VARARGIN)

% Choose default command line output for Setting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in push_adobe.
function push_adobe_Callback(hObject, eventdata, handles)
% hObject    handle to push_adobe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat('C:\/*.exe'));
if name_file~=0
    set(handles.path_adobe,'string',strcat(path,name_file));
    setappdata(0,'path_Adobe',strcat(path,name_file));
end

% --- Executes on button press in push_ltspice.
function push_ltspice_Callback(hObject, eventdata, handles)
% hObject    handle to push_ltspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat('C:\/*.exe'));
if name_file~=0
    set(handles.path_ltspice,'string',strcat(path,name_file));
    setappdata(0,'path_LTSpice',strcat(path,name_file));
end

% --- Executes on button press in push_exit.
function push_exit_Callback(hObject, eventdata, handles)
% hObject    handle to push_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current=pwd;
path2=[current,'\Data\data.txt'];
fid=fopen(path2,'wt');
fprintf(fid,'%s',getappdata(0,'path_Adobe'));
fprintf(fid,'\n');
fprintf(fid,'%s',getappdata(0,'path_LTSpice'));
fprintf(fid,'\n');
fprintf(fid,'%s',getappdata(0,'path_Hspice'));
fclose(fid);
close(Setting);


function path_adobe_Callback(hObject, eventdata, handles)
% hObject    handle to path_adobe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path_adobe as text
%        str2double(get(hObject,'String')) returns contents of path_adobe as a double


% --- Executes during object creation, after setting all properties.
function path_adobe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path_adobe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
if ~isempty(getappdata(0,'path_Adobe'))
    set(hObject,'string',getappdata(0,'path_Adobe'));
end



function path_ltspice_Callback(hObject, eventdata, handles)
% hObject    handle to path_ltspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
% Hints: get(hObject,'String') returns contents of path_ltspice as text
%        str2double(get(hObject,'String')) returns contents of path_ltspice as a double


% --- Executes during object creation, after setting all properties.
function path_ltspice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path_ltspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
if ~isempty(getappdata(0,'path_LTSpice'))
    set(hObject,'string',getappdata(0,'path_LTSpice'));
end


% --- Executes on button press in push_hspice.
function push_hspice_Callback(hObject, eventdata, handles)
% hObject    handle to push_hspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat('C:\/*.exe'));
if name_file~=0
    set(handles.edit_hspice,'string',strcat(path,name_file));
    setappdata(0,'path_Hspice',strcat(path,name_file));
end


function edit_hspice_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hspice as text
%        str2double(get(hObject,'String')) returns contents of edit_hspice as a double


% --- Executes during object creation, after setting all properties.
function edit_hspice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
if ~isempty(getappdata(0,'path_Hspice'))
    set(hObject,'string',getappdata(0,'path_Hspice'));
end
