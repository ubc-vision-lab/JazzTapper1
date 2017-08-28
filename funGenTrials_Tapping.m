function [matTrials] = funGenTrials_Peter(iPart)
   
headers_dir = './Headers_Tapping/';
stimuli_dir = './Stimuli/';
triallists_dir = './TrialLists/';


headerz = {};
stimz{6, 2} = {};
tempos = [1 2 3 4 5 6];
head_hist{1} = [0 0];
head_hist{2} = [0 0];
stim_hist{1} = [0 0];
stim_hist{2} = [0 0];

list_of_trials = {};

trials_multiplier = 1;


%% go through all wav files in header directory, 
files = dir(strcat(headers_dir,'*.wav'));
for file = files'
    name = file.name;
    parts = textscan(name,'%s tempo%d %s','Delimiter','_');
    tempo = parts{2};
    headerz{tempo}=name;
end

%% go through all wav files stimuli directory
files = dir(strcat(stimuli_dir,'*.wav'));
for file = files'
    name = file.name;
    parts = textscan(name,'tempo%d %s %s %s %s','delimiter','_');
    tempo = parts{1};
    
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
strcat('save(''',triallists_dir,'TrialLists_',num2str(iPart), ''',''save_trials'')')
eval(strcat('save(''',triallists_dir,'TrialLists_',num2str(iPart), ''',''save_trials'')'));
%end