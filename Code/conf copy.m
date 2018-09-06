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

% Last Modified by GUIDE v2.5 05-Sep-2018 14:41:20

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

config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);

%triang_max (see GCBO)
set(hObject,'String',out{2}{strcmp('triangular_max',out{1})});
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_max_Callback(hObject, eventdata, handles)
global triang_max
triang_max = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function triang_mode_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('triangular_mode',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_mode_Callback(hObject, eventdata, handles)
global triang_mode
triang_mode = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of triang_mode as a double

% --- Executes during object creation, after setting all properties.
function triang_min_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('triangular_min',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function triang_min_Callback(hObject, eventdata, handles)
global triang_min
triang_min = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of triang_min as a double



% --- Executes during object creation, after setting all properties.
function poiss_mean_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('poisson_mean',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function poiss_mean_Callback(hObject, eventdata, handles)
global poiss_mean
poiss_mean = str2double(get(hObject,'String'));

%        str2double(get(hObject,'String')) returns contents of poiss_mean as a double



% --- Executes during object creation, after setting all properties.
function unif_max_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('uniform_max',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function unif_max_Callback(hObject, eventdata, handles)
global unif_max
unif_max = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of unif_max as a double



% --- Executes during object creation, after setting all properties.
function unif_min_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('uniform_min',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function unif_min_Callback(hObject, eventdata, handles)
global unif_min
unif_min = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of unif_min as a double

% --- Executes on button press in save_changes.
function save_changes_Callback(hObject, eventdata, handles)

global triang_max triang_min triang_mode poiss_mean unif_max unif_min line_speed dist_choice...
    u_threshold m_threshold t_threshold f_threshold
%{
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
out{2}{strcmp('dist_choice',out{1})} = sprintf('%2.1f',dist_choice);
out{2}{strcmp('poisson_mean',out{1})} = sprintf('%2.1f',poiss_mean);
out{2}{strcmp('uniform_max',out{1})} = sprintf('%2.1f',unif_max);
out{2}{strcmp('uniform_min',out{1})} = sprintf('%2.1f',unif_min);
out{2}{strcmp('triangular_max',out{1})} = sprintf('%2.1f',triang_max);
out{2}{strcmp('triangular_min',out{1})} = sprintf('%2.1f',triang_min);
out{2}{strcmp('triangular_mode',out{1})} = sprintf('%2.1f',triang_mode);
out{2}{strcmp('line_speed',out{1})} = sprintf('%2.1f',line_speed);
out{2}{strcmp('Uthreshold',out{1})} = sprintf('%2.1f',u_threshold);
out{2}{strcmp('Mthreshold',out{1})} = sprintf('%2.1f',m_threshold);
out{2}{strcmp('Tthreshold',out{1})} = sprintf('%2.1f',t_threshold);
out{2}{strcmp('Fthreshold',out{1})} = sprintf('%2.1f',f_threshold);

C = [string(out{1}), string(out{2})];
format = '%s %s\n';
config2 = fopen('config.txt','w');
for i=1:1:length(C)
    fprintf(config2,format,C(i,:));
end
fclose(config2);
%}

% --- Executes during object creation, after setting all properties.
function save_changes_CreateFcn(hObject, eventdata, handles)


% --- Executes on slider movement.
function line_speed_Callback(hObject, eventdata, handles)
global line_speed
line_speed = get(hObject,'Value');

%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function line_speed_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function uthreshold_Callback(hObject, eventdata, handles)
global u_threshold
u_threshold = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of uthreshold as a double
clc


% --- Executes during object creation, after setting all properties.
function uthreshold_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('Uthreshold',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_threshold_Callback(hObject, eventdata, handles)
global t_threshold
t_threshold = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of t_threshold as a double


% --- Executes during object creation, after setting all properties.
function t_threshold_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('Tthreshold',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function f_threshold_Callback(hObject, eventdata, handles)
global f_threshold
f_threshold = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of f_threshold as a double


% --- Executes during object creation, after setting all properties.
function f_threshold_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('Fthreshold',out{1})});

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m_threshold_Callback(hObject, eventdata, handles)
global m_threshold
m_threshold = str2double(get(hObject,'String'));
%        str2double(get(hObject,'String')) returns contents of m_threshold as a double


% --- Executes during object creation, after setting all properties.
function m_threshold_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
set(hObject,'String',out{2}{strcmp('Mthreshold',out{1})});

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

% --- Executes during object creation, after setting all properties.
function radio_triang_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
if str2double(out{2}{strcmp('dist_choice',out{1})}) == 2
    set(hObject,'Value',1)
end

% --- Executes during object creation, after setting all properties.
function radio_unif_CreateFcn(hObject, eventdata, handles)
config  = fopen('config.txt','rt');
out 	= textscan(config, '%s %s');
fclose(config);
if str2double(out{2}{strcmp('dist_choice',out{1})}) == 3
    set(hObject,'Value',1)
end

% --- Executes when selected object is changed in radiogroup.
function radiogroup_SelectionChangedFcn(hObject, eventdata, handles)
global dist_choice
dist_choice = str2double(get(hObject,'String'));
