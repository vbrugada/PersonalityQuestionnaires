%% Extract the data

% Extract struct with participants
[personalitystruc] = getdatapersonality ();

% Get matrix of ownership responses to questionnaires, to condition 1
addpath(genpath('C:\Users\User\Documents\GitHub\Victoria-Analysis\scripts'));

[~, cube] = orderresponses ();

mnans_owC1 = mean(squeeze(cube(1:4, 1, :)));

ownparticipants = zeros(size(personalitystruc, 2), 1);

%%
RMETvalues = zeros(size(personalitystruc, 2), 1);
METvalues = zeros(size(personalitystruc, 2), 1);
NEOPIfacetsvalues = zeros(size(personalitystruc, 2), 30);
NEOPIdomainsval = zeros(size(personalitystruc, 2), 5);
NEOPIfacets_norm = zeros(size(personalitystruc, 2), 30);
NEOPIdomains_norm = zeros(size(personalitystruc, 2), 5);
Handvalues = zeros(size(personalitystruc, 2), 1);
LOCSex_val = zeros(size(personalitystruc, 2), 1);
LOCSin_val = zeros(size(personalitystruc, 2), 1);

for i = 1:size(personalitystruc, 2)
    partnum = str2double(personalitystruc(i).participant);
    
    ownparticipants(i) = mnans_owC1(1, partnum);
    
    RMETvalues(i) = personalitystruc(i).RMET;
    METvalues(i) = personalitystruc(i).MET;
    NEOPIfacetsvalues(i, :) = personalitystruc(i).NEOPI_Facets;
    NEOPIdomainsval(i, :) = personalitystruc(i).NEOPI_Domains;
    NEOPIfacets_norm(i, :) = personalitystruc(i).NEOPI_FacetsNorm;
    NEOPIdomains_norm(i, :) = personalitystruc(i).NEOPI_DomainsNorm;
    Handvalues(i) = personalitystruc(i).Handedness;
    LOCSex_val(i) = personalitystruc(i).LOCS(1);
    LOCSin_val(i) = personalitystruc(i).LOCS(2);
end




%% NEOPI vs ownership
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
    
    [coefNEOPIf, pvalNEOPIf] = corrcoef(ownparticipants, ...
        NEOPIfacetsvalues(:, i_neopif));
    subplot(5, 7, vectfacets(i_neopif))
    plot(ownparticipants, NEOPIfacetsvalues(:, i_neopif), '.b', 'MarkerSize', 20);
    
    set (gca, 'XTick', []);
    set (gca, 'YTick', []);
    
    formatcorrplots ([0.5 7.5], [19.5 80.5], namefacets(i_neopif), '' , ...
        '', [0, 8], [20, 80], [20, 80], [40, 40], [4, 4], [20, 80]);
    title(namefacets(i_neopif), 'FontSize', 12);
    
    if i_neopif == 25 || i_neopif == 26 || i_neopif == 27 || i_neopif == 28 ...
            || i_neopif == 29 || i_neopif == 30
        set (gca, 'XTick', 1:7);
        xlabel('Ownership', 'FontSize', 12, 'FontWeight', 'bold');
    end
    
end

for i_neopid = 1:size(NEOPIdomainsval, 2)
    
    [coefNEOPId, pvalNEOPId] = ...
        corrcoef(ownparticipants, NEOPIdomainsval(:, i_neopid));
    
    subplot(5, 7, vectdomain(i_neopid))
    
    plot(ownparticipants, NEOPIdomainsval(:, i_neopid), '.r', 'MarkerSize', 20);
    set (gca, 'XTick', []);
    set (gca, 'YTick', 20:10:80);
    
    formatcorrplots ([0.5 7.5], [19.5 80.5], namedomains(i_neopid), '' , ...
        'NEOPI T-values', [0, 8], [20, 80], [20, 80], [40, 40], [4, 4], [20, 80]);
     title(namedomains(i_neopid), 'FontSize', 12);
     ylabel('NEOPI T-values', 'FontSize', 14, 'FontWeight', 'bold');
    
    if i_neopid == 5
        set (gca, 'XTick', 1:7);
        xlabel('Ownership', 'FontSize', 12, 'FontWeight', 'bold');
    end
    
end

set(fig1,'units','normalized', 'Position', [0 0 0.95 0.95])
%% NEOPI(normed) vs ownership
fig2 = figure;

for i_neopif = 1:size(NEOPIfacetsvalues, 2)
    
    [coefNEOPIf, pvalNEOPIf] = corrcoef(ownparticipants, NEOPIfacets_norm(:, i_neopif));
    subplot(5, 7, vectfacets(i_neopif))
    plot(ownparticipants, NEOPIfacets_norm(:, i_neopif), '.b', 'MarkerSize', 20);
    
    set (gca, 'XTick', []);
    set (gca, 'YTick', []);
    
    formatcorrplots ([0.5 7.5], [0.5 5.5], ...
        namefacets(i_neopif), '' , ...
        '', [0, 8], [0, 6], [0, 8], [3, 3], [4, 4], [0, 8]);
    title(namefacets(i_neopif), 'FontSize', 12);
    
    if i_neopif == 25 || i_neopif == 26 || i_neopif == 27 || i_neopif == 28 ...
            || i_neopif == 29 || i_neopif == 30
        set (gca, 'XTick', 1:7);
        xlabel('Ownership', 'FontSize', 12, 'FontWeight', 'bold');
        
    end    
