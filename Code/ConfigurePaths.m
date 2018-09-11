% FindRootPath.m - Script file to map out the file structure of the legoline folder for
% adding to the path, contains all data pointing to salient files which are
% read from/ written to and all of the requried path data for the legoline
% to run. 


% section to define paths to key control fiels such as stop and go, as well
% as files 

% declaration of certian variables as global for passing to the GUI,
% particularly files where it may wish to look for things 
global Rootpath
%{
global path2control
global path2feedlog
global path2eventlog
global path2palletexptoutputs
global path2feedrtexptoutputs
global path2userresults
global path2sensordata
%}

global path2config
global path2param
global path2init
global path2Junc1
global path2Junc2
global path2Junc3
global path2gui

Rootpath = pwd;
path2gui = [Rootpath filesep 'Code' filesep 'GUI' filesep];
path2config = [Rootpath filesep 'Code' filesep 'Configurations.txt'];
path2param = [Rootpath filesep 'Code' filesep 'Parameters.txt'];
path2init = [Rootpath filesep 'Code' filesep 'InitializationStatus.txt'];
path2Junc1 = [Rootpath filesep 'Code' filesep 'Junction1.txt'];
path2Junc2 = [Rootpath filesep 'Code' filesep 'Junction2.txt'];
path2Junc3 = [Rootpath filesep 'Code' filesep 'Junction3.txt'];

%{
global path2config
% path s to error log files 
global fpath2main1log 
global fpath2main2log 
global fpath2main3log 
global fpath2main4log 
global fpath2main5log 
global fpath2transfer1log 
global fpath2transfer2log 
global fpath2transfer3log 
global fpath2transfer4log 
global fpath2transfer5log 
global fpath2feed1log     
global fpath2feed2log     
global fpath2feed3log     
global fpath2feed4log     
global fpath2feed5log     
global fpath2splitter1eventlog
global fpath2splitter2eventlog
global fpath2upstreamlog    
global fpath2globallog
% paths to feed log files
global path2feedlog1
global path2feedlog2
global path2feedlog3
global path2feedlog4
global path2feedlog5
global path2splitter1log
global path2splitter2log
global path2feedlogupstream
% globalise path 2 final key sensor log files 
global path2tval1
global path2tval2
global path2tval3
global path2tval4
global path2tval5
global path2mval1
global path2mval2
global path2mval3
global path2mval4
global path2mval5
global path2fval1
global path2fval2
global path2fval3
global path2fval4
global path2fval5
global path2entval1
global path2entval2
global path2entval3
global path2entval4
global path2entval5
global path2exitval1
global path2exitval2
global path2exitval3
global path2exitval4
global path2exitval5
global path2downstreamtransferval1
global path2downstreamtransferval2
global path2downstreamtransferval3
global path2downstreamtransferval4
global path2downstreamtransferval5
global path2downstreamtransfervalupstr
global path2splittermatrix1
global path2splittermatrix2
global path2favouritespot
%Added by Nikki to allow GUI to see imported data 
global path2feedrtsimiocsv
global path2feedrtexptcsv
global path2palletsimiocsv
global path2palletexptcsv
% key operating files 
global path2go
global path2stop
global path2rundrawingY
global path2rundrawingN
% locations of failure matrices
global path2feed1_failure 
global path2feed2_failure 
global path2feed3_failure 
global path2feed4_failure 
global path2feed5_failure 
global path2transfer1_failure 
global path2transfer2_failure 
global path2transfer3_failure 
global path2transfer4_failure 
global path2transfer5_failure 
global path2main1_failure
global path2main2_failure 
global path2main3_failure 
global path2main4_failure 
global path2main5_failure 
global path2splitter1_failure
global path2splitter2_failure
global path2upstream_failure 
global path2failuredata
global path2masterconfig
%}
% define the root path and all subsidiaries folders cuh that they can be
% mapped out explicitly depending on the needs of a particulay instance.
% Basically each new instance will run find root path and the a script
% which determines the minimum number of directories which need to be added
% to that instance to allow operations

% to obtain each control system a different older containing identically
% named scripts is added to the path - errors will occur if an instance
% with two or more control systems added to the path tries to run a unit
% and hence care must be taken to rpevent this occuring 

