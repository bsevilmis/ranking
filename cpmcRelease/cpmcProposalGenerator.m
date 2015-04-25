function [masks, img_name, segm_pars, ranker_file, exp_dir, diversify_const] = cpmcProposalGenerator(exp_dir, img_name, diversify_const, segm_pars)
DefaultVal('*diversify_const', '0.75');

%  do switch to '''attention_model_fewfeats_lambda_10.00_trainval.mat'''
%  for imgs not in the VOC2010 trainval image set.
DefaultVal('*ranker_file', '''attention_model_fewfeats_lambda_10.00_train.mat''');
DefaultVal('*segm_pars', '[]');

if(isempty(segm_pars))
    segm_pars.pb_folder = [exp_dir 'PB/'];
    segm_pars.name = 'dummy_masks';
    
    % UniformSegmenter uses a uniform unary term. LongRangeSegmenter
    % uses a color-based unary term. GridOfFramesSegmenter is defined
    % inside subframes (rectangular regions of interest), and it's good for smaller objects.
    % Each will generate and solve different energy functions.
    segm_pars.segm_methods = {'UniformSegmenter', 'LongRangeSegmenter', 'GridOfFramesSegmenter'};
    
    % can set a limit on the number of segments for each kind of
    % Segmenter. The joint set will be filtered in the end.
    segm_pars.max_n_segms = [inf inf inf];
    segm_pars.min_n_pixels = 200; % 1000
    segm_pars.sigma = {1, 2, 0.8};
    %segm_pars.sigma = {1.2, 2.2, 1}; % larger is smoother (fewer segments)
    
    % how much to resize the image (there doesn't seem to be any numerical negative
    % impact on the VOC segmentation dataset to resize to half).
    segm_pars.resize_factor= 0.5;
    
    % does a morphological operation to remove little wires in the
    % image. In general a good idea. But might negatively affect wiry structures
    % like bikes a little bit.
    segm_pars.morph_open = true;
    
    % Do the fast filtering step (always recommended).
    segm_pars.filter_segments = {true, true, true};
    
    % Dimensions of the grid, for each segmenter type.
    %
    % Be careful with the third set. In GridOfFramesSegmenter, a grid
    % is set up inside each subframe . [1 1] sets a single
    % foreground seed, [2 2] would set 4 foreground seeds. If you have 40 subframes like currently, it's
    % really better not to have more than [1 1].
    % On the other two [5 5] should be fine. We used [6 6] on
    % the VOC2010 challenge.
    segm_pars.grid_dims = {[5 5], [5 5], [1 1]};
    
    % The maximum energy for the initial filtering step, for each
    % method. The proper value depends on the sigma value, which is
    % unfortunate. If  you don't to spend time on it, just leave the
    % default value. If you don't want to filter based on the energy uncomment the following line
    %the_segm_pars.max_energy = {inf, inf, inf};
    
    %%%% these are parameters related to the GridOfFramesSegmenter
    % Two options are implemented: a regular grid of subframes, and
    % using a bounding box detector. Using the detector gets 1% better
    % covering.
    segm_pars.window_gen_parms.kind = 'grid_sampler';
    segm_pars.windows_folder = [exp_dir 'WindowsOfInterest/grid_sampler'];
    % If you want to use instead the detector you'll have to install
    % the latent svm code from http://people.cs.uchicago.edu/~pff/latent/, including the star
    % cascade. Then you can uncomment the  two bottom lines
    %segm_pars.window_gen_parms.kind = 'sliding_window_detection';
    %segm_pars.windows_folder = [exp_dir 'WindowsOfInterest/sliding_window_detection'];
    
    segm_pars.window_gen_parms.det_classes = []; % this needs to be here (bug)
    
    segm_pars.randomize_N = 1000; % maximum number of segments to pass to the clustering step, for each type of segmenter. For speed considerations.
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% 1. compute masks %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Starting computation of figure-ground segmentations');
masks = cpmc_masks(exp_dir, img_name, segm_pars);