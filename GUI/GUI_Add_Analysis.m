function varargout = GUI_Add_Analysis(varargin)
% GUI_ADD_ANALYSIS MATLAB code for GUI_Add_Analysis.fig
%      GUI_ADD_ANALYSIS, by itself, creates a new GUI_ADD_ANALYSIS or raises the existing
%      singleton*.
%
%      H = GUI_ADD_ANALYSIS returns the handle to a new GUI_ADD_ANALYSIS or the handle to
%      the existing singleton*.
%
%      GUI_ADD_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ADD_ANALYSIS.M with the given input arguments.
%
%      GUI_ADD_ANALYSIS('Property','Value',...) creates a new GUI_ADD_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Add_Analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Add_Analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Add_Analysis

% Last Modified by GUIDE v2.5 13-Mar-2017 15:44:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Add_Analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Add_Analysis_OutputFcn, ...
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


% --- Executes just before GUI_Add_Analysis is made visible.
function GUI_Add_Analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Add_Analysis (see VARARGIN)

% Choose default command line output for GUI_Add_Analysis
handles.output = hObject;

%We put the number of the page inside appdata
setappdata(0,'page_number',1);
% Update handles structure
guidata(hObject, handles);
Create_panel(handles);

% UIWAIT makes GUI_Add_Analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Add_Analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_cancel.
function push_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to push_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_Add_Analysis());
GUI_Parent();

% --- Executes on button press in push_generate.
function push_generate_Callback(hObject, eventdata, handles)
% hObject    handle to push_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list_lines=get(handles.listbox1,'String');
[taille,~]=size(list_lines);
fid=fopen(get(handles.edit_path_file,'String'),'wt');
for i=1:taille
   fprintf(fid, strcat(list_lines{i,1},'\n')); 
end
fprintf(fid,'.end');
fclose(fid);
close(GUI_Add_Analysis());
GUI_Parent();

% --- Executes on button press in push_delete.
function push_delete_Callback(hObject, eventdata, handles)
% hObject    handle to push_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list_lines=get(handles.listbox1,'String');
if ~isempty(lits_lines)
    list_lines(get(handles.listbox1,'Value'),:)=[];
    set(handles.listbox1,'String',list_lines);
    [taille,~]=size(list_lines);
    if(get(handles.listbox1,'Value')>taille)
        set(handles.listbox1,'Value',1);
    end
end


% --- Executes on selection change in pop_choose_analysis.
function pop_choose_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pop_choose_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_choose_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_choose_analysis
set(handles.check_mode,'Value',0);
%set(handles.static_help,'String',sprintf(DisplayHelp('choose_analysis',get(hObject,'Value'))));
Create_panel(handles);

% --- Executes during object creation, after setting all properties.
function pop_choose_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_choose_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in check_mode.
function check_mode_Callback(hObject, eventdata, handles)
% hObject    handle to check_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_mode
Create_panel(handles);

