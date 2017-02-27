function varargout = GUI_Addparameters(varargin)
% GUI_ADDPARAMETERS MATLAB code for GUI_Addparameters.fig
%      GUI_ADDPARAMETERS, by itself, creates a new GUI_ADDPARAMETERS or raises the existing
%      singleton*.
%
%      H = GUI_ADDPARAMETERS returns the handle to a new GUI_ADDPARAMETERS or the handle to
%      the existing singleton*.
%
%      GUI_ADDPARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ADDPARAMETERS.M with the given input arguments.
%
%      GUI_ADDPARAMETERS('Property','Value',...) creates a new GUI_ADDPARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Addparameters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Addparameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Addparameters

% Last Modified by GUIDE v2.5 01-Nov-2016 18:40:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Addparameters_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Addparameters_OutputFcn, ...
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


% --- Executes just before GUI_Addparameters is made visible.
function GUI_Addparameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Addparameters (see VARARGIN)

% Choose default command line output for GUI_Addparameters
handles.output = hObject;

listeAffichage=cell(0,1);
setappdata(0,'listeAffichage',listeAffichage);
setappdata(0,'hMainGui',gcf);
listParams=cell(0,2);
setappdata(0,'listParams',listParams);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Addparameters wait for user response (see UIRESUME)
% uiwait(handles.GUI_2);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Addparameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_submit.
function push_submit_Callback(hObject, eventdata, handles)
% hObject    handle to push_submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Addparameters());


function edit_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name as text
%        str2double(get(hObject,'String')) returns contents of edit_name as a double


% --- Executes during object creation, after setting all properties.
function edit_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_value_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value as text
%        str2double(get(hObject,'String')) returns contents of edit_value as a double
name=get(handles.edit_name,'String');
value=get(hObject,'String');
if ~isempty(name)&&~isempty(value)
    listeAffichage=getappdata(0,'listeAffichage');
    listeAffichage{end+1,1}=[name,'=',value];
    setappdata(0,'listeAffichage',listeAffichage);
    set(handles.listbox_param,'String',listeAffichage);
    set(handles.edit_name,'String','');
    set(handles.edit_value,'String','');
    listParams=getappdata(0,'listParams');
    listParams{end+1,1}=name;
    listParams{end,2}=value;
    setappdata(0,'listParams',listParams);
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'listParams',listParams);
else
    warndlg('Name or value is missing');    
end  

% --- Executes during object creation, after setting all properties.
function edit_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_param.
function listbox_param_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_param contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_param


% --- Executes during object creation, after setting all properties.
function listbox_param_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_param (see GCBO)
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

name=get(handles.edit_name,'String');
value=get(handles.edit_value,'String');
if ~isempty(name)&&~isempty(value)
    listeAffichage=getappdata(0,'listeAffichage');
    listeAffichage{end+1,1}=[name,'=',value];
    setappdata(0,'listeAffichage',listeAffichage);
    set(handles.listbox_param,'String',listeAffichage);
    set(handles.edit_name,'String','');
    set(handles.edit_value,'String','');
    listParams=getappdata(0,'listParams');
    listParams{end+1,1}=name;
    listParams{end,2}=value;
    setappdata(0,'listParams',listParams);
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'listParams',listParams);
else
    warndlg('Name or value is missing');    
end


% --- Executes on button press in push_delete.
function push_delete_Callback(hObject, eventdata, handles)
% hObject    handle to push_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index=get(handles.listbox_param,'Value');
listeAffichage=getappdata(0,'listeAffichage');
if ~isempty(listeAffichage)
    listeAffichage(index,:)=[];
    set(handles.listbox_param,'Value',1);
    setappdata(0,'listeAffichage',listeAffichage);
    set(handles.listbox_param,'String',listeAffichage);
    listParams=getappdata(0,'listParams');
    listParams(index,:)=[];
    setappdata(0,'listParams',listParams);
    HandleMainGUI=getappdata(0,'HandleMainGUI');
    setappdata(HandleMainGUI,'listParams',listParams);
end
