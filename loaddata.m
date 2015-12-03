%% get the data from the .csv files

idData = fopen('Data/8_responses.csv');
data = textscan(idData, '%q %q %q', 'Delimiter', ',');
fclose(idData);

datamatrix = [data{2} data{3}];
datamatrix = sortrows(datamatrix);

%% Demographics

[gender, age] = getdemographics (datamatrix);

%% Handedness --

[res_LI] = getLIvalue (datamatrix);

%% NEOPI --

% get the correct index
numvect = [1 10 100:109 11 110:119 12 120:129 13 130:139 14 140:149 ...
    15 150:159 16 160:169 17 170:179 18 180:189 19 190:199 2 20 200:209 ...
    21 210:219 22 220:229 23 230:239 24 240 25:29 3 30:39 4 40:49 5 ...
    50:59 6 60:69 7 70:79 8 80:89 9 90:99]';

[sorted, indsort] = sort(numvect);

ind_ansNEOPI = strmatch('NEOPI', datamatrix(:,1)); 
ind_NEOPIpage = strmatch('NEOPI.Page', datamatrix(:, 1)); % get indices NEOPI.Page

% remove the rows that contain 'NEOPI.Page'
for i_neopage = 1:numel(ind_NEOPIpage)
   ind_ansNEOPI(ind_ansNEOPI == ind_NEOPIpage(i_neopage)) = []; 
end

ansNEOPI = datamatrix(ind_ansNEOPI,:);
ansNEOPI = ansNEOPI(indsort,2);

[vectFacets, vectDomains] = getNEOPIvalues (ansNEOPI);

[res_NEOPIfacets, res_NEOPIdomains] = get_NEOPI_Tvalues (vectFacets, vectDomains, gender);


%% RMET -- 

[res_RMET] = getRMETvalues (data);


%% MET --

[res_METwords] = getMETvalues (data);

%% LOCS --
