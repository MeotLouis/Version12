function varargout = GUI_create_sp_file(varargin)
% GUI_CREATE_SP_FILE MATLAB code for GUI_create_sp_file.fig
%      GUI_CREATE_SP_FILE, by itself, creates a new GUI_CREATE_SP_FILE or raises the existing
%      singleton*.
%
%      H = GUI_CREATE_SP_FILE returns the handle to a new GUI_CREATE_SP_FILE or the handle to
%      the existing singleton*.
%
%      GUI_CREATE_SP_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CREATE_SP_FILE.M with the given input arguments.
%
%      GUI_CREATE_SP_FILE('Property','Value',...) creates a new GUI_CREATE_SP_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_create_sp_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_create_sp_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_create_sp_file

% Last Modified by GUIDE v2.5 22-Feb-2017 13:17:04
        
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_create_sp_file_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_create_sp_file_OutputFcn, ...
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


% --- Executes just before GUI_create_sp_file is made visible.
function GUI_create_sp_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_create_sp_file (see VARARGIN)

% Choose default command line output for GUI_create_sp_file
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
Init(handles);

% UIWAIT makes GUI_create_sp_file wa={'a','ait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = GUI_create_sp_file_OutputFcn(hObject, eventdata, handles) 
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
%handles    structure with handles and user data (see GUIDATA)
PushGenerate(handles);



% --- Executes on button press in push_edit_line.
function push_edit_line_Callback(hObject, eventdata, handles)
% hObject    handle to push_edit_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_all_lines,'String'));
a=get(handles.edit_line,'String');
if ~isempty(a)&&~isempty(contents)
    contents{get(handles.listbox_all_lines,'Value')}=a;
    set(handles.listbox_all_lines,'String',contents);
    set(handles.edit_line,'String','');
end

% --- Executes on button press in push_delete_line.
function push_delete_line_Callback(hObject, eventdata, handles)
% hObject    handle to push_delete_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_all_lines,'String'));
if get(handles.listbox_all_lines,'Value')<1
    set(handles.listbox_all_lines,'Value',1);
end
if ~isempty(contents)
    contents(get(handles.listbox_all_lines,'Value'),:)=[];
    set(handles.listbox_all_lines,'Value',1);
    set(handles.listbox_all_lines,'String',contents);
    set(handles.edit_line,'String','');
end

% --- Executes on selection change in listbox_all_lines.
function listbox_all_lines_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_all_lines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_all_lines contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_all_lines
contents = cellstr(get(hObject,'String'));
if ~isempty(contents)
    select=contents{get(hObject,'Value')};
    set(handles.edit_line,'String',select);
end

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
a=cell(1,1);
a{1,1}='******************';
set(hObject,'String',a);



function edit_line_Callback(hObject, eventdata, handles)
% hObject    handle to edit_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_line as text
%        str2double(get(hObject,'String')) returns contents of edit_line as a double


