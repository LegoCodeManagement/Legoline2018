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

% Last Modified by GUIDE v2.5 21-Aug-2018 16:05:50

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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure


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
% hObject    handle to figure



% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in local_control.
function local_control_Callback(hObject, eventdata, handles)
% hObject    handle to local_control (see GCBO)

global lu lm1 lf1 lt1 lm2 lf2 lt2 lm3 lf3 lt3 ls
cd([pwd,filesep,'Local_Control']);
!matlab  -nodesktop -nosplash -r master&
if lu == 1
    !matlab  -nodesktop -nosplash -r Local_upstream&
end
if lm1 == 1
    !matlab  -nodesktop -nosplash -r Local_mainline1&
end
if lf1 == 1
    !matlab  -nodesktop -nosplash -r Local_feed1&
end
if lt1 == 1
    !matlab  -nodesktop -nosplash -r Local_transfer1&
end
if lm2 == 1
    !matlab  -nodesktop -nosplash -r Local_mainline2&
end
if lf2 == 1
    !matlab  -nodesktop -nosplash -r Local_feed2&
end
if lt2 == 1
    !matlab  -nodesktop -nosplash -r Local_transfer2&
end
if lm3 == 1
    !matlab  -nodesktop -nosplash -r Local_mainline3&
end
if lf3 == 1
    !matlab  -nodesktop -nosplash -r Local_feed3&
end
if lt3 == 1
    !matlab  -nodesktop -nosplash -r Local_transfer3&
end
if ls == 1
    !matlab  -nodesktop -nosplash -r Local_splitter&
end

% --- Executes on button press in global_control.
function global_control_Callback(hObject, eventdata, handles)
% hObject    handle to global_control (see GCBO)

global gu gm1 gf1 gt1 gm2 gf2 gt2 gm3 gf3 gt3 gs
cd([pwd,filesep,'Global_Control']);
!matlab  -nodesktop -nosplash -r master&
if gu == 1
    !matlab  -nodesktop -nosplash -r Global_upstream&
end
if gm1 == 1
    !matlab  -nodesktop -nosplash -r Global_mainline1&
end
if gf1 == 1
    !matlab  -nodesktop -nosplash -r Global_feed1&
end
if gt1 == 1
    !matlab  -nodesktop -nosplash -r Global_transfer1&
end
if gm2 == 1
    !matlab  -nodesktop -nosplash -r Global_mainline2&
end
if gf2 == 1
    !matlab  -nodesktop -nosplash -r Global_feed2&
end
if gt2 == 1
    !matlab  -nodesktop -nosplash -r Global_transfer2&
end
if gm3 == 1
    !matlab  -nodesktop -nosplash -r Global_mainline3&
end
if gf3 == 1
    !matlab  -nodesktop -nosplash -r Global_feed3&
end
if gt3 == 1
    !matlab  -nodesktop -nosplash -r Global_transfer3&
end
if gs == 1
    !matlab  -nodesktop -nosplash -r Global_splitter&
end



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

% --- Executes on button press in LM1.
function LM1_Callback(hObject, eventdata, handles)
global lm1;
lm1 = get(hObject,'Value');


% --- Executes on button press in LU.
function LU_Callback(hObject, eventdata, handles)
global lu;
lu = get(hObject,'Value');


% --- Executes on button press in LT1.
function LT1_Callback(hObject, eventdata, handles)
global lt1;
lt1 = get(hObject,'Value');


% --- Executes on button press in LF1.
function LF1_Callback(hObject, eventdata, handles)
global lf1;
lf1 = get(hObject,'Value');


% --- Executes on button press in LF2.
function LF2_Callback(hObject, eventdata, handles)
global lf2;
lf2 = get(hObject,'Value');


% --- Executes on button press in LM2.
function LM2_Callback(hObject, eventdata, handles)
global lm2;
lm2 = get(hObject,'Value');


% --- Executes on button press in LM3.
function LM3_Callback(hObject, eventdata, handles)
global lm3
lm3 = get(hObject,'Value');


% --- Executes on button press in LT2.
function LT2_Callback(hObject, eventdata, handles)
global lt2;
lt2 = get(hObject,'Value');


% --- Executes on button press in LT3.
function LT3_Callback(hObject, eventdata, handles)
global lt3;
lt3 = get(hObject,'Value');


% --- Executes on button press in LF3.
function LF3_Callback(hObject, eventdata, handles)
global lf3;
lf3 = get(hObject,'Value');


% --- Executes on button press in LS.
function LS_Callback(hObject, eventdata, handles)
global ls;
ls = get(hObject,'Value');


% --- Executes on button press in GM1.
function GM1_Callback(hObject, eventdata, handles)
global gm1;
gm1 = get(hObject,'Value');


% --- Executes on button press in GU.
function GU_Callback(hObject, eventdata, handles)
global gu;
gu = get(hObject,'Value');


% --- Executes on button press in GT1.
function GT1_Callback(hObject, eventdata, handles)
global gt1;
gt1 = get(hObject,'Value');


% --- Executes on button press in GF1.
function GF1_Callback(hObject, eventdata, handles)
global gf1;
gf1 = get(hObject,'Value');


% --- Executes on button press in GF2.
function GF2_Callback(hObject, eventdata, handles)
global gf2;
gf2 = get(hObject,'Value');


% --- Executes on button press in GM2.
function GM2_Callback(hObject, eventdata, handles)
global gm2;
gm2 = get(hObject,'Value');


% --- Executes on button press in GM3.
function GM3_Callback(hObject, eventdata, handles)
global gm3;
gm3 = get(hObject,'Value');


% --- Executes on button press in GT2.
function GT2_Callback(hObject, eventdata, handles)
global gt2;
gt2 = get(hObject,'Value');


% --- Executes on button press in GT3.
function GT3_Callback(hObject, eventdata, handles)
global gt3;
gt3 = get(hObject,'Value');


% --- Executes on button press in GF3.
function GF3_Callback(hObject, eventdata, handles)
global gf3;
gf3 = get(hObject,'Value');


% --- Executes on button press in GS.
function GS_Callback(hObject, eventdata, handles)
global gs;
gs = get(hObject,'Value');


% --- Executes on button press in run_config_gui.
function run_config_gui_Callback(hObject, eventdata, handles)
run conf.m
% hObject    handle to run_config_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