% --- Executes on button press in push_add_analysis.
function push_add_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.pop_choose_analysis,'String'));
analysis=contents{get(handles.pop_choose_analysis,'Value')};
if get(handles.check_mode,'Value')==0
    %Simple Mode
    if DisplayError(handles)==0
        if isequal(analysis,'.AC')
            liste_lignes=get(handles.listbox1,'String');
            ligne='';
            ligne=[ligne,get(handles.editText(1),'String'),' ',...
                get(handles.editText(2),'String'),' ',...
                get(handles.editText(3),'String'),' ',...
                get(handles.editText(4),'String'),' ','ac'];
            liste_lignes{end+1,1}=ligne;
            set(handles.listbox1,'String',liste_lignes);
            contents = cellstr(get(handles.editText(5),'String'));
            type=contents{get(handles.editText(5),'Value')};
            ligne=[analysis,' ',type,' ',get(handles.editText(6),'String'),' ',get(handles.editText(7),'String'),' ',get(handles.editText(8),'String')];
            if ~isempty(get(handles.edit_full_options,'String'))
                ligne=[ligne,' ',get(handles.edit_full_options,'String')];
                set(handles.edit_full_options,'String','');
            end
            for i=1:8
                set(handles.editText(i),'String','')
            end
        elseif isequal(analysis,'.LSTB')
            ligne=[analysis,' '];
            %Simple mode ==> take all the value of edit text
            [~,taille]=size(handles.editText);
            
            contents = cellstr(get(handles.editText(1),'String'));
            type=contents{get(handles.editText(1),'Value')};
            ligne=[ligne,'mode=',type,' '];
            set(handles.editText(1),'Value',1);
            
            ligne=[ligne,'vsource=',get(handles.editText(2),'String'),' '];
            set(handles.editText(2),'String','');
             
            if ~isequal(type,'SINGLE')
            ligne=[ligne,',',get(handles.editText(3),'String'),' '];
            set(handles.editText(3),'String','');
            end

            if ~isempty(get(handles.edit_full_options,'String'))
                ligne=[ligne,' ',get(handles.edit_full_options,'String')];
                set(handles.edit_full_options,'String','');
            end
        elseif isequal(analysis,'.HB')
            ligne=[analysis,' '];
            %Simple mode ==> take all the value of edit text
            [~,taille]=size(handles.editText);
            contents = cellstr(get(handles.editText(4),'String'));
            type=contents{get(handles.editText(4),'Value')};
            ligne=[ligne,...
                get(handles.editText(1),'String'),' ',...
              	get(handles.editText(2),'String'),' ',...
               	'sweep',' ',...
                get(handles.editText(3),'String'),' ',...
                type,' ',...
                get(handles.editText(5),'String'),' ',...
                get(handles.editText(6),'String'),' ',...
                get(handles.editText(7),'String'),' '];

            if ~isempty(get(handles.edit_full_options,'String'))
                ligne=[ligne,' ',get(handles.edit_full_options,'String')];
                set(handles.edit_full_options,'String','');
            end
            for i=1:3
                set(handles.editText(i),'String','')
            end
            for i=5:7
                set(handles.editText(i),'String','')
            end
        elseif isequal(analysis,'.HBNOISE')
            ligne=[analysis,' '];
            %Simple mode ==> take all the value of edit text
            [~,taille]=size(handles.editText);
            contents = cellstr(get(handles.editText(3),'String'));
            type=contents{get(handles.editText(3),'Value')};
            ligne=[ligne,...
                get(handles.editText(1),'String'),' ',...
              	get(handles.editText(2),'String'),' ',...
                type,' ',...
                get(handles.editText(4),'String'),' ',...
                get(handles.editText(5),'String'),' ',...
                get(handles.editText(6),'String'),' '];

            if ~isempty(get(handles.edit_full_options,'String'))
                ligne=[ligne,' ',get(handles.edit_full_options,'String')];
                set(handles.edit_full_options,'String','');
            end
            for i=1:2
                set(handles.editText(i),'String','')
            end
            for i=4:6
                set(handles.editText(i),'String','')
            end
        else
            ligne=[analysis,' '];
            %Simple mode ==> take all the value of edit text
            [~,taille]=size(handles.editText);
            for i=1:taille
                if isequal(get(handles.editText(i),'Style'),'popupmenu')
                    contents = cellstr(get(handles.editText(i),'String'));
                    type=contents{get(handles.editText(i),'Value')};
                    ligne=[ligne,type,' '];
                    set(handles.editText(i),'Value',1);
                else
                    ligne=[ligne,get(handles.editText(i),'String'),' '];
                    set(handles.editText(i),'String','');
                end
            end
            if ~isempty(get(handles.edit_full_options,'String'))
                ligne=[ligne,' ',get(handles.edit_full_options,'String')];
                set(handles.edit_full_options,'String','');
            end
        end
        liste_lignes=get(handles.listbox1,'String');
        liste_lignes{end+1,1}=ligne;
        set(handles.listbox1,'String',liste_lignes); 
    end