%{
path2control = [Rootpath filesep 'Control' sep];
path2code=[Rootpath filesep 'Code' sep];
path2layout =[path2control filesep 'Line_Layout.txt'];
path2common_scripts=[Rootpath filesep 'Code' filesep 'Common_Resources' sep];
path2control_scripts=[Rootpath filesep 'Code' filesep 'Control_Scripts' sep]; 
path2experiments = [Rootpath filesep 'Code' filesep 'Experiments' sep];
path2globalcontrol =[Rootpath filesep 'Code' filesep 'Global_Control' sep]; 
path2localcontrol = [Rootpath filesep 'Code' filesep 'Local_Control' sep];
path2networkedunits = [Rootpath filesep 'Code' filesep 'Networked_Units' sep]; 
path2networkedunits_e = [Rootpath filesep 'Code' filesep 'Networked_Units_Concept2' sep]; 
path2toolkit=[Rootpath filesep 'Code' filesep 'RWTHMindstormsNXT' sep];
path2networkedsensors = [Rootpath filesep 'Code' filesep 'Sensor_Data_Sharing' sep]; 
path2networkedsensor_e = [Rootpath filesep 'Code' filesep 'Sensor_Data_Sharing_Expanded' sep]; 
path2writingscripts = [Rootpath filesep 'Code' filesep 'Writing_Scripts' sep]; 
% path2failure data points to the 
path2failuredata = [path2control filesep 'Failure_Data' sep];
path2databus = [Rootpath filesep 'Control' filesep 'Data_Bus_Simulated' sep];

% start up scripts used by each unit type - this contains mutliple copied
% of the start up script generated by initialise such that each unit gets
% its number set and knows which sideline it is a part of. 
path2startupscripts=[Rootpath filesep 'Control' filesep 'StartupScripts' sep];
path2feedstartup=[Rootpath filesep 'Control' filesep 'StartupScripts' filesep 'Startup_Feed' sep];
path2mainstartup=[Rootpath filesep 'Control' filesep 'StartupScripts' filesep 'Startup_Mainline' sep];
path2transferstartup=[Rootpath filesep 'Control' filesep 'StartupScripts' filesep 'Startup_Transfer' sep];
path2splitterstartup=[Rootpath filesep 'Control' filesep 'StartupScripts' filesep 'Startup_Splitter' sep];

% used by the upstream simulaion to locate the relevant script from a new
% instance of matlab without needing to waste time creating a lot of path
% data . run(path2simualtion) should run the script at the end of this
% path. 
path2simulation = [Rootpath filesep 'Code' filesep 'GUI' filesep 'Generate_Upstream_Times'];

%% Control files section 
% section to hold where to store the logfiles 
path2eventlog=[Rootpath filesep 'Control' filesep 'Logs' filesep 'EventLog' sep];
path2feedlog=[Rootpath filesep 'Control' filesep 'Logs' filesep 'FeedLog' sep];
path2sensordata=[path2control 'SensorData' sep];
%section of code to add the RWTH Toolkit to the path and run the pathing
%script for the new instances of matlab which open.
path2pathingscript=[path2control 'LoadPathData.m'];
path2go=[Rootpath filesep 'Control' filesep 'Shadow' filesep 'GO.txt'];
path2stop=[Rootpath filesep 'Control' filesep 'Shadow' filesep 'STOP.txt'];
path2rundrawingY = [path2gui 'RUN_Y.txt'];
path2rundrawingN = [path2gui 'RUN_N.txt'];
path2controltype = [Rootpath filesep 'Control' filesep 'Shadow' filesep 'control.txt'];
%}

%path2config=[Rootpath filesep 'Control' filesep 'Shadow' filesep 'config.txt'];

