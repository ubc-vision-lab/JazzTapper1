function [] = fun_Instructions(FileName);

global windowPart;    
global ScreenColor;
global TextColor;

Screen(windowPart,'TextSize',32);

%     
%      % Select specific text font, style and size:

   
% Screen('TextFont',windowPart, 'Arial');
% Screen('TextSize',windowPart, 22);
% Screen('TextStyle', windowPart, 1+2);



    % Read some text file:
    cmdString=strcat('/Users/jamesenns/Desktop/TestTap/Instructions/',FileName,'.m')
    fd = fopen(cmdString,'rt');
    if fd==-1
        error('Could not open the Instructions file!');
    end;
    
    mytext = '';
    tl = fgets(fd);
    lcount = 0;
    while (tl~=-1) & (lcount < 48)
        mytext = [mytext tl];
        tl = fgets(fd);
        lcount = lcount +  1;
    end;
    fclose(fd);
    mytext = [mytext char(10)];

    %Now horizontally and vertically centered:
    [nx, ny, bbox] = DrawFormattedText(windowPart, mytext, 'center', 'center', TextColor,90,0,0,2);
     
     
    Screen('Flip',windowPart);
    
    WaitSecs(0.5);
    

    k='aaaaaa';
    
    while (strcmp(k,'Return')==0)

       k = KbName;
       
    end;



    %clear instructions on release button
    Screen(windowPart, 'FillRect', ScreenColor);
    Screen('Flip', windowPart,0,0);
    Screen('Flip',windowPart);
    %Change textsizeback
%     Screen('TextSize', windowPart, 46);
%     Screen('TextStyle',windowPart,0+1);


 
end

