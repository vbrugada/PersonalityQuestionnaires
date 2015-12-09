function [id, gender, age] = getdemographics (datamatrix)

id = cell2mat(datamatrix(strmatch('ParticipantID', ...
    datamatrix(:, 1)),2));

gender = cell2mat(datamatrix(strmatch('Demographics.Gender', ...
    datamatrix(:, 1)),2));
gender = gender(1);

age = cell2mat(datamatrix(strmatch('Demographics.Age', ...
    datamatrix(:, 1)),2));

end
