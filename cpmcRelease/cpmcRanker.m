function [masks, scores] = cpmcRanker(masks, img_name, segm_pars,...
    ranker_file, exp_dir, diversify_const)   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% 2. compute segment ranking features %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load ranker model (trained on training set of voc segmentation dataset)
% substitute train by trainval for images outside the segmentation validation set
% of VOC2010.
load([exp_dir '/MySegmentRankers/' ranker_file]);
disp('Starting feature extraction.');
D = get_features(exp_dir, img_name, segm_pars.name, masks, segment_measurements);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 3. rank masks %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% normalize the features
D = cellfun(@double, D, 'UniformOutput', false);
D = D(:);

if(iscell(scaling))
    for i=1:numel(scaling)
        D{i} =  scale_data(D{i}, scaling_type, scaling{i});
    end
    D_scaled = cell2mat(D);
else
    D_scaled = cell2mat(D);
    D_scaled = scale_data(D_scaled, scaling_type, scaling);
end

dims = cellfun(@(a) size(a,1), D);
Feats = D_scaled;
[Feats] = SvmSegm_mix_linear_and_random_features(Feats, w.kernels, scaling_type, w.scaling_RF, dims, [], w.N_OUT_DIMS, w.obj, w.merge_kernels);
pred = predict_regressor(Feats, w.weights);

small_masks = imresize(masks, 0.25, 'nearest');
small_masks = reshape(small_masks, size(small_masks,1) * size(small_masks,2), size(small_masks,3));
overlap_mat = single(segm_overlap_mex(small_masks));
scores = diversify_ranking(pred, overlap_mat, diversify_const);

[sorted_scores, ids] = sort(scores, 'descend');
masks = masks(:,:,ids);
scores = sorted_scores;
end

function D = get_features(exp_dir, img_name, mask_type, masks, feat_types)
    segm_feats = {'SimpleSegmentFeatures', 'GestaltSegmentFeatures'};
    sf_in = [];
    
    t1 = tic();
    for i=1:numel(segm_feats)
        sf_in = [sf_in find(strcmp(segm_feats{i}, feat_types))];
    end    
    
    D_1 = SvmSegm_compute_segm_feats_nofiles(exp_dir, img_name, masks, segm_feats(sf_in));    
    t_segm_feats1 = toc(t1);
    fprintf('Time getting first set of features: %f\n', t_segm_feats1);
    
    t2 = tic();
    recog_feats_in = setdiff(1:numel(feat_types), sf_in);
    delete_local_feats = false;
    D_2 = SvmSegm_extract_all_class_features_nofiles(exp_dir, img_name, mask_type, feat_types(recog_feats_in), delete_local_feats);    
    t_segm_feats2 = toc(t2);
    fprintf('Time getting second set of features: %f\n', t_segm_feats2);
    D = [D_1 D_2];
    
    % reorder
    D = D([sf_in recog_feats_in]);
end