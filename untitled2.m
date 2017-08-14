


%clear all, clc


Screen('Preference', 'SkipSyncTests', 1);

global windowPart;    
global ScreenColor;
global TextColor;
global wRectPart;
global handle;
global matBeat;
global x;
global current_half;


rand('state', sum(100*clock));


%Input values
%prompt = {'Participant Initials:', 'Window pointer (0/1):','Variable color (Gra/Yel):', 'Constant color (Gra/Yel):', 'Value for constant color:', 'Number of Trials:','Eye used:', 'Pixel Size:'};
prompt = {'Date :','Participant (pn):', 'Year Of Birth :', 'Sex (f/m):'};
def = {datestr(clock),'pn','yyyy','f'};


title = 'Touch 2 Vision Search';
lineNo=1;
answer = inputdlg(prompt,title,lineNo,def);


%Convert input to variables
date = upper(char(answer(1)));
iPart = (answer(2));
yob = upper((answer(3)));
sex = upper(char(answer(4)));


%%%%%% Save participant variables to CSV file
M= [iPart, yob];
dlmwrite ('/Users/jamesenns/Desktop/TestTap/partlog.csv', M, '-append');

iPart = char(answer(2));


% Generate Trials
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
%funLoadPhifget();

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
% matLoadHeader=wavread(strcat('/Users/jamesenns/Desktop/TestTap/Headers_Tapping/','header_tempo1_15s.wav'));
% matLoadStimuli=wavread(strcat('/Users/jamesenns/Desktop/TestTap/Stimuli/','tempo1_ASD_PURPLE_sample1_30s.wav'));

matLoadHeader=wavread(strcat('/Users/jamesenns/Desktop/TestTap/Practice/','15_sec.wav'));
matLoadStimuli=wavread(strcat('/Users/jamesenns/Desktop/TestTap/Practice/','30_sec.wav'));






% Play Intro
matPlayer=audioplayer(matLoadHeader, 44100);
matPlayer1=audioplayer(matLoadStimuli, 44100);



% Start recording tapps
matBeat=[];  
matPlayer.TimerFcn = 'funDigGrabber()';
matPlayer.TimerPeriod =  0.005;



current_half = 0;
play(matPlayer);

%Show screen Intro/Song
Screen('DrawText', windowPart, 'Song', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
Screen('FillRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
Screen('DrawText', windowPart, 'Play', wRectPart(3)/2+10,wRectPart(4)/2-90,OffColor);
Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
Screen('Flip', windowPart,0,0);




%Check if header has finished playing

WaitSecs(14.87);

% % 500 ms interval between Intro and song 
% clear matPlayer;
% Screen('DrawText', windowPart, 'Introduction', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
% Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
% Screen('DrawText', windowPart, 'Prepare', wRectPart(3)/2+10,wRectPart(4)/2-90,PrepareColor);
% Screen('FrameRect', windowPart, PrepareColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
% Screen('Flip', windowPart,0,0);
% WaitSecs(0.5);

% Play Song
current_half = 1;

play(matPlayer1);



%Show screen Intro/Song
Screen('DrawText', windowPart, 'Song', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
Screen('DrawText', windowPart, 'Play', wRectPart(3)/2+10,wRectPart(4)/2-90,TextColor);
Screen('FillRect', windowPart, TextColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
Screen('Flip', windowPart,0,0);

%Check if header has finished playing
WaitSecs(matPlayer1.TotalSamples/matPlayer1.SampleRate);

% clear screen   




clear matPlayer;
clear matPlayer1;

current_half = -2;

Screen(windowPart, 'FillRect', [225 225 225]);
Screen('Flip', windowPart,0,0);

% Save tapping data
matName = strcat('p',iPart,'t0');        
eval(strcat('save(''/Users/jamesenns/Desktop/TestTap/',matName, ''',''matBeat'')'));
      

%500 ms interval + Instruction panel
WaitSecs(0.5);      
fun_Instructions('Start');
Screen(windowPart,'TextSize',56); 

end





sca