%path2masterconfig = [Rootpath filesep 'Code' filesep 'GUI' filesep 'config_DEFAULT.txt'];
%path2errorlog = [Rootpath filesep 'Control' filesep 'Shadow' filesep 'ErrorFile.txt'];
%{
% definitions of the paths to the data files for all light sensors that the
% GUI cares about 
path2tval1=[path2sensordata 'Tval_matrix1.mat'];
path2tval2=[path2sensordata 'Tval_matrix2.mat'];
path2tval3=[path2sensordata 'Tval_matrix3.mat'];
path2tval4=[path2sensordata 'Tval_matrix4.mat'];
path2tval5=[path2sensordata 'Tval_matrix5.mat'];
path2mval1=[path2sensordata 'Mval_matrix1.mat'];
path2mval2=[path2sensordata 'Mval_matrix2.mat'];
path2mval3=[path2sensordata 'Mval_matrix3.mat'];
path2mval4=[path2sensordata 'Mval_matrix4.mat'];
path2mval5=[path2sensordata 'Mval_matrix5.mat'];
path2fval1=[path2sensordata 'Fval_matrix1.mat'];
path2fval2=[path2sensordata 'Fval_matrix2.mat'];
path2fval3=[path2sensordata 'Fval_matrix3.mat'];
path2fval4=[path2sensordata 'Fval_matrix4.mat'];
path2fval5=[path2sensordata 'Fval_matrix5.mat'];
path2entval1=[path2sensordata 'Entval_matrix1.mat'];
path2entval2=[path2sensordata 'Entval_matrix2.mat'];
path2entval3=[path2sensordata 'Entval_matrix3.mat'];
path2entval4=[path2sensordata 'Entval_matrix4.mat'];
path2entval5=[path2sensordata 'Entval_matrix5.mat'];
path2exitval1=[path2sensordata 'Exitval_matrix1.mat'];
path2exitval2=[path2sensordata 'Exitval_matrix2.mat'];
path2exitval3=[path2sensordata 'Exitval_matrix3.mat'];
path2exitval4=[path2sensordata 'Exitval_matrix4.mat'];
path2exitval5=[path2sensordata 'Exitval_matrix5.mat'];
path2downstreamtransferval1=[path2sensordata 'Transferval_matrix1.mat'];
path2downstreamtransferval2=[path2sensordata 'Transferval_matrix2.mat'];
path2downstreamtransferval3=[path2sensordata 'Transferval_matrix3.mat'];
path2downstreamtransferval4=[path2sensordata 'Transferval_matrix4.mat'];
path2downstreamtransferval5=[path2sensordata 'Transferval_matrix5.mat'];
path2splittermatrix1 =[path2sensordata 'Splitter_Matrix1.mat'];
path2splittermatrix2 =[path2sensordata 'Splitter_Matrix2.mat'];
path2downstreamtransfervalupstr=[path2sensordata 'Transferval_upstr.mat'];

path2favouritespot = [Rootpath filesep 'Code' filesep 'GUI' filesep 'Archiving_Location.mat'];

% section containing code where to store the different feed time logs such
% that the GUI's can find them 
path2feedlog1=[path2feedlog 'Feed_1_times.txt'];
path2feedlog2=[path2feedlog 'Feed_2_times.txt'];
path2feedlog3=[path2feedlog 'Feed_3_times.txt'];
path2feedlog4=[path2feedlog 'Feed_4_times.txt'];
path2feedlog5=[path2feedlog 'Feed_5_times.txt'];
path2splitter1log=[Rootpath filesep 'Control' filesep 'Logs' filesep 'FeedLog' filesep  'Splitter_times_1.txt'];
path2splitter2log=[Rootpath filesep 'Control' filesep 'Logs' filesep 'FeedLog' filesep  'Splitter_times_2.txt'];
path2feedlogupstream=[path2feedlog 'Upstream_times.txt'];

% place to show where the event logs end up for the purpose of the GUI
% finding them again 
fpath2main1log =[path2eventlog 'Main_1.log'];
fpath2main2log =[path2eventlog 'Main_2.log'];
fpath2main3log =[path2eventlog 'Main_3.log'];
fpath2main4log =[path2eventlog 'Main_4.log'];
fpath2main5log =[path2eventlog 'Main_5.log'];
fpath2transfer1log =  [path2eventlog 'Transfer_1.log'];
fpath2transfer2log =  [path2eventlog 'Transfer_2.log'];
fpath2transfer3log =  [path2eventlog 'Transfer_3.log'];
fpath2transfer4log =  [path2eventlog 'Transfer_4.log'];
fpath2transfer5log =  [path2eventlog 'Transfer_5.log'];
fpath2feed1log     =  [path2eventlog 'Feed_1.log'];
fpath2feed2log     =  [path2eventlog 'Feed_2.log'];
fpath2feed3log     =  [path2eventlog 'Feed_3.log'];
fpath2feed4log     =  [path2eventlog 'Feed_4.log'];
fpath2feed5log     =  [path2eventlog 'Feed_5.log'];
fpath2splitter1eventlog=  [path2eventlog 'Splitter_unit1.log'];
fpath2splitter2eventlog=  [path2eventlog 'Splitter_unit2.log'];
fpath2upstreamlog     =   [path2eventlog 'Upstream_unit.log'];
fpath2globallog       =   [path2eventlog 'Global_Controller.log'];


%% paths for savefiles for experimental data - results files are written here after each run during experiment mode and then data is collated after the run to determine the end state 
path2experimentscripts = [path2code 'Experiments' filesep 'ExperimentScripts' sep];
path2experimentresults =[path2code 'Experiments' filesep 'ResultsFiles' sep];
path2experimentalfeed1 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'feed_1_results.mat'];
path2experimentalfeed2 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'feed_2_results.mat'];
path2experimentalfeed3 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'feed_3_results.mat'];
path2experimentalfeed4 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'feed_4_results.mat'];
path2experimentalfeed5 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'feed_5_results.mat'];
path2experimentalmain1 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'main_1_results.mat'];
path2experimentalmain2 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'main_2_results.mat'];
path2experimentalmain3 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'main_3_results.mat'];
path2experimentalmain4 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'main_4_results.mat'];
path2experimentalmain5 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'main_5_results.mat'];
path2experimentaltransfer1 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'transfer_1_results.mat'];
path2experimentaltransfer2 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'transfer_2_results.mat'];
path2experimentaltransfer3 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'transfer_3_results.mat'];
path2experimentaltransfer4 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'transfer_4_results.mat'];
path2experimentaltransfer5 = [path2code 'Experiments' filesep 'ResultsFiles' filesep 'transfer_5_results.mat'];
path2experimentalsplitter =[path2code 'Experiments' filesep 'ResultsFiles' filesep 'splitter_results.mat'];

