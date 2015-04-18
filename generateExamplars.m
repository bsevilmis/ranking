% this script copies images to guiExamples folder to achieve the initial step
% of gui generation

annosPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjectsWithAllParts/%s';
annoFiles = dir(sprintf(annosPrefix,''));
imagesPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/VOC2010TrainingValidation/JPEGImages/%s';
outputPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/guiExamples/%s';

for i = 3:numel(annoFiles)
    folderName = annoFiles(i).name;
    folderPrefix = sprintf(annosPrefix, folderName);
    annos = dir([folderPrefix '/' '*.mat']);
    for j = 1:numel(annos)
        [~, name, ext] = fileparts(annos(j).name);
        copyfile(sprintf(imagesPrefix,[name '.jpg']),sprintf(outputPrefix,[name '.jpg']));
    end
end