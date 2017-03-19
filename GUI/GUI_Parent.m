function varargout = GUI_Parent(varargin)
% GUI_PARENT MATLAB code for GUI_Parent.fig
%      GUI_PARENT, by itself, creates a new GUI_PARENT or raises the existing
%      singleton*.
%
%      H = GUI_PARENT returns the handle to a new GUI_PARENT or the handle to
%      the existing singleton*.
%
%      GUI_PARENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PARENT.M with the given input arguments.
%
%      GUI_PARENT('Property','Value',...) creates a new GUI_PARENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Parent_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Parent_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Parent

% Last Modified by GUIDE v2.5 20-Feb-2017 16:29:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Parent_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Parent_OutputFcn, ...
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


% --- Executes just before GUI_Parent is made visible.
function GUI_Parent_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Parent (see VARARGIN)

% Choose default command line output for GUI_Parent
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
Init_GUI_Parent(handles);

% UIWAIT makes GUI_Parent wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Parent_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_create.
function push_create_Callback(hObject, eventdata, handles)
% hObject    handle to push_create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Parent);
GUI_create_sp_file();


% --- Executes on button press in push_source.
function push_source_Callback(hObject, eventdata, handles)
% hObject    handle to push_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Parent);
GUI_Add_Analysis();

% --- Executes on button press in push_simulate.
function push_simulate_Callback(hObject, eventdata, handles)
% hObject    handle to push_simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Parent);
GUI_Simulation();

% --- Executes on button press in push_settings.
function push_settings_Callback(hObject, eventdata, handles)
% hObject    handle to push_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Setting();



function edit_path_project_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_project (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_project as text
%        str2double(get(hObject,'String')) returns contents of edit_path_project as a double


% --- Executes during object creation, after setting all properties.
function edit_path_project_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_project (see GCBO)
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
folder_name = uigetdir();
set(handles.edit_path_project,'String',folder_name);
setappdata(0,'project_directory',folder_name);
set(handles.push_create,'enable','on');