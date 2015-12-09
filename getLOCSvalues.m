function [external, internal] = getLOCSvalues (data)

idStimuli = fopen('Stimuli/LOCS_Stimuli.csv');
stimuli = textscan(idStimuli, '%q %q %q', ...
    'Delimiter', ';');
fclose(idStimuli);

vectorID = str2double(stimuli{1}(2:31))';
vectheirID = str2double(stimuli{2}(2:31))';

[~, indsort] = sort(vectheirID);

ansLOCS = {};

for i_locs = 1:length(vectorID)
    
    field = ['LOCS.' num2str(vectorID(i_locs))];
    ans_LOCS = data{3}(strcmp(data{2}, field));
    
    ansLOCS(i_locs, 1:3) = [vectorID(i_locs) vectheirID(i_locs) ans_LOCS];
end
ansLOCS = ansLOCS(indsort,:);
numansneg = 4.5 - str2num(cell2mat(ansLOCS(1, 3)));
numansposit = 0.5 + str2num(cell2mat(ansLOCS(2:12, 3)));
% external = ((sum(numansposit) + numansneg)/48)*100;
external = 0.5 + (5/3 * (sum(numansposit) + numansneg));
internal = 100 - external;




end