%section for the experimental results outputs- files are written to these
%locations by the line during experiment mode operations. 
path2userresults = [Rootpath  filesep 'User_Results' sep];
path2palletexptoutputs = [Rootpath  filesep 'User_Results' filesep 'Pallet_Experiments_Results.txt'];
path2palletexptcsv = [Rootpath  filesep 'User_Results' filesep 'Pallet_Experiments_Results.csv'];
path2feedrtexptoutputs = [Rootpath  filesep 'User_Results' filesep 'Feed_Rate_Experiments_Results.txt'];
path2feedrtexptcsv = [Rootpath  filesep 'User_Results' filesep 'Feed_Rate_Experiments_Results.csv'];

% section for the results from simulation program - may be changed vby the
% user from the GUI- these paths point to relevant SIMIO output files
% generated by the SIMIO model. 
path2feedrtsimiocsv = [Rootpath filesep 'User_Results' filesep 'Feed_ExperimentalData.csv'];
path2palletsimiocsv = [Rootpath filesep 'User_Results' filesep 'Pallet_ExperimentalData.csv'];


%% local control section
path2localfeed=[path2localcontrol 'Feed' sep];
path2localtransfer=[path2localcontrol 'Transfer' sep];
path2localmainline=[path2localcontrol 'Mainline' sep]; 
path2localsplitter=[path2localcontrol 'Splitter' sep];
path2localupstream=[path2localcontrol 'Upstream' sep]; 


%% global control secction
path2globalfeed=[path2globalcontrol 'Feed' sep];
path2globaltransfer=[path2globalcontrol 'Transfer' sep];
path2globalmainline=[path2globalcontrol 'Mainline' sep]; 
path2globalsplitter=[path2globalcontrol 'Splitter' sep];
path2globalupstream=[path2globalcontrol 'Upstream' sep]; 

