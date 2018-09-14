function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 06-Sep-2018 12:44:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

function initialise()
background_axes_handle = axes('units','normalized','position',[0 0 1 1]);
uistack(background_axes_handle,'bottom');
I=imread('legoline.jpg');
hi = imagesc(I);
set(background_axes_handle,'handlevisibility','off','visible','off')
global local_chosen
local_chosen = zeros(1,11);

global global_chosen
global_chosen = zeros(1,11);



% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.


% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);



% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in local_control.
function local_control_Callback(hObject, eventdata, handles)
cmd_local = {'!matlab  -nodesktop -minimize -nosplash -r Local_upstream&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_feed1&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_transfer1&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_mainline1&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_feed2&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_transfer2&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_mainline2&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_feed3&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_transfer3&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_mainline3&';...
'!matlab  -nodesktop -minimize -nosplash -r Local_splitter&';};

global local_chosen
cd([pwd,filesep,'Local_Control_test']);
!matlab  -nodesktop -nosplash -r master&
command = cmd_local(find(local_chosen));
for i = 1:1:length(command)
    eval(char(command(i)));
end
pause(0.5)
cd ..\

% --- Executes on button press in global_control.
function global_control_Callback(hObject, eventdata, handles)
cmd_global = {'!matlab  -nodesktop -minimize -nosplash -r Global_upstream&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_feed1&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_transfer1&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_mainline1&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_feed2&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_transfer2&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_mainline2&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_feed3&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_transfer3&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_mainline3&';...
'!matlab  -nodesktop -minimize -nosplash -r Global_splitter&';};
global global_chosen
cd([pwd,filesep,'Global_Control']);
!matlab  -nodesktop -nosplash -r master&
command = cmd_global(find(global_chosen));
for i = 1:1:length(command)
    eval(char(command(i)));
end
pause(0.5)
cd ..\

% --- Executes on button press in open_config_file.
function open_config_file_Callback(hObject, eventdata, handles)
!notepad config.txt

% --- Executes on button press in open_priority.
function open_priority_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'Global_Control']);
!notepad priority.txt
cd ..\

% --- Executes on button press in mainline_plot.
function mainline_plot_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'plots']);
!matlab  -nodesktop -nosplash -r LightSensorPlotMain
cd ..\

% --- Executes on button press in feed_transfer_plot.
function feed_transfer_plot_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'plots']);
!matlab  -nodesktop -nosplash -r LightSensorPlotFeedtransfer
cd ..\

% --- Executes on button press in splitter_plot.
function splitter_plot_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'plots']);
!matlab  -nodesktop -nosplash -r LightSensorPlotSplitter
cd ..\

% --- Executes on button press in transfer_arm_plot.
function transfer_arm_plot_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'plots']);
!matlab  -nodesktop -nosplash -r LightSensorPlotTransferArm

% --- Executes on button press in battery_check.
function battery_check_Callback(hObject, eventdata, handles)
cd([pwd,filesep,'plots']);
!matlab  -nodesktop -nosplash -r BatteryCheck
cd ..\

% --- Executes on button press in LU.
function LU_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(1) = get(hObject,'Value');

% --- Executes on button press in LF1.
function LF1_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(2) = get(hObject,'Value');

% --- Executes on button press in LT1.
function LT1_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(3) = get(hObject,'Value');

% --- Executes on button press in LM1.
function LM1_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(4) = get(hObject,'Value');

% --- Executes on button press in LF2.
function LF2_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(5) = get(hObject,'Value');

% --- Executes on button press in LT2.
function LT2_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(6) = get(hObject,'Value');

% --- Executes on button press in LM2.
function LM2_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(7) = get(hObject,'Value');

% --- Executes on button press in LF3.
function LF3_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(8) = get(hObject,'Value');

% --- Executes on button press in LT3.
function LT3_Callback(hObject, eventdata, handles)
global local_chosen;
local_chosen(9) = get(hObject,'Value');

% --- Executes on button press in LM3.
function LM3_Callback(hObject, eventdata, handles)
global local_chosen
local_chosen(10) = get(hObject,'Value');

% --- Executes on button press in LS.
function LS_Callback(hObject, eventdata, handles)
global local_chosen
local_chosen(11) = get(hObject,'Value');

% --- Executes on button press in GU.
function GU_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(1) = get(hObject,'Value');

% --- Executes on button press in GF1.
function GF1_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(2) = get(hObject,'Value');

% --- Executes on button press in GT1.
function GT1_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(3) = get(hObject,'Value');

% --- Executes on button press in GM1.
function GM1_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(4) = get(hObject,'Value');

% --- Executes on button press in GF2.
function GF2_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(5) = get(hObject,'Value');

% --- Executes on button press in GT2.
function GT2_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(6) = get(hObject,'Value');

% --- Executes on button press in GM2.
function GM2_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(7) = get(hObject,'Value');

% --- Executes on button press in GF3.
function GF3_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(8) = get(hObject,'Value');

% --- Executes on button press in GT3.
function GT3_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(9) = get(hObject,'Value');

% --- Executes on button press in GM3.
function GM3_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(10) = get(hObject,'Value');

% --- Executes on button press in GS.
function GS_Callback(hObject, eventdata, handles)
global global_chosen;
global_chosen(11) = get(hObject,'Value');

% --- Executes on button press in run_config_gui.
function run_config_gui_Callback(hObject, eventdata, handles)
run conf

% --- Executes on button press in open_errorlog.
function open_errorlog_Callback(hObject, eventdata, handles)
!notepad errorlog.txt

% --- Executes on button press in clear_errorlog.
function clear_errorlog_Callback(hObject, eventdata, handles)
fopen('errorlog.txt','w');


% --- Executes on button press in all_local.
function all_local_Callback(hObject, eventdata, handles)
global local_chosen
local_chosen = ones(1,11);
% hObject    handle to all_local (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all_local


% --- Executes on button press in all_global.
function all_global_Callback(hObject, eventdata, handles)
global global_chosen
global_chosen = ones(1,11);
% hObject    handle to all_global (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all_global
