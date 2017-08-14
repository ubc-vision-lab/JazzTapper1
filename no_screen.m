


%clear all, clc



global windowPart;    
global ScreenColor;
global TextColor;
global wRectPart;
global handle;
global matBeat;
global x;
global current_half;


rand('state', sum(100*clock));



%Load phidget
%funLoadPhifget();

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0

    

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


% Start recording tapps
matBeat=[];  
matPlayer.TimerFcn = 'funDigGrabber()';
matPlayer.TimerPeriod =  0.005;



current_half = 0;
play(matPlayer);




%Check if header has finished playing
tic
while (isplaying(matPlayer) == 1 )
    if toc > 4
        current_half = 1
    end
end

% % 500 ms interval between Intro and song 
% clear matPlayer;
% Screen('DrawText', windowPart, 'Introduction', wRectPart(3)/2-300,wRectPart(4)/2-90,OffColor);
% Screen('FrameRect', windowPart, OffColor, [wRectPart(3)/2-300 wRectPart(4)/2-25 wRectPart(3)/2-10 wRectPart(4)/2+25], 2);
% Screen('DrawText', windowPart, 'Prepare', wRectPart(3)/2+10,wRectPart(4)/2-90,PrepareColor);
% Screen('FrameRect', windowPart, PrepareColor, [wRectPart(3)/2+10 wRectPart(4)/2-25 wRectPart(3)/2+300 wRectPart(4)/2+25], 2);    
% Screen('Flip', windowPart,0,0);
% WaitSecs(0.5);




clear matPlayer;

current_half = -2;

 

%500 ms interval + Instruction panel
WaitSecs(0.5);      

end


