% This script generates subset of Caltech bird dataset

% set output directory
outputDirectory = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/subsetBirds/';
mkdir(outputDirectory);

% set bird images path
caltechBirdImagesDirectory = '/home/berksevilmis/workspace/birdProposalsProject/data4/';
caltechBirdImagesFolder = dir(caltechBirdImagesDirectory);

% set number of images
N = 50;
randomizedIndices = randperm(length(caltechBirdImagesFolder));
indices = randomizedIndices(1:N);

% generate object parts
for i = 1:N
    subInputDirectory = [caltechBirdImagesDirectory caltechBirdImagesFolder(2+indices(i)).name];
    subOutputDirectory = [outputDirectory caltechBirdImagesFolder(2+indices(i)).name '/'];
    if(exist(subOutputDirectory,'file') ~= 7)
        mkdir(subOutputDirectory);
        subFolder = dir(subInputDirectory);
    
        for imageIndices = 3:length(subFolder)
            [~, name, ext] = fileparts(subFolder(imageIndices).name);
            if(~strcmp([name(end) ext],'C.jpg') && strcmp(ext,'.jpg'))
                image = imread([subInputDirectory '/' subFolder(imageIndices).name]);
                %load annotation metafile
                bbox = textread([subInputDirectory '/' name '_bbox.txt'],'%f','delimiter',' ');
                bbBoxExpansionFactor = 1.1;
                topLeftX = bbox(1);
                topLeftY = bbox(2);
                width = bbox(3);
                height = bbox(4);
                bottomRightX = topLeftX + width - 1;
                bottomRightY = topLeftY + height - 1;
                %update bounding box
                topLeftX = topLeftX - ((sqrt(bbBoxExpansionFactor)*width-width)/2);
                topLeftY = topLeftY - ((sqrt(bbBoxExpansionFactor)*height-height)/2);
                bottomRightX = bottomRightX + ((sqrt(bbBoxExpansionFactor)*width-width)/2);
                bottomRightY = bottomRightY + ((sqrt(bbBoxExpansionFactor)*height-height)/2);
                % round to integers
                topLeftX = round(topLeftX);
                topLeftY = round(topLeftY);
                bottomRightX = round(bottomRightX);
                bottomRightY = round(bottomRightY);
                % correct corners
                topLeftX = max(1,topLeftX);
                topLeftY = max(1,topLeftY);
                bottomRightX = min(size(image,2),bottomRightX);
                bottomRightY = min(size(image,1),bottomRightY);

                %imwrite cropped image
                croppedImage = image(topLeftY:bottomRightY,topLeftX:bottomRightX,1:3); 
                imwrite(croppedImage,[subOutputDirectory '/' subFolder(imageIndices).name]);
                
                %imwrite ground truth
                gtImage = imread([subInputDirectory '/' name '.png']);
                labels = sort(unique(gtImage));
                gtImage = (gtImage == labels(end) | gtImage == labels(end-1));
                croppedGTImage = gtImage(topLeftY:bottomRightY,topLeftX:bottomRightX);
                imwrite(croppedGTImage,[subOutputDirectory '/' name '.png']);
                
                disp([name ' ..done']);
            end
        end
    end
end