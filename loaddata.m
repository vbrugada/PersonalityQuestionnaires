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

% DO THIS PROPERLY
ind_ansNEOPI = strmatch('NEOPI', datamatrix(:,1)); 
ind_NEOPIpage = strmatch('NEOPI.Page', datamatrix(:, 1)); % get indices NEOPI.Page

% remove the rows that contain 'NEOPI.Page'
for i_neopage = 1:numel(ind_NEOPIpage)
   ind_ansNEOPI(ind_ansNEOPI == ind_NEOPIpage(i_neopage)) = []; 
end

ansNEOPI = datamatrix(ind_ansNEOPI,:);
ansNEOPI = ansNEOPI(indsort,2);

vectNEOPI = zeros(1, 240);

for i_neopi = 1:numel(vectNEOPI);
    currvalue = cell2mat(ansNEOPI(i_neopi));
        if length(currvalue) > 1
        currvalue = str2double(currvalue(2));   
        else
        currvalue = str2double(currvalue);    
        end
    vectNEOPI(i_neopi) = currvalue;
end

[vectFacets, vectDomains] = getNEOPIvalues (vectNEOPI);

[resNEOPI_facets, resNEOPI_domains] = findTvalues (vectFacets, vectDomains, gender);


%% RMET -- 

% DO THIS PROPERLY
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

for i_met = 1:length(ansRMET)
    curranswer = ansRMET(i_met);
    curranswer = curranswer{1};
    
    %check whether the answer is in the four possible choices
    okanswers = sum(ismember(curranswer, possAns(i_met, :)));
    okcorrect = sum(ismember(correctRMET(i_met), possAns(i_met, :)));
    if okanswers == 1
        if okcorrect == 1
            cmpAns(i_met) = strcmp(curranswer, correctRMET(i_met));
        else
            %print error
        end
    else
        % print error
        
    end
 end

resultRMET = sum(cmpAns);

%% MET --

idStimuliMET = fopen('MET_Stimuli.csv');
stimMET = textscan(idStimuliMET, '%s %s %s %s %s %s %s %s', ...
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
%% LOCS --
