
% get the struct of all the participants
[personalitystruc] = getdatapersonality ();

% get answers of ownership for the first condition (no gap, no offset)
addpath(genpath('C:\Users\User\Documents\GitHub\Victoria-Analysis\scripts'));
[~, cube] = orderresponses ();

mnans_owC1 = mean(squeeze(cube(1:4, 1, :)));

ownparticipants = zeros(size(personalitystruc, 2), 1);

RMETvalues = zeros(size(personalitystruc, 2), 1);
METvalues = zeros(size(personalitystruc, 2), 1);
NEOPIfacetsvalues = zeros(size(personalitystruc, 2), 30);
NEOPIdomainsval = zeros(size(personalitystruc, 2), 5);
Handvalues = zeros(size(personalitystruc, 2), 1);

for i = 1:size(personalitystruc, 2)
   partnum = str2double(personalitystruc(i).participant);
    
   ownparticipants(i) = mnans_owC1(1, partnum);

   RMETvalues(i) = personalitystruc(i).RMET;
   METvalues(i) = personalitystruc(i).MET;
   NEOPIfacetsvalues(i, :) = personalitystruc(i).NEOPI(1:30);
   NEOPIdomainsval(i, :) = personalitystruc(i).NEOPI(31:35);
   Handvalues(i) = personalitystruc(i).Handedness;
   LOCSex_val(i) = personalitystruc(i).LOCS(1);
end


% NEOPI
fig1 = figure;

vectfacets = [2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, ...
    20, 21, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35];
    namefacets = {'Anxiety', 'Angry Hostility', 'Depression', ...
'Self-Consciousness', 'Impulsiveness', 'Vulnerability', 'Warmth', ...
 'Gregariousness', 'Assertiveness', 'Activity', 'Excitement-seeking', ...
'Positive Emotions', 'Fantasy', 'Aesthetics', 'Feelings', 'Actions', ...
'Ideas', 'Values', 'Trust', 'Straightforwardness', 'Altruism', ...
 'Compliance', 'Modesty', 'Tender-Mindedness', 'Competence', 'Order', ...
 'Dutifulness', 'Achievement Striving', 'Self-Discipine', 'Deliberation'};
vectdomain = [1, 8, 15, 22, 29];
    namedomains = {'Neuroticism', 'Extraversion', 'Openness', ...
'Agreeableness', 'Conscientiousness'};

for i_neopif = 1:size(NEOPIfacetsvalues, 2)

[coefNEOPIf, pvalNEOPIf] = corrcoef(ownparticipants, NEOPIfacetsvalues(:, i_neopif));
subplot(5, 7, vectfacets(i_neopif))
plot(ownparticipants, NEOPIfacetsvalues(:, i_neopif), '.b', 'MarkerSize', 20);
title(namefacets(i_neopif));
line([0, 8],[0, 80], ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line([0, 80],[40, 40], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line([4, 4],[0, 80], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
xlim([0.5 7.5]);
ylim([0.5 80.5]);
set (gca, 'XTick', 1:7);
set (gca, 'YTick', 0:10:80);

end

for i_neopid = 1:size(NEOPIdomainsval, 2)

[coefNEOPId, pvalNEOPId] = corrcoef(ownparticipants, NEOPIdomainsval(:, i_neopid));
subplot(5, 7, vectdomain(i_neopid))
plot(ownparticipants, NEOPIdomainsval(:, i_neopid), '.r', 'MarkerSize', 20);
title(namedomains(i_neopid));
line([0, 8],[0, 80], ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line([0, 80],[40, 40], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line([4, 4],[0, 80], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
xlim([0.5 7.5]);
ylim([0.5 80.5]);
set (gca, 'XTick', 1:7);
set (gca, 'YTick', 0:10:80);

end

% RMET vs ownership
[coefRMET, pvalRMET] = corrcoef(ownparticipants, RMETvalues);

fig2 = figure;
plot(ownparticipants, RMETvalues,'.b', 'MarkerSize', 20); 
title('Ownership - no gap no offset; RMET',...
    'FontWeight', 'bold');
line([0, 8],[0, 36], ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line([0, 36],[18, 18], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line([4, 4],[0, 36], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
xlim([0.5 7.5]);

ylim([0.5 36.5]);
xlabel('Means ownership');
ylabel('RMET results');
set (gca, 'XTick', 1:7);
set (gca, 'YTick', 0:5:36);
set(fig2,'units','normalized', 'Position', [0.1 0.1 0.45 0.7])


% MET vs ownership
[coefMET, pvalMET] = corrcoef(ownparticipants, METvalues);

fig3 = figure;
plot(ownparticipants, METvalues,'.b', 'MarkerSize', 20); 
title('Ownership - no gap no offset; MET Cognitive',...
    'FontWeight', 'bold');
line([0, 8],[0, 40], ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line([0, 40],[20, 20], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line([4, 4],[0, 40], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
xlim([0.5 7.5]);
ylim([0.5 40.5]);
xlabel('Ownership');
ylabel('MET results');

set(fig3,'units','normalized', 'Position', [0.1 0.1 0.45 0.7]);

% LOCS vs ownership
[coefLOCS, pvalLOCS] = corrcoef (ownparticipants, LOCSex_val);

fig4 = figure;

plot(ownparticipants, LOCSex_val,'.b', 'MarkerSize', 20); 
title('Ownership - no gap no offset; LOCS External',...
    'FontWeight', 'bold');
line([0, 8],[0, 100], ...
    'LineStyle', ':', 'Color', [212/255 212/255 212/255]); hold on;
line([0, 100],[50, 50], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
line([4, 4],[0, 100], ...
    'LineStyle', ':', 'Color', [197/255 153/255 153/255]); hold on;
xlim([0.5 7.5]);
ylim([0.5 100.5]);
xlabel('Ownership');
ylabel('LOCS External');



