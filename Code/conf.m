function varargout = conf(varargin)
% CONF MATLAB code for conf.fig
%      CONF, by itself, creates a new CONF or raises the existing
%      singleton*.
%
%      H = CONF returns the handle to a new CONF or the handle to
%      the existing singleton*.
%
%      CONF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONF.M with the given input arguments.
%
%      CONF('Property','Value',...) creates a new CONF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before conf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to conf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help conf

% Last Modified by GUIDE v2.5 22-Aug-2018 15:17:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @conf_OpeningFcn, ...
                   'gui_OutputFcn',  @conf_OutputFcn, ...
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


% --- Executes just before conf is made visible.
function conf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to conf (see VARARGIN)

% Choose default command line output for conf
handles.output = hObject;
        
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes conf wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = conf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function triang_max_Callback(hObject, eventdata, handles)
% hObject    handle to triang_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global triang_max
triang_max = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function triang_max_CreateFcn(hObject, eventdata, handles)
%triang_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_mode_Callback(hObject, eventdata, handles)
% hObject    handle to triang_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global triang_mode
triang_mode = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of triang_mode as text
%        str2double(get(hObject,'String')) returns contents of triang_mode as a double


% --- Executes during object creation, after setting all properties.
function triang_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to triang_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function triang_min_Callback(hObject, eventdata, handles)
% hObject    handle to triang_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global triang_min
triang_min = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of triang_min as text
%        str2double(get(hObject,'String')) returns contents of triang_min as a double


% --- Executes during object creation, after setting all properties.
function triang_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to triang_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poiss_mean_Callback(hObject, eventdata, handles)
% hObject    handle to poiss_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global poiss_mean
poiss_mean = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of poiss_mean as text
%        str2double(get(hObject,'String')) returns contents of poiss_mean as a double


% --- Executes during object creation, after setting all properties.
function poiss_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poiss_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function unif_max_Callback(hObject, eventdata, handles)
% hObject    handle to unif_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global unif_max
unif_max = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of unif_max as text
%        str2double(get(hObject,'String')) returns contents of unif_max as a double


% --- Executes during object creation, after setting all properties.
function unif_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unif_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function unif_min_Callback(hObject, eventdata, handles)
% hObject    handle to unif_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global unif_min
unif_min = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of unif_min as text
%        str2double(get(hObject,'String')) returns contents of unif_min as a double


% --- Executes during object creation, after setting all properties.
function unif_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unif_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_changes.
function save_changes_Callback(hObject, eventdata, handles)
% hObject    handle to save_changes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global triang_max triang_min triang_mode poiss_mean unif_max unif_min line_speed dist_choice
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
out{2}{strcmp('dist_choice',out{1})} = sprintf('%2.1f',dist_choice);
out{2}{strcmp('poisson_mean',out{1})} = sprintf('%2.1f',poiss_mean);
out{2}{strcmp('uniform_max',out{1})} = sprintf('%2.1f',unif_max);
out{2}{strcmp('uniform_min',out{1})} = sprintf('%2.1f',unif_min);
out{2}{strcmp('triangular_max',out{1})} = sprintf('%2.1f',triang_max);
out{2}{strcmp('triangular_min',out{1})} = sprintf('%2.1f',triang_min);
out{2}{strcmp('triangular_mode',out{1})} = sprintf('%2.1f',triang_mode);
out{2}{strcmp('line_speed',out{1})} = sprintf('%2.1f',line_speed);
C = [string(out{1}), string(out{2})];
format = '%s %s\n';
config2 = fopen('config2.txt','w');
for i=1:1:length(C)
    fprintf(config2,format,C(i,:));
end


% --- Executes during object creation, after setting all properties.
function save_changes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_changes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function line_speed_Callback(hObject, eventdata, handles)
global line_speed
line_speed = get(hObject,'Value');
% hObject    handle to line_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function line_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to line_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when selected object is changed in radiogroup.
function radiogroup_SelectionChangedFcn(hObject, eventdata, handles)
global dist_choice
dist_choice = str2double(get(hObject,'String'));
% hObject    handle to the selected object in radiogroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
