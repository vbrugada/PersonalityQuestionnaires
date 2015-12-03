function [gender, age] = getdemographics (datamatrix)

% participantID = cell2mat(datamatrix(strmatch('Demographucs

gender = cell2mat(datamatrix(strmatch('Demographics.Gender', ...
    datamatrix(:, 1)),2));
gender = gender(1);

age = cell2mat(datamatrix(strmatch('Demographics.Age', ...
    datamatrix(:, 1)),2));

end
