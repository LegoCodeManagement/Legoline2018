function Legoline_User_Interface

global Rootpath
close all; % Close any open figures.

% create the figure window and set some properties to make it look less
% like a matlab figure and allow us to add custom menus. 
Legoline_GUI=figure(101);
set(Legoline_GUI,'Visible','off','Numbertitle','off','MenuBar','none','color','m','Position',[360,500,800,600]);

% setup the colour matrix for buttons and the background image 
colour_matrix =[0.8125,0.6328,0.5586,0.4023,0.6992;0.9258,0.7266,0.6562,0.5469,0.7070;0.8672,0.6875,0.6055,0.5430,0.5598]';
background_axes_handle = axes('units','normalized','position',[0 0 1 1]);
uistack(background_axes_handle,'bottom');
I=imread('Legoline.JPEG');
hi = imagesc(I);
set(background_axes_handle,'handlevisibility','off','visible','off')

% Set up pull down menu for the running comamnds initialise start and stop 
runcommandmenu = uimenu('label','Run Commands ');
uimenu(runcommandmenu,'label','Single Run','Enable','off');
uimenu(runcommandmenu,'label','Initialise','call','initialise','separator','on');
uimenu(runcommandmenu,'label','Start','call','Start');
uimenu(runcommandmenu,'label','Finish','call','Finish');
uimenu(runcommandmenu,'label','Run Experiments','Enable','off','separator','on','Enable','off');
uimenu(runcommandmenu,'label','Buffer Size Experiment','call',@Pallet_Buffer_Experiment_Callback,'separator','on','Enable','off' );
uimenu(runcommandmenu,'label','Feed Rate Experiment','call',@Feed_Rate_Experiment_Callback,'Enable','off');
uimenu(runcommandmenu,'label','Import Data','call','import_simiodata');
uimenu(runcommandmenu,'label','Run Graphing Tool','separator','on','call',{@Graphing_Tool_GUI_Function2},'Enable','off');
uimenu(runcommandmenu,'label','Run Status Monitor','separator','on','call','Run_Statedraw');
uimenu(runcommandmenu,'label','Stop Status Monitor','call',@stop_statedraw_callback);
uimenu(runcommandmenu,'label','Simulate Upstream Line','separator','on','call',@Generate_feed_data_callback);

% Configuration Menu and its sub items 
configmenu = uimenu('label','Configuration');
uimenu(configmenu,'label','Buffer and Feed','Callback',@getconfig);
uimenu(configmenu,'label','NXT MAC Data','Callback',@getconfig);
uimenu(configmenu,'label','Interactive Configuration Tool','Callback',@Data_Entry_Interface_Function);
uimenu(configmenu,'label','MAC Data Master','Callback',@getconfig,'Enable','off');


% Log File Menus, by calling the timer function early. 
resultmenu = uimenu(Legoline_GUI,'label','Data Logging');
logmenu = uimenu(Legoline_GUI,'label','Event Logs');
%Update_menus_main(0,0)
     
% Set Up Buttons to Do The Run Commands for a demonstration run. 
initbutton = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Initialise','tooltipstring','Press to Initialise the motors and clear any pallets from the line','BackgroundColor','y','ForegroundColor','k','units','normal','Position',[0.1,0.8,0.2,0.1], 'callback', @initButtonCallback);
startbutton = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Start','tooltipstring','Once Initialised Click Here to run the line','BackgroundColor','g','ForegroundColor','k','units','normal','Position',[0.1,0.5,0.2,0.1],'callback',@startButtonCallback);
finishbutton = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Finish','tooltipstring','Click here to stop the line and record all data from the run','BackgroundColor','r','ForegroundColor','k','units','normal','Position',[0.1,0.2,0.2,0.1],'callback', @finishButtonCallback);

% Function buttons for second cloumn, these generally run more complex
% experiments 

% old code fragment for a button which can display all event logs for
% complex error tracking. 
%event_button = uicontrol('Style','pushbutton','String','Display Event Logs','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','Position',[475,500,150,50],'Callback',{@display_logdata,6,0});

