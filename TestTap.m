<<<<<<< HEAD
% Clear workspace

clear all, clc




Screen('Preference', 'SkipSyncTests', 1);

global windowPart;    
global ScreenColor;
global TextColor;
global wRectPart;
global handle;
global matBeat;
global x;
global current_half;

% Directories - should be in config...
data_mat_dir = './data/mat/';
data_txt_dir = './data/txt.';
headers_dir = './Headers_Tapping/';
stimuli_dir = './Stimuli';


rand('state', sum(100*clock)); %RNG Seed? (discouraged in MATLAB docs)
% recommended: rng(sum(100*clock))


%% Prompt for participant number
%{
prompt = {'Participant Initials:', 'Window pointer (0/1):',
'Variable color (Gra/Yel):', 'Constant color (Gra/Yel):',
'Value for constant color:', 'Number of Trials:','Eye used:',
'Pixel Size:'};
%}
prompt = {'Participant (pn):'};
default_value = {'pn'};


title = 'Touch 2 Vision Search';
numLines=1;
answer = inputdlg(prompt,title,numLines,default_value);
iPart = char(answer(1)); % Participant string

%% Generate Trials
 matTrialsA = funGenTrials_Tapping(iPart);
 clear matTrials
 clear matAllTrials

 
% Open window 
[windowPart, wRectPart]=Screen('OpenWindow',0,[225 225 225]);
    
Screen(windowPart,'TextFont','Arial');
ScreenColor =[225 225 225];
TextColor= [88 26 117];
PrepareColor= [ 102 0 51];
Screen(windowPart,'TextSize',56); 
OffColor=[80 80 80];





%Load phidget
funLoadPhifget();

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0

  
    
    
% Instruction pannels
fun_Instructions('Welcome');
fun_Instructions('Instructions');
fun_Instructions('Practice');
Screen(windowPart,'TextSize',46);

%%%%%%% PRACTICE TRIAL

x = 1;
current_half = -1;
           
%Load wave files
matLoadHeader=wavread(strcat(headers_dir,'header_tempo5_15s.wav'));
matLoadStimuli=wavread(strcat(stimuli_dir,'tempo1_ASD_PURPLE_sample1_30s.wav'));
%matLoadHeader=wavread(strcat('/Users/jamesenns/Desktop/TestTap/Practice/','15_sec.wav'));
%matLoadStimuli=wavread(strcat('/Users/jamesenns/Desktop/TestTap/Practice/','30_sec.wav'));

megaLoad = [matLoadHeader; matLoadStimuli];

% Play Intro
matPlayer=audioplayer(megaLoad, 44100);

current_half = 0;


% Start recording tapps
matBeat=[];  
matPlayer.TimerFcn = 'funDigGrabber()';
matPlayer.TimerPeriod =  0.005;


play(matPlayer);

%Show screen Intro/Song
Screen('DrawText', windowPart, 'Song', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
Screen('FillRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
Screen('DrawText', windowPart, 'Play', wRectPart(3)/2+10,wRectPart(4)/2-90,OffColor);
Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
Screen('Flip', windowPart,0,0);
%Check if header has finished playing

trial_start = GetSecs;
while(isplaying(matPlayer)==1)
    if GetSecs-trial_start > 15
        break
    end
end;

% % 500 ms interval between Intro and song 
% clear matPlayer;
% Screen('DrawText', windowPart, 'Introduction', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
% Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
% Screen('DrawText', windowPart, 'Prepare', wRectPart(3)/2+10,wRectPart(4)/2-90,PrepareColor);
% Screen('FrameRect', windowPart, PrepareColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
% Screen('Flip', windowPart,0,0);
% WaitSecs(0.5);

current_half = 1;

%Show screen Intro/Song
Screen('DrawText', windowPart, 'Song', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
Screen('DrawText', windowPart, 'Play', wRectPart(3)/2+10,wRectPart(4)/2-90,TextColor);
Screen('FillRect', windowPart, TextColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
Screen('Flip', windowPart,0,0);

while(isplaying(matPlayer)==1)
    if GetSecs-trial_start > 30
        break
    end
end;

current_half = 2;

while(isplaying(matPlayer)==1)
end;
% clear screen   

clear matPlayer;

current_half = -2;

Screen(windowPart, 'FillRect', [225 225 225]);
Screen('Flip', windowPart,0,0);

% Save tapping data
matName = strcat('p',iPart,'t0');        
eval(strcat('save(',data_mat_dir,matName, ''',''matBeat'')'));
      


%500 ms interval + Instruction panel
WaitSecs(0.5);      
fun_Instructions('Start');
Screen(windowPart,'TextSize',56); 



%%%%%%% MAIN TRIALS

x = 1;

     
    
    for t=1:length(matTrialsA);
        
        x = 1;
        current_half = -1;
        
        %Load header and song
        matLoadHeader=wavread(strcat(headers_dir,matTrialsA{1,t}));
        matLoadStimuli=wavread(strcat(stimuli_dir,matTrialsA{2,t}));
        
        megaLoad = [matLoadHeader; matLoadStimuli];

        % Play Intro
        matPlayer=audioplayer(megaLoad, 44100);
        
        current_half = 0;
        
        
        % Start recording tapps
        matBeat=[];  
        matPlayer.TimerFcn = 'funDigGrabber()';
        matPlayer.TimerPeriod =  0.005;
        
        play(matPlayer);

        %Draw Intro/Song indications
        Screen('DrawText', windowPart, 'Song', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
        Screen('FillRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
        Screen('DrawText', windowPart, 'Play', wRectPart(3)/2+10,wRectPart(4)/2-90,OffColor);
        Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
        Screen('Flip', windowPart,0,0);

        %Check if header has finished playing
        tic
while(isplaying(matPlayer)==1)
    if toc > 15
        current_half = 1;
        break
    end
end;




        
        % Draw Intro/Song indications
        Screen('DrawText', windowPart, 'Song', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
        Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
        Screen('DrawText', windowPart, 'Play', wRectPart(3)/2+10,wRectPart(4)/2-90,TextColor);
        Screen('FillRect', windowPart, TextColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
        Screen('Flip', windowPart,0,0);
        
        
        tic
while(isplaying(matPlayer)==1)
    if toc > 15
        current_half = 2;
        break
    end
end;

        while(isplaying(matPlayer)==1)

        end;
        
        current_half = -2;

        % Clean audioplayer
        clear matPlayer;
        WaitSecs(0.5);


        % Clean screen
        Screen(windowPart, 'FillRect', [225 225 225]);
        Screen('Flip', windowPart,0,0);
 
     
        % Save tapping data
        matName = strcat('p',iPart,'t',num2str(t));
        
        eval(strcat('save(',data_mat_dir,matName, ''',''matBeat'')'));

        % One second pause and pass to next trial
        WaitSecs(1);
     
    end


else
    disp('Could not open InterfaceKit')
    Screen('CloseAll');
    quit;
end


%Save tapping data
 eval(strcat('save(',data_mat_dir,matName, ''',''matBeat'')'));


%Exit soft
fun_Instructions('Thanks');


% clean up
calllib('phidget21', 'CPhidget_close', handle);
calllib('phidget21', 'CPhidget_delete', handle);

%unloading the library too quickly causes issues.
pause(1);
unloadlibrary phidget21;

WaitSecs(2);

Screen('CloseAll');
quit;