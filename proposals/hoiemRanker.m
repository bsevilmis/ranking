function ranked_regions = hoiemRanker(image_data, proposals, function_root)

fprintf('\n***Extracting Proposal Appearance Features******\n');
proposal_features = getRegionAppearance(image_data, proposals);
fprintf('\n***Ranking Proposals******\n');
load(fullfile(function_root, 'classifiers', 'ranker_final.mat'), 'w');
[ranking overlaps] = rankProposals(image_data, proposals, proposal_features, w);
[dk ordering] = sort(ranking);
ranked_regions = proposals(ordering);
end