% --- Executes during object creation, after setting all properties.
function edit_line_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
PopUpMenu2(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_name_source_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_source as text
%        str2double(get(hObject,'String')) returns contents of edit_name_source as a double


% --- Executes during object creation, after setting all properties.
function edit_name_source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add_source.
function push_add_source_Callback(~, ~, handles)
% hObject    handle to push_add_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddSource(handles);

function edit_node1_source_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node1_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node1_source as text
%        str2double(get(hObject,'String')) returns contents of edit_node1_source as a double


% --- Executes during object creation, after setting all properties.
function edit_node1_source_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_node1_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_node2_source_Callback(~, ~, handles)
% hObject    handle to edit_node2_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node2_source as text
%        str2double(get(hObject,'String')) returns contents of edit_node2_source as a double


% --- Executes during object creation, after setting all properties.
function edit_node2_source_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_node2_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_option_source_Callback(hObject, eventdata, handles)
% hObject    handle to edit_option_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_option_source as text
%        str2double(get(hObject,'String')) returns contents of edit_option_source as a double


% --- Executes during object creation, after setting all properties.
function edit_option_source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_option_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_options.
function popup_options_Callback(hObject, eventdata, handles)
% hObject    handle to popup_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_options
set(handles.static_help,'String',sprintf(DisplayHelp('option',get(hObject,'Value'))));
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
PushAddOptions(handles);



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
[name_file,path] = uigetfile(strcat('C:\Users\',getenv('USERNAME'),'\Documents\/*.txt'));
if name_file~=0
    set(handles.edit_path_file,'string',strcat(path,name_file));
    [nodes,tlines]=NetlistReader(strcat(path,name_file));
    set(handles.popup_node_netlist,'String',nodes);
    set(handles.edit_netlist_subckt,'String','.subckt ');
    setappdata(0,'tlines',tlines);
end
set(handles.push_add_name,'Enable','on');

% --- Executes on selection change in popup_node_netlist.
function popup_node_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to popup_node_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_node_netlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_node_netlist


% --- Executes during object creation, after setting all properties.
function popup_node_netlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_node_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_import_netlist.
function push_import_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to push_import_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushImportNetlist(handles);

% --- Executes on button press in push_add_port_netlist.
function push_add_port_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_port_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddPortNetlist(handles);

% --- Executes on button press in push_add_name.
function push_add_name_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddName(handles);

function edit_netlist_subckt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_netlist_subckt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_netlist_subckt as text
%        str2double(get(hObject,'String')) returns contents of edit_netlist_subckt as a double


% --- Executes during object creation, after setting all properties.
function edit_netlist_subckt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_netlist_subckt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_type_element.
function popup_type_element_Callback(hObject, eventdata, handles)
% hObject    handle to popup_type_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_type_element contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_type_element
set(handles.static_help,'String',sprintf(DisplayHelp('element',get(hObject,'Value'))));


% --- Executes during object creation, after setting all properties.
function popup_type_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_type_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_name_element_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_element as text
%        str2double(get(hObject,'String')) returns contents of edit_name_element as a double


% --- Executes during object creation, after setting all properties.
function edit_name_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add_element.
function push_add_element_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddElement(handles);

function edit_option_element_Callback(hObject, eventdata, handles)
% hObject    handle to edit_option_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_option_element as text
%        str2double(get(hObject,'String')) returns contents of edit_option_element as a double


% --- Executes during object creation, after setting all properties.
function edit_option_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_option_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_node1_element.
function popup_node1_element_Callback(hObject, eventdata, handles)
% hObject    handle to popup_node1_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_node1_element contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_node1_element


% --- Executes during object creation, after setting all properties.
function popup_node1_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_node1_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_node2_element.
function popup_node2_element_Callback(hObject, eventdata, handles)
% hObject    handle to popup_node2_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_node2_element contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_node2_element


% --- Executes during object creation, after setting all properties.
function popup_node2_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_node2_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_value_source_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value_source as text
%        str2double(get(hObject,'String')) returns contents of edit_value_source as a double


% --- Executes during object creation, after setting all properties.
function edit_value_source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_value_element_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value_element as text
%        str2double(get(hObject,'String')) returns contents of edit_value_element as a double


% --- Executes during object creation, after setting all properties.
function edit_value_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_name_netlist2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_netlist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_netlist2 as text
%        str2double(get(hObject,'String')) returns contents of edit_name_netlist2 as a double


% --- Executes during object creation, after setting all properties.
function edit_name_netlist2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_netlist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_add_netlist.
function popup_add_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to popup_add_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_add_netlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_add_netlist
PopupAddElement(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popup_add_netlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_add_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_add_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to edit_add_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_add_netlist as text
%        str2double(get(hObject,'String')) returns contents of edit_add_netlist as a double


% --- Executes during object creation, after setting all properties.
function edit_add_netlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_add_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add_netlist.
function push_add_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddNetlist(handles);


function edit_name_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_netlist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_netlist2 as text
%        str2double(get(hObject,'String')) returns contents of edit_name_netlist2 as a double


% --- Executes during object creation, after setting all properties.
function edit_name_netlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_netlist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_path_file2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_file2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_file2 as text
%        str2double(get(hObject,'String')) returns contents of edit_path_file2 as a double


% --- Executes during object creation, after setting all properties.
function edit_path_file2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_file2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_browse2.
function push_browse2_Callback(hObject, eventdata, handles)
% hObject    handle to push_browse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat('C:\Users\',getenv('USERNAME'),'\Documents\/*.sp'));
if name_file ~= 0
    set(handles.edit_path_file2,'string',strcat(path,name_file));
end  

% --- Executes on button press in push_import_file.
function push_import_file_Callback(hObject, eventdata, handles)
% hObject    handle to push_import_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushImportFile(handles);


% --- Executes on button press in push_create_netlist_tool.
function push_create_netlist_tool_Callback(hObject, eventdata, handles)
% hObject    handle to push_create_netlist_tool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'list_handles',handles);
GUI_Create_netlist_file();
% if cancel==0
%     set(handles.edit_name_netlist,'String',data{1,1});
%     set(handles.edit_netlist_subckt,'String',data{2,1});
%     setappdata(0,'tlines',data{3,1});
%     %Disable all edit and popup if use the create tool
%     set(handles.edit_path_file,'enable','off');
%     set(handles.edit_name_netlist,'enable','off');
%     set(handles.edit_netlist_subckt,'enable','off');
%     set(handles.pop_node_netlist,'enable','off');
% end


% --- Executes on button press in push_leave.
function push_leave_Callback(hObject, eventdata, handles)
% hObject    handle to push_leave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_create_sp_file);
GUI_Parent();



function edit_in1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_in1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_in1 as text
%        str2double(get(hObject,'String')) returns contents of edit_in1 as a double


% --- Executes during object creation, after setting all properties.
function edit_in1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_in1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_in2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_in2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_in2 as text
%        str2double(get(hObject,'String')) returns contents of edit_in2 as a double


% --- Executes during object creation, after setting all properties.
function edit_in2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_in2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gain_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gain as text
%        str2double(get(hObject,'String')) returns contents of edit_gain as a double


% --- Executes during object creation, after setting all properties.
function edit_gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vn1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vn1 as text
%        str2double(get(hObject,'String')) returns contents of edit_vn1 as a double


% --- Executes during object creation, after setting all properties.
function edit_vn1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_transR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_transR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_transR as text
%        str2double(get(hObject,'String')) returns contents of edit_transR as a double


% --- Executes during object creation, after setting all properties.
function edit_transR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_transR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_transC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_transC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_transC as text
%        str2double(get(hObject,'String')) returns contents of edit_transC as a double


% --- Executes during object creation, after setting all properties.
function edit_transC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_transC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_keyword_Callback(hObject, eventdata, handles)
% hObject    handle to edit_keyword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_keyword as text
%        str2double(get(hObject,'String')) returns contents of edit_keyword as a double


% --- Executes during object creation, after setting all properties.
function edit_keyword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_keyword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_add_bipolar.
function push_add_bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddBipolar(handles);


% --- Executes on button press in push_add_JFET.
function push_add_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddJFET(handles);


% --- Executes on button press in push_add_MOSFET.
function push_add_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PushAddMOSFET(handles);


function edit_name_bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_bipolar as text
%        str2double(get(hObject,'String')) returns contents of edit_name_bipolar as a double


% --- Executes during object creation, after setting all properties.
function edit_name_bipolar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_name_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_JFET as text
%        str2double(get(hObject,'String')) returns contents of edit_name_JFET as a double


% --- Executes during object creation, after setting all properties.
function edit_name_JFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_S_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_S_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_S_JFET as text
%        str2double(get(hObject,'String')) returns contents of edit_S_JFET as a double


% --- Executes during object creation, after setting all properties.
function edit_S_JFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_S_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D_JFET as text
%        str2double(get(hObject,'String')) returns contents of edit_D_JFET as a double


% --- Executes during object creation, after setting all properties.
function edit_D_JFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_G_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_G_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_G_JFET as text
%        str2double(get(hObject,'String')) returns contents of edit_G_JFET as a double


% --- Executes during object creation, after setting all properties.
function edit_G_JFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_G_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_name_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_name_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_name_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_S_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_S_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_S_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_S_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_S_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_S_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_D_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_D_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_G_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_G_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_G_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_G_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_G_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_G_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_B_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_B_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_B_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_B_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_B_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_B_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_MOSFET.
function popup_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to popup_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_MOSFET contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_MOSFET


% --- Executes during object creation, after setting all properties.
function popup_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_JFET.
function popup_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to popup_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_JFET contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_JFET


% --- Executes during object creation, after setting all properties.
function popup_JFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_E_bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E_bipolar as text
%        str2double(get(hObject,'String')) returns contents of edit_E_bipolar as a double


% --- Executes during object creation, after setting all properties.
function edit_E_bipolar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_C_bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C_bipolar as text
%        str2double(get(hObject,'String')) returns contents of edit_C_bipolar as a double


% --- Executes during object creation, after setting all properties.
function edit_C_bipolar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_B_bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to edit_B_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_B_bipolar as text
%        str2double(get(hObject,'String')) returns contents of edit_B_bipolar as a double


% --- Executes during object creation, after setting all properties.
function edit_B_bipolar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_B_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_bipolar.
function popup_bipolar_Callback(hObject, eventdata, handles)
% hObject    handle to popup_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_bipolar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_bipolar


% --- Executes during object creation, after setting all properties.
function popup_bipolar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_bipolar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_w_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_w_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_w_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_l_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to edit_l_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_l_MOSFET as text
%        str2double(get(hObject,'String')) returns contents of edit_l_MOSFET as a double


% --- Executes during object creation, after setting all properties.
function edit_l_MOSFET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_l_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Main_circuit_Checkbox.
function Main_circuit_Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Main_circuit_Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Main_circuit_Checkbox
setappdata(0,'type_circuit','main');
set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'off')
set(handles.Subcircuit_Checkbox,'Value',0);
set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'on')
set(handles.text_help_sub,'enable','on');
set(handles.edit_name_circuit,'enable','on');
set(handles.text_main_circuit,'enable','on');
set(handles.push_preset_sp_file,'enable','on');

% --- Executes on button press in Subcircuit_Checkbox.
function Subcircuit_Checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Subcircuit_Checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Subcircuit_Checkbox
setappdata(0,'type_circuit','sub');
a=get(handles.popup_add_netlist,'String');
[n,m]=size(a);
if n>1
    set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'on')
else
    set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'off')
end
set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'on')
set(handles.Main_circuit_Checkbox,'Value',0);
set(handles.edit_name_circuit,'enable','off');
set(handles.text_main_circuit,'enable','off');
set(handles.push_preset_sp_file,'enable','off');

% --- Executes on button press in push_preset_sp_file.
function push_preset_sp_file_Callback(hObject, eventdata, handles)
% hObject    handle to push_preset_sp_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_Import_techno_and_data(handles.listbox_all_lines);




function edit_name_circuit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_name_circuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_name_circuit as text
%        str2double(get(hObject,'String')) returns contents of edit_name_circuit as a double


% --- Executes during object creation, after setting all properties.
function edit_name_circuit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name_circuit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_browse_technology.
function push_browse_technology_Callback(hObject, eventdata, handles)
% hObject    handle to push_browse_technology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name_file,path] = uigetfile(strcat(getappdata(0,'project_directory'),'\/*.lib'));
if name_file ~= 0
    set(handles.edit_path_technology,'string',strcat(path,name_file));
    setappdata(0,'file_technology',name_file);
    setappdata(0,'full_file_technology',strcat(path,name_file));
    [a,b]=libraryReader(strcat(path,name_file));
    set(handles.popup_techno,'String',a);
    setappdata(0,'list_models',b);
    setappdata(0,'quelle_techno',a{1,1});
end


function edit_path_technology_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_technology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_technology as text
%        str2double(get(hObject,'String')) returns contents of edit_path_technology as a double


% --- Executes during object creation, after setting all properties.
function edit_path_technology_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_technology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_techno.
function popup_techno_Callback(hObject, eventdata, handles)
% hObject    handle to popup_techno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_techno contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_techno
contents = cellstr(get(hObject,'String'));
setappdata(0,'quelle_techno',contents{get(hObject,'Value')});
b=getappdata(0,'list_models');
setappdata(0,'current_models',b(get(hObject,'Value'),:));
set(handles.popup_JFET,'enable','on');
set(handles.popup_JFET,'String',getappdata(0,'current_models')');
set(handles.popup_MOSFET,'enable','on');
set(handles.popup_MOSFET,'String',getappdata(0,'current_models')');
set(handles.popup_bipolar,'enable','on');
set(handles.popup_bipolar,'String',getappdata(0,'current_models')');
setappdata(0,'import_techno_already_done',0);

% --- Executes during object creation, after setting all properties.
function popup_techno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_techno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_m_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m as text
%        str2double(get(hObject,'String')) returns contents of edit_m as a double


% --- Executes during object creation, after setting all properties.
function edit_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
