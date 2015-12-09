function [resRMET] = getRMETvalues (data)

idStimuliRMET = fopen('Stimuli/RMET_Stimuli.csv');
stimRMET = textscan(idStimuliRMET, '%q %q %q %q %q %q %q %q', ...
    'Delimiter',';');
fclose(idStimuliRMET);

    ans_RMETpossible = [stimRMET{3} stimRMET{4} stimRMET{5} stimRMET{6}];
    ans_RMETpossible = ans_RMETpossible(3:38, :);

ans_RMET = {};

for i_rmet = 1:size(stimRMET{1}, 1)
    % Extract stimulus number from image name
    tokens = regexpi(stimRMET{2}(i_rmet), ['Face' '([0-9]*)'], 'tokens');
    
    if(isempty(tokens{1})), continue; end;
    
    stimulusNr = str2double(tokens{1}{1});
    
    % Extract data for stimulus
    field = strcat('RMET.Face', tokens{1}{1});
    ans_RMETword = data{3}(strcmp(data{2}, field));
    
    % Extract correct answer    
    ans_RMETcorrect = stimRMET{8}(i_rmet);

    % Extract possible answers
    isanswer = ...
           ismember(ans_RMETword, ans_RMETpossible((i_rmet - 2), :));
    iscorrect = ...
            ismember(ans_RMETcorrect, ans_RMETpossible((i_rmet - 2), :));
    if isanswer == 1
        if iscorrect == 1
            ans_RMET(i_rmet, 1:3) = ...
                [stimulusNr ans_RMETword ans_RMETcorrect];
        else
            fprintf('This is not working');
        end
    end
    
end

resRMET = sum(strcmp(ans_RMET(:, 2), ans_RMET(:, 3)));

end