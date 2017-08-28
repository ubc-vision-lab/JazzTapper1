clear




p = 26; %participant number // this changes
t = 1;          %0 starting point...? 0 is practice
                % program can mess up or practice goes bad so start with 1
                % if the thing goes badly marked on sheet of participants
the_end = 15;   %24 is the maximum number of trials

threshold = 75 ; %the value that separates a press for idle

quick = 0.2;

loadname  = strcat('TrialLists_',sprintf('%02d',p),'.mat');
load(loadname);


super_song = [];
super_play = [];
super_stats1 = {};
super_stats2 = {};
super_stats3 = {};

for t = t:the_end;


load_name = strcat('./data/mat/','p',sprintf('%02d',p),'t',num2str(t));


load (load_name)


a_sorted = matBeat(1,:);
a_sorted = sort(a_sorted);



asd = figure; %todo: come up with a more descriptive variable name


set(asd, 'Position', [100,0, 1750,1000])

subplot(1,4,1)
plot(a_sorted)

refline(0,threshold)

subplot(1,4,2)

a1 = [];
a2 = [];
a3 = [];

for i = matBeat
    if i(2) == 0
        a1 = [a1 [i(1)]];
    elseif i(2) == 1
        a2 = [a2 [i(1)]];
    else
        a3 = [a3 [i(1)]];
    end
end
refline(0,0.50)

up = 0; 
first = 0;
next = 0;
a = a1;
b = [];

touch_count = 0;

for i=1:length(a)
	c=a(i);
    if (i-first)/200 > quick    
        if (c > threshold && up == 0)
            up = 1;
            if next == 0;
                next = i; 
            else
                next = i; 
                touch_count = touch_count + 1;
                b = [b [(next-first)/200; next;]];
                super_song = [super_song; [p t touch_count (next-first)/200]];   
            end
            
            first = next;
        end
    end
    if (c < threshold && up == 1)
        up = 0;
    end
end

st = save_trials;

if t == 0
    super_stats1 = [super_stats1; [num2str(p) ',' num2str(t) ',' num2str(st{1,1}) ',' num2str(st{1,2}) ',' 'SHINY,',' ','APPLE,',' ' num2str(st{1,5}) ',' num2str(double(st{1,6})) ',' num2str(mean(b(1,:))) ',' num2str(median(b(1,:))) ',' num2str(var(b(1,:)))]];

else
    
    super_stats1 = [super_stats1; [num2str(p) ',' num2str(t) ',' num2str(st{t,1}) ',' num2str(st{t,2}) ',' st{t,3} ',' st{t,4} ',' num2str(st{t,5}) ',' num2str(double(st{t,6})) ',' num2str(mean(b(1,:))) ',' num2str(median(b(1,:))) ',' num2str(var(b(1,:)))]];
end
b1 = b;
plot(b(1,:))
hold on
refline(0,0.250)
refline(0,0.50)

up = 0; 
first = 0;
next = 0;
a = a2;
b = [];
touch_count = 0;

for i=1:length(a)
	c=a(i);
    if (i-first)/200 > quick    
        if (c > threshold && up == 0)
            up = 1;
            if next == 0;
                next = i; 
            else
                next = i; 
                touch_count = touch_count + 1;
                b = [b [(next-first)/200; next;]];
                super_play = [super_play; [p t touch_count 1 (next-first)/200]];
            end
            
            first = next;
        end
    end
    if (c < threshold && up == 1)
        up = 0;
    end
end
subplot(1,4,3)
plot(b(1,:))
refline(0,0.250)
refline(0,0.50)

b2 = b;
super_stats2 = [ super_stats2; [num2str(mean(b(1,:))) ',' num2str(median(b(1,:))) ',' num2str(var(b(1,:)))]];


up = 0; 
first = 0;
next = 0;
a = a3;
b = [];
touch_count = 0;

for i=1:length(a)
	c=a(i);
    if (i-first)/200 > quick    
        if (c > threshold && up == 0)
            up = 1;
            if next == 0;
                next = i; 
            else
                next = i; 
                touch_count = touch_count + 1;
                b = [b [(next-first)/200; next;]];
                super_play = [super_play; [p t touch_count 2 (next-first)/200]];
            end
            
            first = next;
        end
    end
    if (c < threshold && up == 1)
        up = 0;
    end
end
subplot(1,4,4)
plot(b(1,:))
refline(0,0.250)
refline(0,0.50)

b3 = b;
super_stats3 = [ super_stats3; [num2str(mean(b(1,:))) ',' num2str(median(b(1,:))) ',' num2str(var(b(1,:)))]];


drawnow
disp(strcat(num2str(t),' ####################'))


[secs, keyCode, deltaSecs] = KbWait;
if keyCode(KbName('space'))
    close all
else
    close all
    [p t]
    break
end

end 

super_stats={strcat('subjectID,','trial#,','song_tempo,','play_tempo,','group,','colour,','section,','match,','song_mean,','song_median,','song_std,','play_mean,','play_median,','play_std,','play2_mean,','play2_median,','play2_std')};

for i = 1:length(super_stats1)
   super_stats = [super_stats [strcat(super_stats1{i}, ',', super_stats2{i}, ',', super_stats3{i})]]; 
end



data_txt = './data/txt'

filename = strcat(num2str(p),'_song.txt');
csvwrite(filename, super_song)

filename = strcat(num2str(p),'_play.txt');
csvwrite(filename, super_play)

filename = strcat(num2str(p),'_stats.txt');
fileID = fopen(filename, 'w');
fprintf(fileID,'%s\n',super_stats{:});
fclose(fileID);