%% data sharing section 
path2snfeed=[path2networkedsensors 'Feed' sep];
path2sntransfer=[path2networkedsensors 'Transfer' sep];
path2snmainline=[path2networkedsensors 'Mainline' sep]; 
path2snsplitter=[path2networkedsensors 'Splitter' sep];
path2snupstream=[path2networkedsensors 'Upstream' sep]; 

%% unit netowrked
path2networkedunitfeed =[path2networkedunits 'Feed' sep];
path2networkedunittransfer=[path2networkedunits 'Transfer' sep];
path2networkedunitmainline=[path2networkedunits 'Mainline' sep];
path2networkedunitsplitter=[path2networkedunits 'Splitter' sep];
path2networkedunitupstream=[path2networkedunits 'Upstream' sep]; 


% section for the new failure data plots
path2feed1_failure = [path2failuredata,'Feed_1_Failure_Matrix.mat'];
path2feed2_failure = [path2failuredata,'Feed_2_Failure_Matrix.mat'];
path2feed3_failure = [path2failuredata,'Feed_3_Failure_Matrix.mat'];
path2feed4_failure = [path2failuredata,'Feed_4_Failure_Matrix.mat'];
path2feed5_failure = [path2failuredata,'Feed_5_Failure_Matrix.mat'];
path2transfer1_failure = [path2failuredata,'Transfer_1_Failure_Matrix.mat'];
path2transfer2_failure = [path2failuredata,'Transfer_2_Failure_Matrix.mat'];
path2transfer3_failure = [path2failuredata,'Transfer_3_Failure_Matrix.mat'];
path2transfer4_failure = [path2failuredata,'Transfer_4_Failure_Matrix.mat'];
path2transfer5_failure = [path2failuredata,'Transfer_5_Failure_Matrix.mat'];
path2main1_failure = [path2failuredata,'Main_1_Failure_Matrix.mat'];
path2main2_failure = [path2failuredata,'Main_2_Failure_Matrix.mat'];
path2main3_failure = [path2failuredata,'Main_3_Failure_Matrix.mat'];
path2main4_failure = [path2failuredata,'Main_4_Failure_Matrix.mat'];
path2main5_failure = [path2failuredata,'Main_5_Failure_Matrix.mat'];
path2splitter1_failure = [path2failuredata,'Splitter_1_Failure_Matrix.mat'];
path2splitter2_failure = [path2failuredata,'Splitter_2_Failure_Matrix.mat'];
path2upstream_failure  = [path2failuredata,'Upstream_Failure_Matrix.mat'];

%% saving data section 
% create a save file and distribute into all code directories 
RootpathSave=[path2gui filesep 'Path_File.mat'];
save(RootpathSave,'Rootpath','path2userresults');


%% Legacy code which required each folder have its own version of the path file. May be needed again depending on MATLAB releases so left as comments. 


% save([path2localfeed,'Path_Master_file.mat']);
% save([path2localtransfer,'Path_Master_file.mat']);
% save([path2localmainline,'Path_Master_file.mat']);
% save([path2localsplitter,'Path_Master_file.mat']);
% save([path2localupstream,'Path_Master_file.mat']);
% 
% save([path2globalfeed,'Path_Master_file.mat']);
% save([path2globaltransfer,'Path_Master_file.mat']);
% save([path2globalmainline,'Path_Master_file.mat']);
% save([path2globalsplitter,'Path_Master_file.mat']);
% save([path2globalupstream,'Path_Master_file.mat']);
% 
% save([path2snfeed,'Path_Master_file.mat']);
% save([path2sntransfer,'Path_Master_file.mat']);
% save([path2snmainline,'Path_Master_file.mat']);
% save([path2snsplitter,'Path_Master_file.mat']);
% save([path2snupstream,'Path_Master_file.mat']);
% 
% save([path2networkedunitfeed,'Path_Master_file.mat']);
% save([path2networkedunittransfer,'Path_Master_file.mat']);
% save([path2networkedunitmainline,'Path_Master_file.mat']);
% save([path2networkedunitsplitter,'Path_Master_file.mat']);
% save([path2networkedunitupstream,'Path_Master_file.mat']);
%}