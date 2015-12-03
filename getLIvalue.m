function [lateralityIndex] = getLIvalue(datamatrix);

idStimuliHand = fopen('Stimuli/Handedness_Stimuli.csv');
stimHandedness = textscan(idStimuliHand, '%q %q %q', 'Delimiter', ';');
fclose(idStimuliHand);

dataHandedness = [stimHandedness{1}, stimHandedness{3}];
dataHandedness = sortrows(dataHandedness, 2);
ind_questions = dataHandedness(:, 2);

ind_ansHandedness = strmatch('Handedness', datamatrix(:,1));

ansHandedness = datamatrix(ind_ansHandedness, :);

% variables for the for each hand
ind_right = 0;
ind_left = 0;

for i_hand = 1:numel(ind_questions)
    wordToFind = ind_questions(i_hand);
    wordToFind = cell2mat(wordToFind);
    index = find(cellfun('length',regexp(ansHandedness,wordToFind)) == 1);
    answerHand = ansHandedness(index, 2);
    if numel(answerHand) > 1
        if strcmp(answerHand(1), 'right')
            ind_right = ind_right + 1;
        elseif strcmp(answerHand(1), 'left')
            ind_left = ind_left + 1;
        end
    else
        if strcmp (answerHand, 'right')
            ind_right = ind_right + 2;
        elseif strcmp(answerHand, 'left')
            ind_left = ind_left + 2;
        elseif strcmp(answerHand, 'none')
            ind_right = ind_right + 1;
            ind_left = ind_left + 1;
        end 
    end
end

lateralityIndex = ((ind_right - ind_left)/(ind_right + ind_left));
end