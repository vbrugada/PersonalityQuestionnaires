function [vectTval_facets, vectTval_domains, vectfacets_norm, ...
    vectdomains_norm] = getNEOPI_Tvalues (vF, vD, gender)

vectTval_facets = zeros(1, length(vF));
vectTval_domains = zeros(1, length(vD));

vectfacets_norm = zeros(1, length(vF));
vectdomains_norm = zeros(1, length(vD));

% get the norm_map
if gender == 'M'
    [map_facets, map_domains] = loadmalenorms();
elseif gender == 'F'
    [map_facets, map_domains] = loadfemalenorms();
end


% vector T values for facets
for i = 1:length(vF)
    vectTval_facets(i) = map_facets((vF(i) + 1), i + 1);
end

% vector T values for domains
for i = 1:length(vD)
    vectTval_domains(i) = map_domains((vD(i) + 1), i + 1);
end

% get normalized values
for ii = 1:length(vectTval_facets)
    if vectTval_facets(ii) >= 20 && vectTval_facets(ii) <=  34
        vectfacets_norm(ii) = 1;
    elseif vectTval_facets(ii) > 34 && vectTval_facets(ii) <= 44
        vectfacets_norm(ii) = 2;
    elseif vectTval_facets(ii) > 44 && vectTval_facets(ii) <= 55
        vectfacets_norm(ii) = 3;
    elseif vectTval_facets(ii) > 55 && vectTval_facets(ii) <= 65
        vectfacets_norm(ii) = 4;
    elseif vectTval_facets(ii) > 65 && vectTval_facets(ii) <= 80
        vectfacets_norm(ii) = 5;
    else
        vectfacets_norm(ii) = 0;
    end
end

for ii = 1:length(vectTval_domains)
    if vectTval_domains(ii) >= 20 && vectTval_domains(ii) <=  34
        vectdomains_norm(ii) = 1;
    elseif vectTval_domains(ii) > 34 && vectTval_domains(ii) <= 44
        vectdomains_norm(ii) = 2;
    elseif vectTval_domains(ii) > 44 && vectTval_domains(ii) <= 55
        vectdomains_norm(ii) = 3;
    elseif vectTval_domains(ii) > 55 && vectTval_domains(ii) <= 65
        vectdomains_norm(ii) = 4;
    elseif vectTval_domains(ii) > 65 && vectTval_domains(ii) <= 80
        vectdomains_norm(ii) = 5;
    else
        vectdomains_norm(ii) = 0;
    end
end

end
