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

function Init(handles)
setappdata(0,'type_circuit','main');
set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'off')
set(handles.Subcircuit_Checkbox,'Value',0);
set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'on')
set(handles.text_help_sub,'enable','on');
%On va essayer de tout stocker dans 'data'
data=cell(0,1);
data{end+1}=cell(0,1);
setappdata(0,'data',data);
setappdata(0,'type_circuit','main');
setappdata(0,'nb_ports',0);
setappdata(0,'list_nodes',cell(0,1));
setappdata(0,'list_nodes_netlist',cell(0,1));
setappdata(0,'name_netlist',[]);
setappdata(0,'nb_netlist',0);
setappdata(0,'list_netlist',cell(0,1));
setappdata(0,'import_techno_already_done',0);
axes(handles.axes1);
axis off;
% IMPORT OF .INC FILES
list_files=cellstr(ls(getappdata(0,'project_directory')));
list2=cell(0,1);
nb=0;
list_netlist2=cell(0,1);
[nb_ligne,~]=size(list_files);
if nb_ligne>2
    for i=3:nb_ligne
        aux2=list_files{i,1};
        aux=strsplit(list_files{i,1},'.');
        if isequal(aux{1,2},'inc')
            list2{end+1,1}=aux{1,1};
            nb=nb+1;
            display(aux2);
            presence=0;
            fid=fopen([getappdata(0,'project_directory'),'\',aux2]);
            tline=fgetl(fid);
            while ischar(tline)&&presence==0
                if ~isempty(strfind(tline,'.subckt'))
                    list_netlist=getappdata(0,'list_netlist');
                    list_netlist{end+1,1}=tline;
                    setappdata(0,'list_netlist',list_netlist);
                    presence=1;
                end
                tline=fgetl(fid);
            end
            fclose(fid);
        end
    end
%     list=get(handles.popup_add_netlist,'String');
%     if ~iscell(list)
%         list3=cell(0,1);
%         list3{end+1,1}=list;
%         list=list3;
%     end
    list={'-'};
    for i=1:nb
        list{end+1,1}=list2{i,1};
    end
    set(handles.popup_add_netlist,'String',list);
    
end

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
if isequal(getappdata(0,'type_circuit'),'main')
    if isempty(get(handles.edit_name_circuit,'String'))
        errordlg('Missing name of circuit');
    end
    if isempty(getappdata(0,'project_directory'))
        errordlg('Missing project directory');
        project_directory=uigetdir();
        setappdata(0,'project_directory',project_directory);
    end
    path=getappdata(0,'project_directory');
    name=get(handles.edit_name_circuit,'String');
    %/!\METTRE ICI LE CONDITION DE SUPPRESSION DE L'ANCIEN FICHIER S'IL EXISTE
    name_file=[path,'\',name,'.sp'];
    if exist(name_file,'file')~=0
        delete(name_file);
    end

    fid=fopen(name_file,'at');
    tlines=get(handles.listbox_all_lines,'String');
    [lignes,~]=size(tlines);
    for i=1:lignes
       fprintf(fid, strcat(tlines{i,1},'\n')); 
    end
    fprintf(fid,'\n');
    fclose(fid);
    close(GUI_create_sp_file);
    GUI_Parent()
else
    errordlg('You circuit must be the Main Circuit to be generated as a sp file');
end


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
set(handles.static_help,'String',sprintf(DisplayHelp('source',get(hObject,'Value'))));
contents = cellstr(get(hObject,'String'));
select=contents{get(hObject,'Value')};
if length(select)>1
    %------Default display-------%
    set(handles.push_add_source,'enable','off');
    set(handles.edit_name_source,'enable','off');
    set(handles.edit_node1_source,'enable','off');
    set(handles.edit_node2_source,'enable','off');
    set(handles.edit_option_source,'enable','off');
    set(handles.text7,'enable','off');
    set(handles.text8,'enable','off');
    set(handles.text9,'enable','off');
    set(handles.text10,'enable','off');
    set(handles.text11,'enable','off');
    %--------Panel Display-------%
    set(handles.text42,'enable','off');
    set(handles.text34,'enable','off');
    set(handles.text35,'enable','off');
    set(handles.text38,'enable','off');
    set(handles.text39,'enable','off');
    set(handles.text40,'enable','off');
    set(handles.text41,'enable','off');
    set(handles.text22,'enable','off');
    set(handles.edit_in1,'enable','off');
    set(handles.edit_in2,'enable','off');
    set(handles.edit_keyword,'enable','off');
    set(handles.edit_gain,'enable','off');
    set(handles.edit_vn1,'enable','off');
    set(handles.edit_transR,'enable','off');
    set(handles.edit_transC,'enable','off');
    set(handles.edit_value_source,'enable','off');
else
    %--------Reset Panel Display-------%
    set(handles.text42,'enable','off');
    set(handles.text34,'enable','off');
    set(handles.text35,'enable','off');
    set(handles.text38,'enable','off');
    set(handles.text39,'enable','off');
    set(handles.text40,'enable','off');
    set(handles.text41,'enable','off');
    set(handles.text22,'enable','off');
    set(handles.edit_in1,'enable','off');
    set(handles.edit_in2,'enable','off');
    set(handles.edit_keyword,'enable','off');
    set(handles.edit_gain,'enable','off');
    set(handles.edit_vn1,'enable','off');
    set(handles.edit_transR,'enable','off');
    set(handles.edit_transC,'enable','off');
    set(handles.edit_value_source,'enable','off');
    %----------Default display----------%
    set(handles.push_add_source,'enable','on');
    set(handles.edit_name_source,'enable','on');
    set(handles.edit_node1_source,'enable','on');
    set(handles.edit_node2_source,'enable','on');
    set(handles.edit_option_source,'enable','on');
    set(handles.text7,'enable','on');
    set(handles.text8,'enable','on');
    set(handles.text9,'enable','on');
    set(handles.text10,'enable','on');
    set(handles.text11,'enable','on');
    if isequal(select,'V')||isequal(select,'I')
        set(handles.edit_value_source,'enable','on');
        set(handles.text22,'enable','on');
    else
        set(handles.edit_keyword,'enable','on');
        set(handles.text42,'enable','on');
        if isequal(select,'E')
            set(handles.edit_in1,'enable','on');
            set(handles.edit_in2,'enable','on');
            set(handles.text34,'enable','on');
            set(handles.text35,'enable','on');
            set(handles.edit_gain,'enable','on');
            set(handles.text38,'enable','on');
        elseif isequal(select,'F')
            set(handles.edit_vn1,'enable','on');
            set(handles.text39,'enable','on');
            set(handles.edit_gain,'enable','on');
            set(handles.text38,'enable','on');
        elseif isequal(select,'G')
            set(handles.edit_in1,'enable','on');
            set(handles.edit_in2,'enable','on');
            set(handles.text34,'enable','on');
            set(handles.text35,'enable','on');
            set(handles.edit_transC,'enable','on');
            set(handles.text41,'enable','on');
        else
            set(handles.edit_vn1,'enable','on');
            set(handles.text39,'enable','on');
            set(handles.edit_transR,'enable','on');
            set(handles.text40,'enable','on');
        end
    end    
end
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
contents = cellstr(get(handles.popupmenu2,'String'));
select = contents{get(handles.popupmenu2,'Value')};
[~,b]=size(select);
if b==2
    errordlg('Missing type of source');
elseif isempty(get(handles.edit_name_source,'String'))
    errordlg('Missing name of source');
elseif isempty(get(handles.edit_node1_source,'String'))
    errordlg('Missing ports +');
elseif isempty(get(handles.edit_node2_source,'String'))
    errordlg('Missing ports -');
else
    if isequal(select,'V')||isequal(select,'I')
        if isempty(get(handles.edit_value_source,'String'));
            value=inputdlg('Please enter value of source:');
            value=value{1,1};
        else
            value=get(handles.edit_value_source,'String');
            value=IsOperation(value);
        end
        suite=value;
    else
        if isequal(select,'E')
            in1=get(handles.edit_in1,'String');
            if isempty(in1);
                in1=inputdlg('Please enter name of control node +:');
                in1=in1{1,1};
            end
            in2=get(handles.edit_in2,'String');
            if isempty(in2);
                in2=inputdlg('Please enter name of control node -:');
                in2=in2{1,1};
            end 
            gain=get(handles.edit_gain,'String');
            if isempty(gain);
                gain=inputdlg('Please gain of source value:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[in1,' ',in2,' ',gain];
            else
                suite=[keyword,' ',in1,' ',in2,' ',gain];
            end
            Add_Nodes(in1);
            Add_Nodes(in2);
        elseif isequal(select,'F')
            vn1=get(handles.edit_vn1,'String');
            if isempty(vn1);
                vn1=inputdlg('Please enter name of voltage source who take the flow:');
                vn1=vn1{1,1};
            end
            gain=get(handles.edit_gain,'String');
            if isempty(gain);
                gain=inputdlg('Please gain of source value:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[vn1,' ',gain];
            else
                suite=[keyword,' ',vn1,' ',gain];
            end
        elseif isequal(select,'G')
            in1=get(handles.edit_in1,'String');
            if isempty(in1);
                in1=inputdlg('Please enter name of control node +:');
                in1=in1{1,1};
            end
            in2=get(handles.edit_in2,'String');
            if isempty(in2);
                in2=inputdlg('Please enter name of control node -:');
                in2=in2{1,1};
            end 
            gain=get(handles.edit_transC,'String');
            if isempty(gain);
                gain=inputdlg('Please value of transconductance:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[in1,' ',in2,' ',gain];
            else
                suite=[keyword,' ',in1,' ',in2,' ',gain];
            end
            Add_Nodes(in1);
            Add_Nodes(in2);
        else
            vn1=get(handles.edit_vn1,'String');
            if isempty(vn1);
                vn1=inputdlg('Please enter name of voltage source who take the flow:');
                vn1=vn1{1,1};
            end
            gain=get(handles.edit_transR,'String');
            if isempty(gain);
                gain=inputdlg('Please value of transresistance:');
                gain=gain{1,1};
            end
            value=gain;
            keyword=get(handles.edit_keyword,'String');
            if isempty(keyword);
                suite=[vn1,' ',gain];
            else
                suite=[keyword,' ',vn1,' ',gain];
            end
        end
    end
    
    type=select;
    name=get(handles.edit_name_source,'String');
    node1=get(handles.edit_node1_source,'String');
    node2=get(handles.edit_node2_source,'String');
    type2=type;
    type=[type,name,' ',node1,' ',node2,' ',suite];
    if ~isempty(get(handles.edit_option_source,'String'))
        type=[type,' ',get(handles.edit_option_source,'String')];
    end
    
    %--------DATA-------%
    Add_Nodes(node1);
    Add_Nodes(node2);
    dataSource=cell(8,1);
    dataSource{1,1}='Source';
    dataSource{2,1}=name;
    dataSource{3,1}=node1;
    dataSource{4,1}=node2;
    dataSource{5,1}=type2;
    dataSource{6,1}=value;
    dataSource{7,1}={0,0};
    dataSource{8,1}={10,10};
    data=getappdata(0,'data');
    data{end+1,1}=dataSource;
    setappdata(0,'data',data);
    %On affiche la liste de nodes dans les popup d'element
    set(handles.popup_node1_element,'String',data{1,1});
    set(handles.popup_node2_element,'String',data{1,1});
    set(handles.popup_node_netlist,'String',data{1,1});
    
    %-----Reset edittext------%
    set(handles.edit_name_source,'String','');
    set(handles.edit_node1_source,'String','');
    set(handles.edit_node2_source,'String','');
    set(handles.edit_value_source,'String','');
    set(handles.edit_option_source,'String','');
    set(handles.popupmenu2,'Value',1);
    set(handles.edit_in1,'String','');
    set(handles.edit_in2,'String','');
    set(handles.edit_keyword,'String','');
    set(handles.edit_gain,'String','');
    set(handles.edit_vn1,'String','');
    set(handles.edit_transR,'String','');
    set(handles.edit_transC,'String','');
    
    %-----Update La listbox-----%
    liste=get(handles.listbox_all_lines,'String');
    liste{end+1,1}=type;
    [a,~]=size(liste);
    set(handles.listbox_all_lines,'Value',a);
    set(handles.listbox_all_lines,'String',liste);
    
    %-----Affichage graphique-----%
    CalculCoordonates(handles);
    %-------OLD APPDATA-----%
%     list_nodes=getappdata(0,'list_nodes');
%     list_nodes{end+1,1}=node1;
%     list_nodes{end+1,1}=node2;
%     setappdata(0,'list_nodes',list_nodes);
%     set(handles.popup_node1_element,'String',list_nodes);
%     set(handles.popup_node2_element,'String',list_nodes);
 end

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
        liste{end+1,1}='';
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_options,'Value',1);
    else
        set(handles.edit_option,'String','');
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=option;
        liste{end+1,1}='';
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_options,'Value',1);
    end
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
display(get(handles.popup_node_netlist,'String'),'');
if isempty(getappdata(0,'project_directory'))
    errordlg('Missing project directory');
    project_directory=uigetdir();
    setappdata(0,'project_directory',project_directory);
elseif isempty(get(handles.edit_name_netlist,'String'))
    errordlg('Missing name of Sub circuit');
elseif isempty(get(handles.popup_node_netlist,'String'))
    errordlg('You need to add at least one port to generate a subcircuit');
else
    path=getappdata(0,'project_directory');
    name=get(handles.edit_name_netlist,'String');

    name_file=[path,'\',name,'.inc'];
    if exist(name_file,'file')~=0
        delete(name_file);
    end

    fid=fopen(name_file,'at');
    tlines=get(handles.listbox_all_lines,'String');
    [lignes,~]=size(tlines);
    fprintf(fid,strcat(get(handles.edit_netlist_subckt,'String'),'\n'));
    for i=1:lignes
       fprintf(fid, strcat(tlines{i,1},'\n')); 
    end
    fprintf(fid,'.ends');
    fprintf(fid,'\n');
    fclose(fid);

%     set(handles.popup_add_netlist,'Enable','on');
%     set(handles.edit_add_netlist,'Enable','on');
%     set(handles.push_add_netlist,'Enable','on');
%     type=get(handles.edit_name_netlist,'String');
%     list=get(handles.popup_add_netlist,'String');
%     if ~iscell(list)
%         list2=cell(0,1);
%         list2{end+1,1}=list;
%         list=list2;
%     end
%     list{end+1,1}=type;
%     set(handles.popup_add_netlist,'String',list);
%     [a,~]=size(list);
%     set(handles.listbox_all_lines,'Value',a);
    set(handles.edit_path_file,'String','');
    set(handles.popup_node_netlist,'String',{' '});
    set(handles.edit_name_netlist2,'String','');
    list_netlist=getappdata(0,'list_netlist');
    list_netlist{end+1,1}=get(handles.edit_netlist_subckt,'String');
    setappdata(0,'list_netlist',list_netlist);
    set(handles.edit_netlist_subckt,'String','.subckt');
    set(handles.edit_name_netlist,'String','');
    set(handles.push_add_name,'Enable','on');
    setappdata(0,'name_netlist',[]);
    %Enalble all edit and popup disabled because of the use of the create tool
    set(handles.edit_path_file,'enable','on');
    set(handles.edit_name_netlist,'enable','on');
    set(handles.edit_netlist_subckt,'enable','on');
    set(handles.popup_node_netlist,'enable','on');
    Reset(handles);
end


% --- Executes on button press in push_add_port_netlist.
function push_add_port_netlist_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_port_netlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(getappdata(0,'name_netlist'))
     errordlg('Missing name of netlist');
else
    %update de la list de port du panel add subcircuit
    contents = cellstr(get(handles.popup_node_netlist,'String'));
    port=contents{get(handles.popup_node_netlist,'Value')};
    display(port);
    if isequal(port,'')
        errordlg('Please add at least one element to generate port');
    else
        list_nodes=getappdata(0,'list_nodes');
        list_nodes{end+1,1}=port;
        setappdata(0,'list_nodes',list_nodes);
        set(handles.popup_node1_element,'String',list_nodes);
        set(handles.popup_node2_element,'String',list_nodes);
        ligne=get(handles.edit_netlist_subckt,'String');
        ligne=[ligne,port,' '];
        setappdata(0,'nb_ports',getappdata(0,'nb_ports')+1);
        set(handles.edit_netlist_subckt,'String',ligne);
        list_nodes_netlist=getappdata(0,'list_nodes_netlist');
        list_nodes_netlist{end+1,1}=port;
        setappdata(0,'list_nodes_netlist',list_nodes_netlist);

        %----UPDATE DATA-----%
        Add_Nodes(port);
        data=getappdata(0,'data');
        %update popup node elements
        set(handles.popup_node1_element,'String',data{1,1});
        set(handles.popup_node2_element,'String',data{1,1});
        set(handles.popup_node_netlist,'String',data{1,1});

        %data{end,1}{5,1}{end+1,1}=port;
        %setappdata(0,'data',data);
        %----END UPDATE DATA---%
    end
end



% --- Executes on button press in push_add_name.
function push_add_name_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.edit_name_netlist,'String'))
    errordlg('Missing name');
else
    text=get(handles.edit_name_netlist,'String');
    setappdata(0,'name_netlist',text);
    setappdata(0,'nb_netlist',getappdata(0,'nb_netlist')+1);
    set(hObject,'Enable','on');
    set(handles.edit_netlist_subckt,'String',[get(handles.edit_netlist_subckt,'String'),' ',text,' ']);
    
%     %----UPDATE DATA-----%
%     data=getappdata(0,'data');
%     dataNetlist=cell(5,1);
%     dataNetlist{1,1}='nelist';
%     dataNetlist{2,1}=text;
%     dataNetlist{3,1}=cell(0,1);
%     dataNetlist{4,1}=cell(0,1);
%     dataNetlist{5,1}={0,0};
%     dataNetlist{6,1}={10,10};
%     data{end+1,1}=dataNetlist;
%     setappdata(0,'data',data);
%     %----END UPDATE DATA---%
end

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
contents = cellstr(get(handles.popup_type_element,'String'));
select = contents{get(handles.popup_type_element,'Value')};
if isequal(select,'-')
    errordlg('Missing type of element');
elseif isempty(get(handles.edit_name_element,'String'))
    errordlg('Missing name of element');
elseif isempty(get(handles.edit_value_element,'String'))
    errordlg('Missing value of element');
else
    type=select;
    contents = cellstr(get(handles.popup_node1_element,'String'));
    select = contents{get(handles.popup_node1_element,'Value')};
    node1=select;
    contents = cellstr(get(handles.popup_node2_element,'String'));
    select = contents{get(handles.popup_node2_element,'Value')};
    node2=select;
    value=get(handles.edit_value_element,'String');
    %On effectue cette boucle pour voir si la valeur est une équation et
    %mettre des '' si elle en est une
    pattern={'*','+','/','-'};
    a=0;
    for j=1:4
        if ~isempty(strfind(value,pattern{1,j}))
            a=a+1;
        end
    end
    if a~=0
        value=['''',value,''''];
    end
    %Test si le nom est déja utilisé
    name=get(handles.edit_name_element,'String');
    data=getappdata(0,'data');
    bool=0;
    for i=2:length(data);
        if isequal(name,data{i,1}{2,1})
            bool=1;
        end
    end
    if bool==1
        errordlg('Name already in use');
    else
        %---------UPDATE DATA----%
        data=getappdata(0,'data');
        dataElement=cell(8,1);
        dataElement{1,1}='element';
        dataElement{2,1}=name;
        dataElement{3,1}=node1;
        dataElement{4,1}=node2;
        dataElement{5,1}=type;
        dataElement{6,1}=value;
        dataElement{7,1}={0,0};
        dataElement{8,1}={10,10};
        data{end+1,1}=dataElement;
        setappdata(0,'data',data);
        %---------END UPDATE DATA----%

        type=[type,name,' ',node1,' ',node2,' ',value];
        if ~isempty(get(handles.edit_option_element,'String'))
            type=[type,' ',get(handles.edit_option_source,'String')];
        end
        %REset edit text
        set(handles.edit_name_element,'String','');
        set(handles.edit_value_element,'String','');
        set(handles.edit_option_element,'String','');
        set(handles.popup_type_element,'Value',1);
        %Update listbox all lines
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=type;
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        %-----Affichage graphique-----%
        CalculCoordonates(handles);
    end
end
 

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
list=getappdata(0,'list_netlist');
if get(hObject,'Value')>1
    select=list{get(hObject,'Value')-1};
    select=strsplit(select);
    [~,b]=size(select);
    select1='';
    for i=3:b
        select1=[select1,select{i},' '];
    end
    set(handles.static_add_netlist,'String',select1);
else
    set(handles.static_add_netlist,'String','');
end

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
base=get(handles.static_add_netlist,'String');
text=get(handles.edit_add_netlist,'String');
base1=strsplit(base);
text1=strsplit(text);
[~,a]=size(base1);
aa=a;
for i=1:a
    if isequal(base1{1,i},'')
        aa=aa-1;
    end
end
[~,b]=size(text1);
bb=b;
for i=1:b
    if isequal(text1{1,i},'')
        bb=bb-1;
    end
end
name=get(handles.edit_name_netlist2,'String');
contents = cellstr(get(handles.popup_add_netlist,'String'));
type=contents{get(handles.popup_add_netlist,'Value')};
if aa~=bb
    errordlg(['You must connect all ports of the netlist. Number required: ',num2str(aa),' Number you have submited:',num2str(bb)]);
elseif isempty(name)
     errordlg('Missing name of element');   
elseif isequal(type,'-')
    errordlg('Missing type of subcircuit');
else
    %Test si le nom est déja utilisé et n'utilise pas une lettre non
    %autorisée
    data=getappdata(0,'data');
    bool=0;
    bool2=0;
    for i=2:length(data);
        if isequal(name,data{i,1}{2,1})
            bool=1;
        end
    end
    pattern={'e','f','g','h','v','i','d','k','l','c','E','F','G','H','V','I','D','K','L','C'};
    for i=1:length(pattern)
        if ~isempty(strfind(name,pattern{1,i}))
            bool2=1;
            letter=pattern{1,i};
        end
    end
    if bool==1
        errordlg('Name already in use');
    elseif bool2==1
        errordlg(sprintf(['Invalid name, you can not use the letter ''',letter,''' at the beginning of the name\nYou can use X for example.']));
    else   
        %----UPDATE DATA-----%
        
        dataNetlist=cell(5,1);
        dataNetlist{1,1}='netlist';
        dataNetlist{2,1}=name;
        dataNetlist{3,1}=cell(0,1);
        [~,a]=size(base1);
        for i=1:a
            if ~isequal(base1{1,i},'')
                dataNetlist{3,1}{end+1,1}=base1{1,i};
            end
        end
        dataNetlist{4,1}=cell(0,1);
        [~,b]=size(text1);
        for i=1:b
            if ~isequal(text1{1,i},'')
                dataNetlist{4,1}{end+1,1}=text1{1,i};
                Add_Nodes(text1{1,i});
                
            end
        end
        dataNetlist{5,1}={0,0};
        dataNetlist{6,1}={10,10};
        data=getappdata(0,'data');
        data{end+1,1}=dataNetlist;
        setappdata(0,'data',data);
        %----END UPDATE DATA---%
        set(handles.popup_node_netlist,'String',data{1,1});
        set(handles.popup_node1_element,'String',data{1,1});
        set(handles.popup_node2_element,'String',data{1,1});
        contents = cellstr(get(handles.popup_add_netlist,'String'));
        select=contents{get(handles.popup_add_netlist,'Value')};
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=[name,' ',get(handles.edit_add_netlist,'String'),' ',select];
        set(handles.listbox_all_lines,'String',liste);
        [a,~]=size(liste);
        set(handles.listbox_all_lines,'Value',a);
        set(handles.popup_add_netlist,'Value',1);
        set(handles.static_add_netlist,'String','');
        set(handles.edit_add_netlist,'String','');
        set(handles.edit_name_netlist2,'String','');

        %-----Affichage graphique-----%
        CalculCoordonates(handles);
    end
end

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
if ~isempty(get(handles.edit_path_file2,'String'))
    fid2=fopen(get(handles.edit_path_file2,'String'));
    tline = fgetl(fid2);
    tlines2=cell(0,1);
    while ischar(tline)
        tlines2{end+1,1} = tline;
        tline = fgetl(fid2);
    end
    fclose(fid2);
    [a,~]=size(tlines2);
    for i=1:a
        liste=get(handles.listbox_all_lines,'String');
        liste{end+1,1}=tlines2{i,1};
        set(handles.listbox_all_lines,'String',liste);
    end
end


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
name=get(handles.edit_name_bipolar,'String');
if isempty(name)
    name=inputdlg('Enter name of Bipolar transistor');
    name=name{1,1};
end
E=get(handles.edit_E_bipolar,'String');
if isempty(E)
    E=inputdlg('Enter name of node connected to Emettor');
    E=E{1,1};
end
B=get(handles.edit_B_bipolar,'String');
if isempty(B)
    B=inputdlg('Enter name of node connected to Base');
    B=B{1,1};
end
C=get(handles.edit_C_bipolar,'String');
if isempty(C)
    C=inputdlg('Enter name of node connected to Collector');
    C=C{1,1};
end
model='';
if ~isempty(get(handles.edit_path_technology,'String'))
    %Copie du fichier .lib
    foo=strsplit(get(handles.edit_path_technology,'String'),'\');
    foo=foo(end);
    destination=strcat(getappdata(0,'project_directory'),'\',foo);
    destination=destination{1,1};
    if ~isequal(get(handles.edit_path_technology,'String'),destination)
        copyfile(get(handles.edit_path_technology,'String'),destination,'f');
        %Bloc permettant de copier le fichier .mdl
        path_mld=get(handles.edit_path_technology,'String');
        path_mld=path_mld(1:end-3);
        path_mld=[path_mld,'mdl'];
        destination=destination(1:end-3);
        destination=[destination,'mdl'];
        assignin('base','path_mld',path_mld);
        if exist(path_mld, 'file') ~= 0
            copyfile(path_mld,destination,'f'); 
        end
    end
    
    model=getappdata(0,'current_models')';
    model=model{get(handles.popup_bipolar,'Value')};
end

%-----Data update-----%
Add_Nodes(C);
Add_Nodes(B);
Add_Nodes(E);
data_bipolar=cell(0,1);
data_bipolar{end+1,1}='Bipolar';
data_bipolar{end+1,1}=['G',name];
data_bipolar{end+1,1}=C;
data_bipolar{end+1,1}=B;
data_bipolar{end+1,1}=E;
data_bipolar{end+1,1}=model;
data=getappdata(0,'data');
data{end+1,1}=data_bipolar;
setappdata(0,'data',data);
set(handles.popup_node1_element,'String',data{1,1});
set(handles.popup_node2_element,'String',data{1,1});
set(handles.popup_node_netlist,'String',data{1,1});

%------ListBox Update----%
liste=get(handles.listbox_all_lines,'String');
%Import du nom de la techno et ecriture dans le fichier
if ~isempty(model)&&getappdata(0,'import_techno_already_done')==0;
    liste{end+1,1} = '';
    liste{end+1,1} = '*Import libraries';
    liste{end+1,1} = '';
    liste{end+1,1} = '.prot';
    liste{end+1,1} = ['.LIB ','./',foo{1,1},' ',getappdata(0,'quelle_techno')];
    liste{end+1,1} = '.unprot';
    liste{end+1,1} = '';
    setappdata(0,'import_techno_already_done',1);
end
liste{end+1,1}=['G',name,' ',C,' ',B,' ',E,' ',model];
set(handles.listbox_all_lines,'String',liste);

%-----REset of fields------%
set(handles.edit_C_bipolar,'String','');
set(handles.edit_name_bipolar,'String','');
set(handles.edit_B_bipolar,'String','');
set(handles.edit_E_bipolar,'String','');
set(handles.popup_bipolar,'Value',1);

%-----Affichage graphique-----%
        CalculCoordonates(handles);


% --- Executes on button press in push_add_JFET.
function push_add_JFET_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_JFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=get(handles.edit_name_JFET,'String');
if isempty(name)
    name=inputdlg('Enter name of JFET transistor');
    name=name{1,1};
end
D=get(handles.edit_D_JFET,'String');
if isempty(D)
    D=inputdlg('Enter name of node connected to D');
    D=D{1,1};
end
G=get(handles.edit_G_JFET,'String');
if isempty(G)
    G=inputdlg('Enter name of node connected to G');
    G=G{1,1};
end
S=get(handles.edit_S_JFET,'String');
if isempty(S)
    S=inputdlg('Enter name of node connected to S');
    S=S{1,1}; 
end
model='';
if ~isempty(get(handles.edit_path_technology,'String'))
    %Copie du fichier .lib
    foo=strsplit(get(handles.edit_path_technology,'String'),'\');
    foo=foo(end);
    destination=strcat(getappdata(0,'project_directory'),'\',foo);
    destination=destination{1,1};
    if ~isequal(get(handles.edit_path_technology,'String'),destination)
        copyfile(get(handles.edit_path_technology,'String'),destination,'f');
        %Bloc permettant de copier le fichier .mdl
        path_mld=get(handles.edit_path_technology,'String');
        path_mld=path_mld(1:end-3);
        path_mld=[path_mld,'mdl'];
        destination=destination(1:end-3);
        destination=[destination,'mdl'];
        assignin('base','path_mld',path_mld);
        if exist(path_mld, 'file') ~= 0
            copyfile(path_mld,destination,'f'); 
        end
    end
    
    model=getappdata(0,'current_models')';
    model=model{get(handles.popup_bipolar,'Value')};
end

%-----Data update-----%
Add_Nodes(D);
Add_Nodes(G);
Add_Nodes(S);
data_bipolar=cell(0,1);
data_bipolar{end+1,1}='JFET';
data_bipolar{end+1,1}=['J',name];
data_bipolar{end+1,1}=D;
data_bipolar{end+1,1}=G;
data_bipolar{end+1,1}=S;
data_bipolar{end+1,1}=model;
data=getappdata(0,'data');
data{end+1,1}=data_bipolar;
setappdata(0,'data',data);
set(handles.popup_node1_element,'String',data{1,1});
set(handles.popup_node2_element,'String',data{1,1});
set(handles.popup_node_netlist,'String',data{1,1});

liste=get(handles.listbox_all_lines,'String');
%Import du nom de la techno et ecriture dans le fichier
if ~isempty(model)&&getappdata(0,'import_techno_already_done')==0;
    liste{end+1,1} = '';
    liste{end+1,1} = '*Import libraries';
    liste{end+1,1} = '';
    liste{end+1,1} = '.prot';
    liste{end+1,1} = ['.LIB ','./',foo{1,1},' ',getappdata(0,'quelle_techno')];
    liste{end+1,1} = '.unprot';
    liste{end+1,1} = '';
    setappdata(0,'import_techno_already_done',1);
end
liste{end+1,1}=['J',name,' ',D,' ',G,' ',S,' ',model];
set(handles.listbox_all_lines,'String',liste);
set(handles.edit_D_JFET,'String','');
set(handles.edit_G_JFET,'String','');
set(handles.edit_S_JFET,'String','');
set(handles.edit_name_JFET,'String','');
set(handles.popup_JFET,'Value',1);

%-----Affichage graphique-----%
        CalculCoordonates(handles);

% --- Executes on button press in push_add_MOSFET.
function push_add_MOSFET_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_MOSFET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=get(handles.edit_name_MOSFET,'String');
if isempty(name)
    name=inputdlg('Enter name of MOSFET transistor');
    name=name{1,1};
end
D=get(handles.edit_D_MOSFET,'String');
if isempty(D)
    D=inputdlg('Enter name of node connected to D');
    D=D{1,1};
end
G=get(handles.edit_G_MOSFET,'String');
if isempty(G)
    G=inputdlg('Enter name of node connected to G');
    G=G{1,1};
end
S=get(handles.edit_S_MOSFET,'String');
if isempty(S)
    S=inputdlg('Enter name of node connected to S');
    S=S{1,1}; 
end
l=get(handles.edit_l_MOSFET,'String');
if isempty(l)
    l=inputdlg('Enter length of MOSFET');
    l=l{1,1}; 
end
w=get(handles.edit_w_MOSFET,'String');
if isempty(w)
    w=inputdlg('Enter width of MOSFET');
    w=w{1,1}; 
end
if ~isempty(get(handles.edit_B_MOSFET,'String'))
    Add_Nodes(get(handles.edit_B_MOSFET,'String'));
end
model='';
if ~isempty(get(handles.edit_path_technology,'String'))
    %Copie du fichier .lib
    foo=strsplit(get(handles.edit_path_technology,'String'),'\');
    foo=foo(end);
    destination=strcat(getappdata(0,'project_directory'),'\',foo);
    destination=destination{1,1};
    if ~isequal(get(handles.edit_path_technology,'String'),destination)
        copyfile(get(handles.edit_path_technology,'String'),destination,'f');
        %Bloc permettant de copier le fichier .mdl
        path_mld=get(handles.edit_path_technology,'String');
        path_mld=path_mld(1:end-3);
        path_mld=[path_mld,'mdl'];
        destination=destination(1:end-3);
        destination=[destination,'mdl'];
        assignin('base','path_mld',path_mld);
        if exist(path_mld, 'file') ~= 0
            copyfile(path_mld,destination,'f'); 
        end
    end
    
    model=getappdata(0,'current_models')';
    model=model{get(handles.popup_MOSFET,'Value')};
end

%-----Data update-----%
Add_Nodes(D);
Add_Nodes(G);
Add_Nodes(S);
data_bipolar=cell(0,1);
data_bipolar{end+1,1}='MOSFET';
data_bipolar{end+1,1}=['M',name];
data_bipolar{end+1,1}=D;
data_bipolar{end+1,1}=G;
data_bipolar{end+1,1}=S;
if ~isempty(get(handles.edit_B_MOSFET,'String'))
    data_bipolar{end+1,1}=get(handles.edit_B_MOSFET,'String');
    S=[S,' ',get(handles.edit_B_MOSFET,'String')];
else
    data_bipolar{end+1,1}='false';
end
data_bipolar{end+1,1}=model;
data=getappdata(0,'data');
data{end+1,1}=data_bipolar;
setappdata(0,'data',data);
set(handles.popup_node1_element,'String',data{1,1});
set(handles.popup_node2_element,'String',data{1,1});
set(handles.popup_node_netlist,'String',data{1,1});
liste=get(handles.listbox_all_lines,'String');

%Import du nom de la techno et ecriture dans le fichier
if ~isempty(model)&&getappdata(0,'import_techno_already_done')==0;
    liste{end+1,1} = '';
    liste{end+1,1} = '*Import libraries';
    liste{end+1,1} = '';
    liste{end+1,1} = '.prot';
    liste{end+1,1} = ['.LIB ','./',foo{1,1},' ',getappdata(0,'quelle_techno')];
    liste{end+1,1} = '.unprot';
    liste{end+1,1} = '';
    setappdata(0,'import_techno_already_done',1);
end
a=['M',name,' ',D,' ',G,' ',S,' ',model,' ','l=',l,' ','w=',w];
if ~isempty(get(handles.edit_m,'String'))
    a=[a,' ','M=',get(handles.edit_m,'String')];
end
liste{end+1,1}=a;
set(handles.listbox_all_lines,'String',liste);
set(handles.edit_D_MOSFET,'String','');
set(handles.edit_G_MOSFET,'String','');
set(handles.edit_S_MOSFET,'String','');
set(handles.edit_B_MOSFET,'String','');
set(handles.edit_name_MOSFET,'String','');
set(handles.edit_l_MOSFET,'String','');
set(handles.edit_w_MOSFET,'String','');
set(handles.edit_m,'String','');
set(handles.popup_MOSFET,'Value',1);

%-----Affichage graphique-----%
        CalculCoordonates(handles);

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

function Reset(handles)
set(handles.listbox_all_lines,'String',{'******************'});
set(handles.listbox_all_lines,'Value',1);
% set(handles.popup_node2_element,'String','');
% set(handles.popup_node1_element,'String','');
% set(handles.popup_node_netlist,'String','');
Init(handles);
setappdata(0,'type_circuit','sub');
%set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'off')
%set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'on')
set(handles.Main_circuit_Checkbox,'Value',0);
set(handles.Subcircuit_Checkbox,'Value',1);
set(handles.edit_name_circuit,'enable','off');
set(handles.text_main_circuit,'enable','off');
set(handles.push_preset_sp_file,'enable','off');
a=get(handles.popup_add_netlist,'String');
display(a);
[n,m]=size(a);
if n>1
    set(findall(handles.panel_implement_sub, '-property', 'enable'), 'enable', 'on')
end
set(findall(handles.panel_create_sub, '-property', 'enable'), 'enable', 'on')
%CalculCoordonates(handles);


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