end

for i_neopid = 1:size(NEOPIdomainsval, 2)
    
    [coefNEOPId, pvalNEOPId] = ...
        corrcoef(ownparticipants, NEOPIfacets_norm(:, i_neopid));
    
    subplot(5, 7, vectdomain(i_neopid))
    
    plot(ownparticipants, NEOPIfacets_norm(:, i_neopid), '.r', 'MarkerSize', 20);
    set (gca, 'XTick', []);
    set (gca, 'YTick', 1:1:5);
    set (gca, 'YTickLabel', {'Very Low', 'Low', 'Average', 'High', 'Very High'});
    
    formatcorrplots ([0.5 7.5], [0.5 5.5], ...
        namedomains(i_neopid), '' , ...
        'NEOPI T-values', [0, 8], [0, 6], [0, 8], [3, 3], [4, 4], [0, 8]);
     title(namedomains(i_neopid), 'FontSize', 12);
     ylabel('NEOPI T-values', 'FontSize', 14, 'FontWeight', 'bold');
    
    if i_neopid == 5
        set (gca, 'XTick', 1:7);
        xlabel('Ownership', 'FontSize', 12, 'FontWeight', 'bold');
    end
    
end

set(fig2,'units','normalized', 'Position', [0 0 0.95 0.95])


%% RMET vs ownership
[coefRMET, pvalRMET] = corrcoef(ownparticipants, RMETvalues);

fig3 = figure;
plot(ownparticipants, RMETvalues,'.b', 'MarkerSize', 20);

text(1, 33, strcat('R = ',num2str(coefRMET(1, 2))), 'FontSize', 11);
text(1, 32, strcat('p val = ',num2str(pvalRMET(1, 2))), 'FontSize', 11);

xlabel('Means ownership');
ylabel('RMET results');

formatcorrplots ([0.5 7.5], [0.5 36.5], ...
    'Ownership - no gap no offset; RMET', 'Ownership responses', ...
    'MET results', [0, 8], [0, 36], [0, 36], [18, 18], [4, 4], [0, 36]);

set (gca, 'XTick', 1:7);
set (gca, 'YTick', 0:5:36);

set(fig3,'units','normalized', 'Position', [0.1 0.1 0.45 0.7])

%% MET vs ownership
[coefMET, pvalMET] = corrcoef(ownparticipants, METvalues);

fig4 = figure;
plot(ownparticipants, METvalues,'.b', 'MarkerSize', 20);

text(1, 36, strcat('R = ',num2str(coefMET(1, 2))), 'FontSize', 11);
text(1, 35, strcat('p val = ',num2str(pvalMET(1, 2))), 'FontSize', 11);

formatcorrplots ([0.5 7.5], [0.5 40.5], ...
    'Ownership - no gap no offset; MET Cognitive', 'Ownership', ...
    'MET results', [0, 8], [0, 40], [0, 40], [20, 20], [4, 4], [0, 40]);

set (gca, 'XTick', 1:7, 'FontSize', 11);
set (gca, 'YTick', 0:5:40, 'FontSize', 11);

set(fig4,'units','normalized', 'Position', [0.1 0.1 0.45 0.7]);

%% LOCS vs ownership
[coefLOCS, pvalLOCS] = corrcoef (ownparticipants, LOCSex_val);

fig5 = figure;
plot(ownparticipants, LOCSex_val,'.b', 'MarkerSize', 20);

text(1, 96, strcat('R = ',num2str(coefLOCS(1, 2))), 'FontSize', 11);
text(1, 93, strcat('p val = ',num2str(pvalLOCS(1, 2))), 'FontSize', 11);

formatcorrplots ([0.5 7.5], [0.5 100.5], 'Ownership - LOCS External', ...
    'Means to ownership', 'Individual percentages for LOCS External', ...
    [0, 8], [0, 100], [0, 100], [50, 50], [4, 4], [0, 100]);

set (gca, 'XTick', 1:7, 'FontSize', 11);
set (gca, 'YTick', 0:10:100, 'FontSize', 11);

set(fig5,'units','normalized', 'Position', [0.2 0.2 0.45 0.7]);

%% MET RMET
[coefMET_RMET, pvalMET_RMET] = corrcoef (RMETvalues, METvalues);

fig6 = figure;
plot(RMETvalues, METvalues,'.b', 'MarkerSize', 20);

text(3, 37, strcat('R = ',num2str(coefMET_RMET(1, 2))));
text(3, 35.5, strcat('p val = ',num2str(pvalMET_RMET(1, 2))));

set (gca, 'XTick', 0:5:36, 'FontSize', 11);
set (gca, 'YTick', 0:5:40, 'FontSize', 11);

formatcorrplots ([0.5 36.5], [0.5 40.5], 'RMET and MET Cognitive', ...
    'Individual values for RMET', 'Individual values for MET (Cognitive)', ...
    [0, 36], [0, 40], [0, 40], [20, 20], [18, 18], [0, 40]);

set(fig6,'units','normalized', 'Position', [0.2 0.2 0.45 0.7]);