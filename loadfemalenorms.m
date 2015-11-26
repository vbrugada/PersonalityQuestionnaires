function [norm_map_facets, norm_map_domains] = loadfemalenorms ()

[norms, header] = xlsread('NEOPI-Adult-Female.xlsx');

%% Facets

norm_map_facets = (0:32)';
labels_facets = {'N1', 'N2', 'N3', 'N4', 'N5', 'N6', ...
          'E1', 'E2', 'E3', 'E4', 'E5', 'E6', ...
          'O1', 'O2', 'O3', 'O4', 'O5', 'O6', ...
          'A1', 'A2', 'A3', 'A4', 'A5', 'A6', ...
          'C1', 'C2', 'C3', 'C4', 'C5', 'C6'};

for j = 1:numel(labels_facets)
    % Find column with data for this facet
    norm_facets = norms(:, [1, find(strcmp(header, labels_facets{j}))]);
    
    % Find T value for every score
    for i = 1:size(norm_map_facets, 1)
        value_facets = norm_facets(norm_map_facets(i, 1) == norm_facets(:, 2), 1);
        
        if(~isempty(value_facets))
            norm_map_facets(i, j + 1) = value_facets;
        else
            if(i > 1)
                norm_map_facets(i, j + 1) = norm_map_facets(i - 1, j + 1);
            else
                norm_map_facets(i, j + 1) = 20;
            end
        end
    end    
end

%% Domains

norm_map_domains = (0:192)';
labels_domains = {'N', 'E', 'O', 'A', 'C'};

for j = 1:numel(labels_domains)
    % Find column with data for this facet
    norm_domain = norms(:, [1, find(strcmp(header, labels_domains{j}))]);
    
    % Find T value for every score
    for i = 1:size(norm_map_domains, 1)
        value_domain = norm_domain(norm_map_domains(i, 1) == norm_domain(:, 2), 1);
        
        if(~isempty(value_domain))
            norm_map_domains(i, j + 1) = value_domain;
        else
            if(i > 1)
                norm_map_domains(i, j + 1) = norm_map_domains(i - 1, j + 1);
            else
                norm_map_domains(i, j + 1) = 20;
            end
        end
    end    
end
end