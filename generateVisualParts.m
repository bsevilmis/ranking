% this script generates visual parts
clc,clear;

imagesPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/VOC2010TrainingValidation/JPEGImages/%s';
singleImagesNewPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjectsNew/%s';
categories = dir(sprintf(singleImagesNewPrefix,''));
visualNewPartsPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/visualNewParts/%s';
mkdir(sprintf(visualNewPartsPrefix, ''));

% color shift
colorShift = [100 0 80];

for i = 3:numel(categories)
    % obtain category name
    currentCategory = categories(i).name;
    % if category folder not exists create it
    if (~exist(sprintf(visualNewPartsPrefix,currentCategory), 'file'))
        mkdir(sprintf(visualNewPartsPrefix,currentCategory));
    end
    % set outputPrefix
    outputPrefix = sprintf(visualNewPartsPrefix,[currentCategory '/%s']);
    % loop through .mat files
    files = dir([sprintf(singleImagesNewPrefix,currentCategory) '/*.mat']);
    for j = 1:numel(files)
        % obtain file parts
        [path,nm,ext] = fileparts([sprintf(singleImagesNewPrefix,currentCategory) '/' files(j).name]);
        % load current annotation file
        load(sprintf([path '/%s'],[nm ext]));
        % load current image
        image = imread(sprintf(imagesPrefix,[nm '.jpg']));
        % imwrite parts
        for p = 1:numel(annotation.parts)
            currentMask = annotation.masks{p};
            currentMaskName = annotation.parts{p};
            if(~isempty(currentMask))
                coordinates = find(currentMask);
                rChannel = image(:,:,1);
                gChannel = image(:,:,2);
                bChannel = image(:,:,3);
                
                rChannel(coordinates) = rChannel(coordinates) +...
                    uint8(repmat(colorShift(1),numel(coordinates),1));
                gChannel(coordinates) = gChannel(coordinates) +...
                    uint8(repmat(colorShift(2),numel(coordinates),1));
                bChannel(coordinates) = bChannel(coordinates) +...
                    uint8(repmat(colorShift(3),numel(coordinates),1));
                
                coloredImage = image;
                coloredImage(:,:,1) = rChannel;
                coloredImage(:,:,2) = gChannel;
                coloredImage(:,:,3) = bChannel;
                
                imwrite(coloredImage,sprintf(outputPrefix,[nm '_' currentMaskName '.jpg']));
            end
        end
    end
    disp([currentCategory ' done..']);
end
        
    

