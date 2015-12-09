function [tmp] = getdatapersonality ()
% get the data from the .csv files

dataDir = 'C:\Users\User\Documents\GitHub\PersonalityQuestionnaires\Data';
files = dir(fullfile(dataDir, '*_responses.csv'));

tmp = struct('participant', [], 'Handedness', [], 'NEOPI', [], 'RMET', ...
    [], 'MET', [], 'LOCS', []);

for i_files = 1:numel(files)

idData = fopen(fullfile(dataDir, files(i_files).name));

if(idData == -1)
    error(['Unable to open file "', files(i_files).name, '"']);
end

data = textscan(idData, '%q %q %q', 'Delimiter', ',');
fclose(idData);

datamatrix = [data{2} data{3}];
datamatrix = sortrows(datamatrix);

% Demographics
[participantID, gender, ~] = getdemographics (datamatrix);

subject.participant = participantID;

% Handedness --
[res_LI] = getLIvalue (datamatrix);

subject.Handedness = res_LI;

% NEOPI --
[res_TvalFacets, res_TvalDomains] = getNEOPIvalues (datamatrix, gender);

subject.NEOPI = [res_TvalFacets, res_TvalDomains];
 
% RMET -- 
[res_RMET] = getRMETvalues (data);

subject.RMET = res_RMET;

% MET --
[res_METwords] = getMETvalues (data);

subject.MET = res_METwords;

% LOCS --
[percexternal, percinternal] = getLOCSvalues (data);

subject.LOCS = [percexternal, percinternal];

%% 
tmp(i_files) = subject;


end
   
end