run_timed_button = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Timed Run','tooltipstring','Once Initialsied Click Here to run the line for a specified time','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','units','normal','Position',[0.4,0.8,0.2,0.1],'call',@Timed_Run);
run_feed_button = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Run Feed Experiment','tooltipstring','Click Here to Lauch the Configured Feed Rate Experiment','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','units','normal','Position',[0.4,0.5,0.2,0.1],'call',@Feed_Rate_Experiment_Callback,'Enable','off');
run_pallet_button = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Run Buffer Experiment','tooltipstring','Click Here to Lauch the Configured Buffer Size Experiment','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','units','normal','Position',[0.4,0.2,0.2,0.1],'call',@Pallet_Buffer_Experiment_Callback,'Enable','off');

% print the thrid column of dashboard buttons - these tend to show results
% files 
feed_button = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Display Feed Logs','tooltipstring','Click here to display the feed logs from all units from the last run','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','units','normal','Position',[0.7,0.8,0.2,0.1],'Callback',{@display_logdata,5,0});
results_button = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Display Results','tooltipstring','If an experiment mode run has just been completed click here to generate the results file for saving','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','units','normal','Position',[0.7,0.5,0.2,0.1],'Callback',{@display_logdata,10,0},'Enable','off');
graphing_button = uicontrol(Legoline_GUI ,'Style','pushbutton','String','Graphing Tool','tooltipstring','If an experiment mode run has just been completed click here to view the failure surface in 3D','BackgroundColor',colour_matrix(2,:),'ForegroundColor','k','units','normal','Position',[0.7,0.2,0.2,0.1],'Callback',{@Graphing_Tool_GUI_Function2},'Enable','off');


menuhandles = findall(Legoline_GUI,'type','uimenu');
set(menuhandles,'HandleVisibility','on');


% Initialize the GUI.
% Change units to normalized so components resize 
set([Legoline_GUI,initbutton,startbutton,finishbutton,feed_button,graphing_button,results_button,run_feed_button,run_pallet_button,run_timed_button],'Units','normalized');
% Assign the GUI a name to appear in the window title.
set(Legoline_GUI,'Name','Legoline')
% Move the GUI to the center of the screen.
movegui(Legoline_GUI,'center')
%start(menu_update_timer);
% Make the GUI visible.
set(Legoline_GUI,'Visible','on');%,'handlevisibility','callback','CloseRequestFcn',@shutdown_fcn);

% -- begin Nested Functions
    function initButtonCallback(src, evnt)
        currentDir = pwd;
        cd([Rootpath filesep 'Code']);
        !matlab  -nodesktop -minimize -nosplash -r Initialize&
        cd(currentDir);
    end
    function startButtonCallback(src, evnt)
        currentDir = pwd;
        cd([Rootpath filesep 'Code']);
        fileInit = memmapfile('InitializationStatus.txt', 'Writable', true, 'Format', 'int8');
        fileInit.Data(1) = 50;
        clear fileInit;
        cd(currentDir);
    end
    function finishButtonCallback(src, evnt)
        currentDir = pwd;
        cd([Rootpath filesep 'Code']);
        fileInit = memmapfile('InitializationStatus.txt', 'Writable', true, 'Format', 'int8');
        fileInit.Data(1) = 53;
        clear fileInit;
        cd(currentDir);
    end

%% Experiment Button Callback Functions. 

    function Feed_Rate_Experiment_Callback(src,evnt)
                % a simple function to offer a user confirm before starting
                % a lengthy experiment
                selection_feedrate = questdlg('Are You Ready To Run the Feed Rate Experiment?','Legoline Experiment Confimation','Yes','No','No'); 
                switch selection_feedrate, 
                    case 'Yes'
                        %Feed_Rate_Experiment
                    case 'No'
                    return 
                end
        
    end 

    function Pallet_Buffer_Experiment_Callback(src,evnt)
                % a simple function to offer a user confirm before starting
                % a lengthy experiment
                selection_palletrate = questdlg('Are You Ready To Run the Feed Line Buffer Size Experiment?','Legoline Experiment Confimation','Yes','No','No'); 
                switch selection_palletrate 
                    case 'Yes'
                        %Pallet_Buffer_Experiment
                    case 'No'
                    return 
                end
    end 
end