function [matTrials] = funGenTrials_Peter(iPart)
   

headerz = {};
stimz{6, 2} = {};
tempos = [1 2 3 4 5 6];
head_hist{1} = [0 0];
head_hist{2} = [0 0];
stim_hist{1} = [0 0];
stim_hist{2} = [0 0];

list_of_trials = {};

trials_multiplier = 1;

files = dir('./Headers_Tapping/*.wav');

for file = files'
    name = file.name;
    parts = strread(name,'%s','delimiter','_');
    if strcmp(parts{2}, 'tempo1')
        tempo = 1;
    elseif strcmp(parts{2}, 'tempo2')
        tempo = 2;
    elseif strcmp(parts{2}, 'tempo3')
        tempo = 3;
    elseif strcmp(parts{2}, 'tempo4')
        tempo = 4;
    elseif strcmp(parts{2}, 'tempo5')
        tempo = 5;
    elseif strcmp(parts{2}, 'tempo6')
        tempo = 6;
    end
    
    headerz{tempo} = name;
end

        
files = dir('./Stimuli/*.wav');

for file = files'
    name = file.name;
    parts = strread(name,'%s','delimiter','_');
    if strcmp(parts{1}, 'tempo1')
        tempo = 1;
    elseif strcmp(parts{1}, 'tempo2')
        tempo = 2;
    elseif strcmp(parts{1}, 'tempo3')
        tempo = 3;
    elseif strcmp(parts{1}, 'tempo4')
        tempo = 4;
    elseif strcmp(parts{1}, 'tempo5')
        tempo = 5;
    elseif strcmp(parts{1}, 'tempo6')
        tempo = 6;
    end
    
    if strcmp(parts{2}, 'ASD')
        group = 1;
    elseif strcmp(parts{2}, 'TD')
        group = 2;
    end
    
    stimz{tempo, group} = [stimz{tempo, group}, {name}];
    
end

for t = 1:trials_multiplier
    for tempo = 1:6
        for group = 1:2
            while 1
                n = length(stimz{1, 1});
                n = randi(n);
                
                if ~max(ismember([tempo n], head_hist{group}, 'rows'))
                    head_hist{group} = [head_hist{group}; [tempo n]];
                    break
                end
            end
            list_of_trials = [list_of_trials {{ headerz{tempo} stimz{tempo, group}{n} }}];
            
            while 1
                not_tempos = tempos(tempos~=tempo);
                not_tempo = not_tempos(randi(5)); 
                n = length(stimz{1, 1});
                n = randi(n);
            
                if ~max(ismember([not_tempo n], stim_hist{group}, 'rows'))
                    stim_hist{group} = [stim_hist{group}; [not_tempo n]];
                    break
                end
            end
            list_of_trials = [list_of_trials {{ headerz{tempo} stimz{not_tempo, group}{n} }}];
            
        end
    end
end

list_of_trials = list_of_trials(randperm(length(list_of_trials)));

    
    
    matTrials = {};
    save_trials = {};
    for i = list_of_trials
       matTrials = [matTrials {i{1}{1};i{1}{2}}]; 
       
       a = strread(i{1}{1},'%s','delimiter','_');
       b = strread(i{1}{2},'%s','delimiter','_');
       
       a_tempo = a{2}(6);
       b_tempo = b{1}(6);
       b_group = b{2};
       b_color = b{3};
       b_sample = b{4}(7);
       is_match = a_tempo == b_tempo;
       
       save_trials = [save_trials; { a_tempo b_tempo b_group b_color b_sample is_match }];
       
       
    end

    eval(strcat('save(''/Users/jamesenns/Desktop/TestTap/TrialLists_',num2str(iPart), ''',''save_trials'')'));
%end