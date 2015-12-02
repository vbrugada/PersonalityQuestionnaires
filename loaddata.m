%% get the data from the .csv files

idData = fopen('test1v_responses.csv');
data = textscan(idData, '%q %q %q', 'Delimiter', ',');
fclose(idData);

datamatrix = [data{2} data{3}];
datamatrix = sortrows(datamatrix);

%% Demographics
gender = cell2mat(datamatrix(strmatch('Demographics.Gender', ...
    datamatrix(:, 1)),2));
gender = gender(1);

age = cell2mat(datamatrix(strmatch('Demographics.Age', ...
    datamatrix(:, 1)),2));

%% Handedness --

idStimuliHand = fopen('Handedness_Stimuli.csv');
stimHandedness = textscan(idStimuliHand, '%q %q %q', 'Delimiter', ';');
fclose(idStimuliHand);

dataHandedness = [stimHandedness{1}, stimHandedness{3}];
dataHandedness = sortrows(dataHandedness, 2);
ind_questions = dataHandedness(:, 2);

ind_ansHandedness = strmatch('Handedness', datamatrix(:,1)); %get indices Handedness

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

%% NEOPI --

% get the correct index
numvect = [1 10 100:109 11 110:119 12 120:129 13 130:139 14 140:149 ...
    15 150:159 16 160:169 17 170:179 18 180:189 19 190:199 2 20 200:209 ...
    21 210:219 22 220:229 23 230:239 24 240 25:29 3 30:39 4 40:49 5 ...
    50:59 6 60:69 7 70:79 8 80:89 9 90:99]';

[sorted, indsort] = sort(numvect);

posNEOPI = strmatch('NEOPI', datamatrix(:,1)); % get indices of NEOPI
posNEOPI_Page = strmatch('NEOPI.Page', datamatrix(:, 1)); % get indices NEOPI.Page

% remove the rows that contain 'NEOPI.Page'
for i = 1:numel(posNEOPI_Page)
   posNEOPI(posNEOPI == posNEOPI_Page(i)) = []; 
end

answersNEOPI = datamatrix(posNEOPI,:);
answersNEOPI = answersNEOPI(indsort,2);

vectNEOPI = zeros(1, 240);

for j = 1:numel(vectNEOPI);
    currentvalue = cell2mat(answersNEOPI(j));
        if length(currentvalue) > 1
        currentvalue = str2double(currentvalue(2));   
        else
        currentvalue = str2double(currentvalue);    
        end
    vectNEOPI(j) = currentvalue;
end

[vectFacets, vectDomains] = getNEOPIvalues (vectNEOPI);

[Tvalues_facets, Tvalues_domains] = findTvalues (vectFacets, vectDomains, gender);




%% RMET -- 

% get the answers of the participant
posRMET = strmatch('RMET', datamatrix (:, 1)); 
posRMET_Practice = strmatch('RMET.Practise', datamatrix (:, 1));
posRMET_DefinUnd = strmatch('RMET.Definition', datamatrix (:, 1));
posRMET_Defin = strmatch('RMET.Definition.undefined', datamatrix (:, 1));
posRMET_Page = strmatch('RMET.Page', datamatrix (:, 1));

% remove the rows that contain 'RMET.Page', 'RMET.Definition', and
% 'RMET.Practice'
allRMET = datamatrix(posRMET,:);

for i = 1:numel(posRMET_Page)
   posRMET(posRMET == posRMET_Page(i)) = [];
end

for j = 1:numel(posRMET_Defin)
    posRMET(posRMET == posRMET_Defin(i)) = [];
end

for k = 1:numel(posRMET_Practice)
    posRMET(posRMET == posRMET_Practice(i)) = [];
end

for l = 1:numel(posRMET_DefinUnd)
    posRMET(posRMET == posRMET_DefinUnd(i)) = [];
end

ansRMET = datamatrix(posRMET, 2);


% get the correct answers
idStimuliRMET = fopen('RMET_Stimuli.csv');
stimuliRMET = textscan(idStimuliRMET, '%s %s %s %s %s %s %s %s', ...
    'Delimiter',';');
fclose(idStimuliRMET);

dataRMET = [stimuliRMET{3} stimuliRMET{4} stimuliRMET{5} stimuliRMET{6} ...
    stimuliRMET{8}];

posCorrect = (3:38);
correctRMET = dataRMET(posCorrect, 5);
possAns = dataRMET (posCorrect, 1:4);

cmpAns = zeros (1, numel(ansRMET));

for i = 1:length(ansRMET)
    currentAns = ansRMET(i);
    currentAns = currentAns{1};
    currentAns = currentAns(2:(length(currentAns) - 1));
    
    %check whether the answer is in the four possible choices
    okanswers = sum(ismember(currentAns, possAns(i, :)));
    okcorrect = sum(ismember(correctRMET(i), possAns(i, :)));
    if okanswers == 1
        if okcorrect == 1
            cmpAns(i) = strcmp(currentAns, correctRMET(i));
        else
            %print error
        end
    else
        % print error
        
    end
 end

resultRMET = sum(cmpAns);

%% MET --

% get the answers of the participant
posMET = strmatch('MET', datamatrix (:, 1)); 
posMET_Practice = strmatch('MET.practise', datamatrix (:, 1));
% posRMET_DefinUnd = strmatch('RMET.Definition', datamatrix (:, 1));
% posRMET_Defin = strmatch('RMET.Definition.undefined', datamatrix (:, 1));
posMET_Page = strmatch('MET.Page', datamatrix (:, 1));

% % remove the rows that contain 'RMET.Page', 'RMET.Definition', and
% % 'RMET.Practice'
% allRMET = datamatrix(posRMET,:);
% 
for i = 1:numel(posMET_Page)
   posMET(posMET == posMET_Page(i)) = [];
end
% 
% for j = 1:numel(posRMET_Defin)
%     posRMET(posRMET == posRMET_Defin(i)) = [];
% end
% 

for k = 1:numel(posMET_Practice)
    posMET(posMET == posMET_Practice(i)) = [];
end
% 
% for l = 1:numel(posRMET_DefinUnd)
%     posRMET(posRMET == posRMET_DefinUnd(i)) = [];
% end
% 
ansMET = datamatrix(posMET, 1:2);


idStimuliMET = fopen('MET_Stimuli.csv');
stimuliMET = textscan(idStimuliMET, '%s %s %s %s %s %s %s %s', ...
    'Delimiter', ';');
fclose(idStimuliMET);

MET = {};

for i = 1:size(stimuliMET{1}, 1)
    % Extract stimulus number from image name
    tokens = regexpi(stimuliMET{2}(i), '([0-9]*)', 'tokens');
    
    if(isempty(tokens{1})), continue; end;
    
    stimulusNr = str2double(tokens{1}{1});
    
    % Extract data for stimulus
    field = ['MET.' num2str(stimulusNr) '.A,'];
    answerA = data{3}(strcmp(data{2}, field));

    field = ['MET.' num2str(stimulusNr) '.B,'];
    answerB = data{3}(strcmp(data{2}, field));
    
    % Extract correct answer    
    correctAnswer = stimuliMET{8}(i);
    
    MET(i, 1:4) = [stimulusNr answerA answerB correctAnswer];
end






%% Circles --

%% LOCS --
