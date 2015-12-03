function [resMET_words] = getMETvalues (data)
idStimuliMET = fopen('Stimuli/MET_Stimuli.csv');
stimMET = textscan(idStimuliMET, '%q %q %q %q %q %q %q %q', ...
    'Delimiter', ';');
fclose(idStimuliMET);

ansMET = {};

for i_met = 1:size(stimMET{1}, 1)
    % Extract stimulus number from image name
    tokens = regexpi(stimMET{2}(i_met), '([0-9]*)', 'tokens');
    
    if(isempty(tokens{1})), continue; end;
    
    stimulusNr = str2double(tokens{1}{1});
    
    % Extract data for stimulus
    field = ['MET.' num2str(stimulusNr) '.A'];
    ans_METword = data{3}(strcmp(data{2}, field));

    field = ['MET.' num2str(stimulusNr) '.B'];
    ans_METvalue = data{3}(strcmp(data{2}, field));
    
    % Extract correct answer    
    ans_METcorrect = stimMET{8}(i_met);
    
    ansMET(i_met, 1:4) = [stimulusNr ans_METword ans_METvalue ans_METcorrect];
end

resMET_words = sum(strcmp(ansMET(:, 2), ansMET(:, 4)));
end