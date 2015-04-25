% This script evaluates Sminchisescu, Hoiem object proposal rankings.
% Author: Berk Sevilmis

function [] = evaluateQualityOfRanking()

% folder to save CPMC data
exp_dir = '/home/berksevilmis/workspace/proposalRankingProject/cpmcRelease/data/';

% add Hoiem code to path
addpath(genpath('~/workspace/proposalRankingProject/proposals'));

% add CPMC code to path
addpath('~/workspace/proposalRankingProject/cpmcRelease/code/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/paraFmex/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/imrender/vgg/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/immerge/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/color_sift/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/vlfeats/toolbox/kmeans/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/vlfeats/toolbox/kmeans/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/vlfeats/toolbox/mex/mexa64/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/vlfeats/toolbox/mex/mexglx/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/globalPb/lib/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/external_code/mpi-chi2-v1_5/');
addpath('~/workspace/proposalRankingProject/cpmcRelease/'); % originally not necessary due to inclusion of cpmcRanker function


% set output directory
outputDirectory = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/subsetBirds/';

% set bird images path
subsetBirdImagesDirectory = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/subsetBirds/';
subsetBirdImagesFolder = dir(subsetBirdImagesDirectory);

% set outputs
SS = [];
HH = [];
HS = [];
SH = [];

% set image counter
imageCounter = 0;

% generate results
for i = 3:length(subsetBirdImagesFolder)
    imageCounter = imageCounter + 1;
    subInputDirectory = [subsetBirdImagesDirectory subsetBirdImagesFolder(i).name];
    subFolder = dir(subInputDirectory);
    
    for imageIndices = 3:length(subFolder)
        [~, name, ext] = fileparts(subFolder(imageIndices).name);
        if(strcmp(ext,'.jpg'))
            % read image
            image = imread([subInputDirectory '/' subFolder(imageIndices).name]);
            % read ground truth
            gtImage = imread([subInputDirectory '/' name '.png']);
            
            %  CPMC
            cd './cpmcRelease';     % this is due to cpmc bad coding style,...
                                    % has hard coded paths inside such as './' assuming
                                    % current directory is already cpmcRelease
            img_name = name;
            diversify_const = 0.75;
            segm_pars = [];
            imwrite(image, [exp_dir 'JPEGImages/' img_name ext]);
 
            % delete previously calculated data
            deletionFlags = ones(1,9);
            cleanPreviuoslyStoredData(exp_dir, img_name, deletionFlags);
             
            [masks, img_name, segm_pars, ranker_file, exp_dir, diversify_const] =...
                cpmcProposalGenerator(exp_dir, img_name, diversify_const, segm_pars);
            [rankedMasks, scores] = cpmcRanker(masks, img_name, segm_pars,...
                ranker_file, exp_dir, diversify_const);
            
            % calculate jaccard index values
            jiArray = zeros(1,size(rankedMasks,3));
            for k = 1:size(jiArray,2)
                region = rankedMasks(:,:,k);
                jiValue = nnz(logical(region) & logical(gtImage)) / ...
                    nnz(logical(region) | logical(gtImage));
                jiArray(k) = jiValue;
            end
            
            % save results under SS
            SS(imageCounter).jaccardIndexArray = jiArray;
            SS(imageCounter).bestJaccardIndex = max(jiArray);
            SS(imageCounter).name = name;
            
            % HOIEM
            cd '../'
            [image_data, proposals, function_root, superpixels] = ...
                hoiemProposalGenerator(image);
            ranked_regions = ...
                hoiemRanker(image_data, proposals, function_root);
            
            % calculate jaccard index values
            masksHoiem = false(size(image,1),size(image,2),...
                length(ranked_regions));
            jiArray = zeros(1,length(ranked_regions));
            for k = 1:size(jiArray,2)
                region = ismember(superpixels,ranked_regions{k});
                masksHoiem(:,:,k) = logical(region);
                jiValue = nnz(logical(region) & logical(gtImage)) / ...
                    nnz(logical(region) | logical(gtImage));
                jiArray(k) = jiValue;
            end
            
            % save results under HH
            HH(imageCounter).jaccardIndexArray = jiArray;
            HH(imageCounter).bestJaccardIndex = max(jiArray);
            HH(imageCounter).name = name;
            
            % hoiem regions / cpmc ranker
            % replace MySegmentsMat by new masks
            dum.('masks') = masksHoiem;
            save([exp_dir 'MySegmentsMat/'  'dummy_masks' '/' img_name '.mat'], '-struct', 'dum', 'masks');
            
            %delete previously calculated data
            deletionFlags = [1 1 1 1 1 1 0 0 0];
            cleanPreviuoslyStoredData(exp_dir, img_name, deletionFlags);
            
            [rankedMasksHoiem, scores] = cpmcRanker(masksHoiem, img_name, segm_pars,...
                ranker_file, exp_dir, diversify_const);
            
            % calculate jaccard index values
            jiArray = zeros(1,length(rankedMasksHoiem));
            for k = 1:size(jiArray,2)
                region = rankedMasksHoiem(:,:,k);
                jiValue = nnz(logical(region) & logical(gtImage)) / ...
                    nnz(logical(region) | logical(gtImage));
                jiArray(k) = jiValue;
            end
            
            % save results under HS
            HS(imageCounter).jaccardIndexArray = jiArray;
            HS(imageCounter).bestJaccardIndex = max(jiArray);
            HS(imageCounter).name = name;
            
            % cpmc regions / hoiem ranker
            proposalsCPMC = cell(size(masks,3),1);
            intersectionThreshold = 0.75;
            for k = 1:size(masks,3)
                region = logical(masks(:,:,k));
                uniqueSuperpixelIndices = unique(superpixels(region));
                for l = 1:length(uniqueSuperpixelIndices)
                    superpixelArea = ...
                        nnz(superpixels == uniqueSuperpixelIndices(l));
                    if( nnz(superpixels == uniqueSuperpixelIndices(l)...
                            & region) / superpixelArea >= intersectionThreshold)
                         proposalsCPMC{k} = [proposalsCPMC{k} ...
                             uniqueSuperpixelIndices(l)];
                    end
                end
                proposalsCPMC{k} = double(proposalsCPMC{k});
                disp([num2str(k) '/' num2str(size(masks,3)) ' done..']);
            end
            
            ranked_regionsCPMC = ...
                hoiemRanker(image_data, proposalsCPMC, function_root);
            
            % calculate jaccard index values
            jiArray = zeros(1,length(ranked_regionsCPMC));
            for k = 1:size(jiArray,2)
                region = ismember(superpixels,ranked_regionsCPMC{k});
                jiValue = nnz(logical(region) & logical(gtImage)) / ...
                    nnz(logical(region) | logical(gtImage));
                jiArray(k) = jiValue;
            end
            
            % save results under SH
            SH(imageCounter).jaccardIndexArray = jiArray;
            SH(imageCounter).bestJaccardIndex = max(jiArray);
            SH(imageCounter).name = name;
            
            disp([name ' ..done']);
        end
    end
