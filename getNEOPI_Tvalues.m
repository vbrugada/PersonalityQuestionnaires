function [vectTval_facets, vectTval_domains] = getNEOPI_Tvalues (vF, vD, gender)

% get the norm_map
if gender == 'M'
    [map_facets, map_domains] = loadmalenorms();
elseif gender == 'F'
    [map_facets, map_domains] = loadfemalenorms();
end

vectTval_facets = zeros(1, length(vF));
vectTval_domains = zeros(1, length(vD));

% vector T values for facets
for i = 1:length(vF)
    vectTval_facets(i) = map_facets((vF(i) + 1), i + 1);
end

% vector T values for domains
for i = 1:length(vD)
    vectTval_domains(i) = map_domains((vD(i) + 1), i + 1);
end
end
