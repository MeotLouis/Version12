function varargout = GUI_data_creator(varargin)
% GUI_DATA_CREATOR MATLAB code for GUI_data_creator.fig
%      GUI_DATA_CREATOR, by itself, creates a new GUI_DATA_CREATOR or raises the existing
%      singleton*.
%
%      H = GUI_DATA_CREATOR returns the handle to a new GUI_DATA_CREATOR or the handle to
%      the existing singleton*.
%
%      GUI_DATA_CREATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DATA_CREATOR.M with the given input arguments.
%
%      GUI_DATA_CREATOR('Property','Value',...) creates a new GUI_DATA_CREATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_data_creator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_data_creator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_data_creator

% Last Modified by GUIDE v2.5 02-Nov-2016 11:16:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_data_creator_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_data_creator_OutputFcn, ...
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


% --- Executes just before GUI_data_creator is made visible.
function GUI_data_creator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_data_creator (see VARARGIN)

% Choose default command line output for GUI_data_creator
handles.output = hObject;
setappdata(0,'list_params',cell(0,2));
set(handles.uitable1,'Data',cell(0,0));
list_index=cell(0,1);
for i=1:100
    list_index{end+1,1}=i;
end
list_names{1,1}='-';
set(handles.pop_name,'String',list_names);
set(handles.pop_index,'String',list_index);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_data_creator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_data_creator_OutputFcn(hObject, eventdata, handles) 
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
filename=get(handles.edit_path_file,'String');
if isempty(filename)
    errordlg('Choose output file');
else
    data=get(handles.uitable1,'Data');
    [nbRow,nbCol]=size(data);
    b=0;
    for i=1:nbRow
        for j=1:nbCol
            if isempty(data{i,j})
                b=1;
                a=i;
                c=j;
            end
        end
    end
    if b==0
        Cell2file(get(handles.uitable1,'Data'),filename);
    else
        errordlg(['Missing at Row:',num2str(a),' ','Column:',num2str(c)]);
    end
end

function edit_name_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_parameter as text
%        str2double(get(hObject,'String')) returns contents of edit_name_parameter as a double


% --- Executes during object creation, after setting all properties.
function edit_name_parameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_value_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value_parameter as text
%        str2double(get(hObject,'String')) returns contents of edit_value_parameter as a double


% --- Executes during object creation, after setting all properties.
function edit_value_parameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_path_file_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_file as text
%        str2double(get(hObject,'String')) returns contents of edit_path_file as a double


% --- Executes during object creation, after setting all properties.
function edit_path_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_file (see GCBO)
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
[name_file,path] = uiputfile(strcat('C:\Users\',getenv('USERNAME'),'\Documents\/*.dat'));
if name_file~=0
    set(handles.edit_path_file,'string',strcat(path,name_file));
end


function edit_value_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_value_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_value_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_name.
function pop_name_Callback(hObject, eventdata, handles)
% hObject    handle to pop_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_name


% --- Executes during object creation, after setting all properties.
function pop_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_index.
function pop_index_Callback(hObject, eventdata, handles)
% hObject    handle to pop_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_index contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_index


% --- Executes during object creation, after setting all properties.
function pop_index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add_value.
function push_add_value_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos_name=get(handles.pop_name,'Value');
value=get(handles.edit_value_2,'String');
if pos_name==1
    errordlg('Incorrect name selected');
elseif isempty(value)
    errordlg('Missing value');
else
    list_params=get(handles.uitable1,'Data');
    list_params{pos_name-1,get(handles.pop_index,'Value')}=value;
    setappdata(0,'list_params',list_params);
    set(handles.uitable1,'Data',list_params);
end    

% --- Executes on button press in push_add_parameter.
function push_add_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This function add the parameter only if the name and the value are present
%and if the name is not already used
name=get(handles.edit_name_parameter,'String');
value=get(handles.edit_value_parameter,'String');
if isempty(name)
    errordlg('Missing name of parameter');
elseif isempty(value)
    errordlg('Missing value of parameter');
else
    list_params=get(handles.uitable1,'Data');
    [a,~]=size(list_params);
    if a==0
        list_params{end+1,1}=name;
        list_params{end,2}=value;
        setappdata(0,'list_params',list_params);
        set(handles.uitable1,'Data',list_params);
        set(handles.edit_name_parameter,'String','');
        set(handles.edit_value_parameter,'String','');
        %Update of the pop_up_name and index
        list_names=get(handles.pop_name,'String');
        list_names{end+1,1}=name;
        set(handles.pop_name,'String',list_names);
    else
        b=0;
        for i=1:a
            if isequal(name,list_params{i,1})
                b=b+1;
            end
        end
        if b==0
            list_params{end+1,1}=name;
            list_params{end,2}=value;
            setappdata(0,'list_params',list_params);
            set(handles.uitable1,'Data',list_params);
            set(handles.edit_name_parameter,'String','');
            set(handles.edit_value_parameter,'String','');
            %Update of the pop_up_name and index
            list_names=get(handles.pop_name,'String');
            list_names{end+1,1}=name;
            set(handles.pop_name,'String',list_names);
        else
            errordlg('Name already used');
        end
    end
end


function uitable1_CellSelectionCallback(hObject,eventdata,handles)
if ~isempty(eventdata.Indices)
    handles.currentCell=eventdata.Indices;
    guidata(hObject,handles);
    Indices=handles.currentCell;
    setappdata(0,'selectionRow',Indices(1));
    setappdata(0,'selectionCol',Indices(2));
end

% --- Executes on button press in push_delete_cell.
function push_delete_cell_Callback(hObject, eventdata, handles)
% hObject    handle to push_delete_cell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable1,'Data');
data{getappdata(0,'selectionRow'),getappdata(0,'selectionCol')}=[];
set(handles.uitable1,'Data',data);


% --- Executes on button press in push_close.
function push_close_Callback(hObject, eventdata, handles)
% hObject    handle to push_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_data_creator());