end

%save results
save([outputDirectory '/SS.mat'],'SS');
save([outputDirectory '/HH.mat'],'SS');
save([outputDirectory '/HS.mat'],'SS');
save([outputDirectory '/SH.mat'],'SS');

end

function [] = cleanPreviuoslyStoredData(exp_dir, img_name, flags)
file1 = [exp_dir 'MyMeasurements/dense_color_sift_3_scales/' img_name '.mat'];
file2 = [exp_dir 'MyMeasurements/dense_sift_4_scales/' img_name '.mat'];
file3 = [exp_dir 'MyMeasurements/dummy_masks_back_mask_phog_nopb_20_orientations_3_levels/' img_name '.mat'];
file4 = [exp_dir 'MyMeasurements/dummy_masks_bow_dense_color_sift_3_scales_figure_300/' img_name '.mat'];
file5 = [exp_dir 'MyMeasurements/dummy_masks_bow_dense_sift_4_scales_figure_300/' img_name '.mat'];
file6 = [exp_dir 'MyMeasurements/dummy_masks_mask_phog_scale_inv_20_orientations_2_levels/' img_name '.mat'];
file7 = [exp_dir 'MySegmentsMat/dummy_masks/' img_name '.mat'];
file8 = [exp_dir 'PB/' img_name '_PB.mat'];
file9 = [exp_dir 'WindowsOfInterest/grid_sampler/' img_name '_W.mat'];

if (exist(file1,'file') == 2 & flags(1))
    delete(file1);
end
if (exist(file2,'file') == 2 & flags(2))
    delete(file2);
end
if (exist(file3,'file') == 2 & flags(3))
    delete(file3);
end
if (exist(file4,'file') == 2 & flags(4))
    delete(file4);
end
if (exist(file5,'file') == 2 & flags(5))
    delete(file5);
end
if (exist(file6,'file') == 2 & flags(6))
    delete(file6);
end
if (exist(file7,'file') == 2 & flags(7))
    delete(file7);
end
if (exist(file8,'file') == 2 & flags(8))
    delete(file8);
end
if (exist(file9,'file') == 2 & flags(9))
    delete(file9);
end
end