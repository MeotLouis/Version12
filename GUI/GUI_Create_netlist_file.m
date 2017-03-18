function varargout = GUI_Create_netlist_file(varargin)
% GUI_CREATE_NETLIST_FILE MATLAB code for GUI_Create_netlist_file.fig
%      GUI_CREATE_NETLIST_FILE, by itself, creates a new GUI_CREATE_NETLIST_FILE or raises the existing
%      singleton*.
%
%      H = GUI_CREATE_NETLIST_FILE returns the handle to a new GUI_CREATE_NETLIST_FILE or the handle to
%      the existing singleton*.
%
%      GUI_CREATE_NETLIST_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CREATE_NETLIST_FILE.M with the given input arguments.
%
%      GUI_CREATE_NETLIST_FILE('Property','Value',...) creates a new GUI_CREATE_NETLIST_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Create_netlist_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Create_netlist_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Create_netlist_file

% Last Modified by GUIDE v2.5 18-Nov-2016 15:46:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Create_netlist_file_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Create_netlist_file_OutputFcn, ...
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


% --- Executes just before GUI_Create_netlist_file is made visible.
function GUI_Create_netlist_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Create_netlist_file (see VARARGIN)

% Choose default command line output for GUI_Create_netlist_file
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Create_netlist_file wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Create_netlist_file_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_ltspice.
function push_ltspice_Callback(hObject, eventdata, handles)
% hObject    handle to push_ltspice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(getappdata(0,'path_LTSpice'))
    command=(['start ',getappdata(0,'path_LTSpice')]);
    system(command);
else
    [name_file,path] = uigetfile(strcat('C:\/*.exe'),'Enter location of LTSpice');
    if name_file~=0
        set(handles.edit_path_asc,'string',strcat(path,name_file));
        setappdata(0,'path_LTSpice',strcat(path,name_file));
        command=(['start ',getappdata(0,'path_LTSpice')]);
        system(command);
    end
end

% --- Executes on button press in push_browse_asc.
function push_browse_asc_Callback(hObject, eventdata, handles)
% hObject    handle to push_browse_asc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat('C:\/*.asc'));
if name_file~=0
    set(handles.edit_path_asc,'string',strcat(path,name_file));
end

% --- Executes on button press in push_browse_net.
function push_browse_net_Callback(hObject, eventdata, handles)
% hObject    handle to push_browse_net (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat('C:\/*.net'));
if name_file~=0
    set(handles.edit_path_net,'string',strcat(path,name_file));
end

% --- Executes on button press in push_generate.
function push_generate_Callback(hObject, eventdata, handles)
% hObject    handle to push_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.edit_path_asc,'String'))
    errordlg('Missing .asc file');
elseif isempty(get(handles.edit_path_net,'String'))
    errordlg('Missing .net file');
else
    [name_file,path] = uiputfile(strcat('C:\Users\',getenv('USERNAME'),'\Documents\/*.txt'));
    if name_file~=0
        Netlist_creator(get(handles.edit_path_asc,'String'),get(handles.edit_path_net,'String'),strcat(path,name_file));
        setappdata(0,'out_file_netlist',strcat(path,name_file));
    end
end

% --- Executes on button press in push_leave.
function push_leave_Callback(hObject, eventdata, handles)
% hObject    handle to push_leave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Create_netlist_file);
if ~isempty(getappdata(0,'out_file_netlist'))
    h=getappdata(0,'list_handles');
    set(h.edit_path_file,'String',getappdata(0,'out_file_netlist'));
    [nodes,tlines]=NetlistReader(getappdata(0,'out_file_netlist'));
    set(h.popup_node_netlist,'String',nodes);
    set(h.edit_netlist_subckt,'String','.subckt ');
    setappdata(0,'tlines',tlines);
end

function edit_path_asc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_asc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_asc as text
%        str2double(get(hObject,'String')) returns contents of edit_path_asc as a double


% --- Executes during object creation, after setting all properties.
function edit_path_asc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_asc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_path_net_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_net (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_net as text
%        str2double(get(hObject,'String')) returns contents of edit_path_net as a double


% --- Executes during object creation, after setting all properties.
function edit_path_net_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_net (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_texte.
function push_texte_Callback(hObject, eventdata, handles)
% hObject    handle to push_texte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uiputfile(strcat('C:\Users\',getenv('USERNAME'),'\Documents\/*.txt'));
if name_file~=0
    setappdata(0,'out_file_netlist',strcat(path,name_file));
    system(['start %windir%\system32\notepad.exe "',strcat(path,name_file),'"']);
end