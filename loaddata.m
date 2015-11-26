%% get the data from the .csv files

idData = fopen('test1v_responses.csv');

data = textscan(idData, '%s %s %s');

datamatrix = [data{2} data{3}];
datamatrix = sortrows(datamatrix);

numvect = [1 10 100:109 11 110:119 12 120:129 13 130:139 14 140:149 ...
    15 150:159 16 160:169 17 170:179 18 180:189 19 190:199 2 20 200:209 ...
    21 210:219 22 220:229 23 230:239 24 240 25:29 3 30:39 4 40:49 5 ...
    50:59 6 60:69 7 70:79 8 80:89 9 90:99]';

[sorted, indsort] = sort(numvect);
%% Demographics
gender = cell2mat(datamatrix(strmatch('Demographics.Gender', ...
    datamatrix(:, 1)),2));
gender = gender(2);

age = cell2mat(datamatrix(strmatch('Demographics.Age', ...
    datamatrix(:, 1)),2));
age = str2double(age(2:3));

%% NEOPI --

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

%% Handedness --
posHandedness = strmatch('Handedness', datamatrix(:,1)); %get indices Handedness



%% RMET -- 

posRMET = strmatch('RMET', datamatrix (:, 1)); 
posRMET_Practice = strmatch('RMET.Practise', datamatrix (:, 1));
posRMET_Defin = strmatch('RMET.Definition', datamatrix (:, 1));
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


ansRMET = datamatrix(posRMET,:);
defRMET = datamatrix(posRMET_Defin, :);

%% MET --

%% Circles --

%% LOCS --



fclose(idData);