else
    %Advanced Mode
    if isempty(get(handles.edit_advanced,'String'))
        errordlg('Missing command');
    elseif isempty(strfind(get(handles.edit_advanced,'String'),analysis))
        errordlg(['Invalid command, missing:',' ',analysis]);
    else
        ligne=get(handles.edit_advanced,'String');
        if ~isempty(get(handles.edit_full_options,'String'))
            ligne=[ligne,' ',get(handles.edit_full_options,'String')];
            set(handles.edit_full_options,'String','');
        end
        liste_lignes=get(handles.listbox1,'String');
        liste_lignes{end+1,1}=ligne;
        set(handles.listbox1,'String',liste_lignes);
        set(handles.edit_full_options,'String','');
        set(handles.edit_advanced,'String','');
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
[name_file,path] = uigetfile(strcat('C:\Users\',getenv('USERNAME'),'\Documents\/*.sp'));
if name_file~=0
    set(handles.edit_path_file,'string',strcat(path,name_file));
    setappdata(0,'path_file',strcat(path,name_file));
    %On extrait les lignes en réutilisant une fonction d'une autre fenetre
    [~,tlines]=SourceExtractor(strcat(path,name_file));
    set(handles.listbox1,'String',tlines);
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


% --- Executes on selection change in popup_options.
function popup_options_Callback(hObject, eventdata, handles)
% hObject    handle to popup_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_options
set(handles.static_help,'String',DisplayHelp('option_analysis',get(hObject,'Value')-1));

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


% --- Executes on button press in push_add_option.
function push_add_option_Callback(hObject, eventdata, handles)
% hObject    handle to push_add_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.popup_options,'String'));
selection = contents{get(handles.popup_options,'Value')};
ligne_option=get(handles.edit_option,'String');
ligne_option_complete=get(handles.edit_full_options,'String');
if isequal(selection,'-')
    errordlg('Missing type of option');
else
    ligne_option_complete=[ligne_option_complete,' ',selection];
    if isempty(ligne_option)&&~isempty(strfind(selection,'='))
        errordlg('Missing value of option');
    else
        ligne_option_complete=[ligne_option_complete,' ',ligne_option];
    end
    set(handles.edit_full_options,'String',ligne_option_complete);
end

function edit_full_options_Callback(hObject, eventdata, handles)
% hObject    handle to edit_full_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_full_options as text
%        str2double(get(hObject,'String')) returns contents of edit_full_options as a double


% --- Executes during object creation, after setting all properties.
function edit_full_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_full_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Create_panel(handles)

analysis_list=get(handles.pop_choose_analysis,'String');
analysis=analysis_list{get(handles.pop_choose_analysis,'Value')};
advanced_mode=get(handles.check_mode,'Value');
switch analysis
    case '.AC'
        switch advanced_mode
            case 0
               setappdata(0,'page_number',348);
               handles = DisplaySimpleMode(handles,'.AC',@Pop_simple);
            case 1
               handles = DisplayAdvancedMode(handles,'.AC',@Pop_advanced); 
        end
    case '.DC'
        switch advanced_mode
            case 0
                setappdata(0,'page_number',335);
                handles = DisplaySimpleMode(handles,'.DC',@Pop_simple);
            case 1
                handles= DisplayAdvancedMode(handles,'.DC',@Pop_advanced);
        end
    case'.TRAN'
        switch advanced_mode
            case 0
                setappdata(0,'page_number',296);
                handles = DisplaySimpleMode(handles,'.TRAN',@Pop_simple);
                
            case 1
                handles = DisplayAdvancedMode(handles,'.TRAN',@Pop_advanced);
        end
    case '.LSTB'
        switch advanced_mode
            case 0
               setappdata(0,'page_number',348);
               handles = DisplaySimpleMode(handles,'.LSTB',@Pop_simple);
            case 1
               handles = DisplayAdvancedMode(handles,'.LSTB',@Pop_advanced); 
        end
    case '.NOISE'
        switch advanced_mode
            case 0
               setappdata(0,'page_number',348);
               handles = DisplaySimpleMode(handles,'.NOISE',@Pop_simple);
            case 1
               handles = DisplayAdvancedMode(handles,'.NOISE',@Pop_advanced); 
        end
	case '.HB'
        switch advanced_mode
            case 0
               setappdata(0,'page_number',348);
               handles = DisplaySimpleMode(handles,'.HB',@Pop_simple);
            case 1
               handles = DisplayAdvancedMode(handles,'.HB',@Pop_advanced); 
        end
    case '.HBNOISE'
        switch advanced_mode
            case 0
               setappdata(0,'page_number',348);
               handles = DisplaySimpleMode(handles,'.HBNOISE',@Pop_simple);
            case 1
               handles = DisplayAdvancedMode(handles,'.HBNOISE',@Pop_advanced); 
        end
end
guidata(handles.panel_principal,handles);

function Pop_advanced(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.static_help,'String',DisplayHelp('advanced_analysis',get(hObject,'Value')));
HelpPDF(get(handles.pop_choose_analysis,'Value'));

function HelpPDF(type_analysis)
switch type_analysis
    case 1
        setappdata(0,'page_number',350);
    case 2
        setappdata(0,'page_number',337);
    case 3
        setappdata(0,'page_number',298);
end
% --- Executes on button press in push_help.
function push_help_Callback(hObject, eventdata, handles)
% hObject    handle to push_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%system(['C:\"Program Files (x86)"\Adobe\"Reader 11.0"\Reader\AcroRd32.exe /A page=',num2str(getappdata(0,'page_number')),' "C:\Users\Louis\Documents\COURS\En cours\Tutorial\docs\hspice.pdf"']);



system([getappdata(0,'path_Adobe'),' /A page=',num2str(getappdata(0,'page_number')),' "',getappdata(0,'current_directory_project'),'PDF\hspice.pdf"']);

function Pop_simple(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

get(handles.editText(3))

if get(hObject,'Value')~=1
    set(handles.editText(3),'enable','on');
else
    set(handles.editText(3),'enable','off');
end


% --- Executes on button press in push_back.
function push_back_Callback(hObject, eventdata, handles)
% hObject    handle to push_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'file_press_back',get(handles.edit_path_file,'String'));
close(GUI_Add_Analysis());
GUI_create_sp_file();


