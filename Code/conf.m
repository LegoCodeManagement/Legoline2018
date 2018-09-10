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

% Last Modified by GUIDE v2.5 10-Sep-2018 15:20:54

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

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function triang_max_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
triang_max = out{2}{strcmp('triangular_max',out{1})};
handles.triang_max = triang_max;
set(hObject,'String',triang_max);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_max_Callback(hObject, eventdata, handles)
handles.triang_max = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function triang_mode_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
triang_mode = out{2}{strcmp('triangular_mode',out{1})};
handles.triang_mode = triang_mode;
set(hObject,'String',triang_mode);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_mode_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.triang_mode = str2double(get(hObject,'String'));
guidata(hObject,handles);
%        str2double(get(hObject,'String')) returns contents of triang_mode as a double

% --- Executes during object creation, after setting all properties.
function triang_min_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
triang_min = out{2}{strcmp('triangular_min',out{1})};
handles.triang_min = triang_min;
set(hObject,'String',triang_min);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_min_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.triang_min = str2double(get(hObject,'String'));
guidata(hObject,handles);
%        str2double(get(hObject,'String')) returns contents of triang_min as a double

% --- Executes during object creation, after setting all properties.
function poiss_mean_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
poiss_mean = out{2}{strcmp('poisson_mean',out{1})};
handles.poiss_mean = poiss_mean;
set(hObject,'String',poiss_mean);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function poiss_mean_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.poiss_mean = str2double(get(hObject,'String'));
guidata(hObject,handles);

%        str2double(get(hObject,'String')) returns contents of poiss_mean as a double



% --- Executes during object creation, after setting all properties.
function unif_max_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
unif_max = out{2}{strcmp('uniform_max',out{1})};
handles.unif_max = unif_max;
set(hObject,'String',unif_max);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function unif_max_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.unif_max = str2double(get(hObject,'String'));
guidata(hObject,handles);
%        str2double(get(hObject,'String')) returns contents of unif_max as a double



% --- Executes during object creation, after setting all properties.
function unif_min_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
unif_min = out{2}{strcmp('uniform_min',out{1})};
handles.unif_min = unif_min;
set(hObject,'String',unif_min);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function unif_min_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.unif_min = str2double(get(hObject,'String'));
guidata(hObject,handles);
%        str2double(get(hObject,'String')) returns contents of unif_min as a double

% --- Executes on button press in save_changes.
function save_changes_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
guidata(hObject,handles);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
out{2}{strcmp('line_speed',out{1})} = num2str(handles.line_speed);
out{2}{strcmp('Mthreshold',out{1})} = num2str(handles.m_threshold);
out{2}{strcmp('Uthreshold',out{1})} = num2str(handles.u_threshold);
out{2}{strcmp('Fthreshold',out{1})} = num2str(handles.f_threshold);
out{2}{strcmp('Tthreshold',out{1})} = num2str(handles.t_threshold);
out{2}{strcmp('uniform_min',out{1})} = num2str(handles.unif_min);
out{2}{strcmp('uniform_max',out{1})} = num2str(handles.unif_max);
out{2}{strcmp('triangular_min',out{1})} = num2str(handles.triang_min);
out{2}{strcmp('triangular_mode',out{1})} = num2str(handles.triang_mode);
out{2}{strcmp('triangular_max',out{1})} = num2str(handles.triang_max);
out{2}{strcmp('triangular_mode',out{1})} = num2str(handles.triang_mode);
out{2}{strcmp('poisson_mean',out{1})} = num2str(handles.poiss_mean);
out{2}{strcmp('buffer_size',out{1})} = num2str(handles.buffer_size);
C1 = out{1};
C2 = out{2};

%format = '%s %s\n';
config2 = fopen('config.txt','w');
for i=1:1:length(C1)
    line = [char(C1(i)),' ',char(C2(i))];
    fprintf(config2,'%s\r\n',line);
end
fclose(config2);

% --- Executes during object creation, after setting all properties.
function save_changes_CreateFcn(hObject, eventdata, handles)


% --- Executes on slider movement.
function line_speed_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
line_speed = round(get(hObject,'Value'));
handles.line_speed = line_speed;
guidata(hObject,handles);

%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function line_speed_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
line_speed = str2double(out{2}{strcmp('line_speed',out{1})});
handles.line_speed = line_speed;
set(hObject,'Value',line_speed);
guidata(hObject,handles);

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function uthreshold_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.u_threshold = str2double(get(hObject,'String'));
guidata(hObject,handles);
%        str2double(get(hObject,'String')) returns contents of uthreshold as a double


% --- Executes during object creation, after setting all properties.
function uthreshold_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
u_threshold = out{2}{strcmp('Uthreshold',out{1})};
handles.u_threshold = u_threshold;
set(hObject,'String',u_threshold);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_threshold_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.t_threshold = str2double(get(hObject,'String'));
guidata(hObject,handles);
%        str2double(get(hObject,'String')) returns contents of t_threshold as a double


% --- Executes during object creation, after setting all properties.
function t_threshold_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
t_threshold = out{2}{strcmp('Tthreshold',out{1})};
handles.t_threshold = t_threshold;
set(hObject,'String',t_threshold);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f_threshold_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.f_threshold = str2double(get(hObject,'String'));
guidata(hObject,handles);

%        str2double(get(hObject,'String')) returns contents of f_threshold as a double


% --- Executes during object creation, after setting all properties.
function f_threshold_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
f_threshold = out{2}{strcmp('Fthreshold',out{1})};
handles.f_threshold = f_threshold;
set(hObject,'String',f_threshold);
guidata(hObject,handles);

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m_threshold_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
m_threshold = str2double(get(hObject,'String'));
handles.m_threshold = m_threshold;
guidata(hObject,handles);

%        str2double(get(hObject,'String')) returns contents of m_threshold as a double


% --- Executes during object creation, after setting all properties.
function m_threshold_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
m_threshold = out{2}{strcmp('Mthreshold',out{1})};
handles.m_threshold = m_threshold;
set(hObject,'String',m_threshold);
guidata(hObject,handles);
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function radio_poiss_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
if str2double(out{2}{strcmp('dist_choice',out{1})}) == 1
    set(hObject,'Value',1)
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function radio_triang_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
if str2double(out{2}{strcmp('dist_choice',out{1})}) == 2
    set(hObject,'Value',1)
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function radio_unif_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
if str2double(out{2}{strcmp('dist_choice',out{1})}) == 3
    set(hObject,'Value',1)
end
guidata(hObject,handles);

% --- Executes when selected object is changed in radiogroup.
function radiogroup_SelectionChangedFcn(hObject, eventdata, handles)
handles = guidata(hObject);
dist_choice = str2double(get(hObject,'String'));
handles.dist_choice = dist_choice;
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'Global_Control']);
!notepad priority.txt
cd ..\
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function buffer_size_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
buffer_size = str2double(get(hObject,'String'));
handles.buffer_size = buffer_size;
guidata(hObject,handles);
% hObject    handle to buffer_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of buffer_size as text
%        str2double(get(hObject,'String')) returns contents of buffer_size as a double


% --- Executes during object creation, after setting all properties.
function buffer_size_CreateFcn(hObject, eventdata, handles)
handles = guidata(hObject);
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
buffer_size = out{2}{strcmp('buffer_size',out{1})};
handles.buffer_size = buffer_size;
set(hObject,'String',buffer_size);
guidata(hObject,handles);
% hObject    handle to buffer_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
