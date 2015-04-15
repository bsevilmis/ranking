% Split VOC2010 training/validation set into class categories

% CONSIDER ONLY SINGLE OBJECT PER IMAGE
clc,clear,close all;

anno_files = dir(['/home/berksevilmis/workspace/proposalRankingProject/'...
    'dataSets/trainval/Annotations_Part/*.mat']);

filePrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/Annotations_Part/%s';
outputFolderPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjects/%s';
mkdir(sprintf(outputFolderPrefix,''));

for i = 1:numel(anno_files)
    fileName = anno_files(i).name;
    load(sprintf(filePrefix,fileName));
    if (numel(anno.objects) == 1)
        objectType = anno.objects.class;
        if (~exist(sprintf(outputFolderPrefix,objectType), 'file'))
            mkdir(sprintf(outputFolderPrefix,objectType));
        end
        copyfile(sprintf(filePrefix,fileName),sprintf(outputFolderPrefix,objectType));
        disp([objectType ' sample copied..']);
    end
end

% CONSIDER OBJECTS WITH ALL PARTS
objects(1).name = 'aeroplane';
objects(1).totalDistinctParts = 7;
objects(1).parts = {'body','engine_1','lwing','rwing','stern','tail','wheel_1'};

objects(2).name = 'bicycle';
objects(2).totalDistinctParts = 6;
objects(2).parts = {'bwheel','chainwheel','fwheel','handlebar','headlight_1','saddle'};

objects(3).name = 'bird';
objects(3).totalDistinctParts = 13;

objects(4).name = 'boat';
objects(4).totalDistinctParts = 1;

objects(5).name = 'bottle';
objects(5).totalDistinctParts = 2;

objects(6).name = 'bus';
objects(6).totalDistinctParts = 13;
objects(6).parts = {'bliplate','backside','door_1','fliplate','frontside','headlight_1','leftmirror',...
    'leftside','rightmirror','rightside','roofside','wheel_1','window_1'};

objects(7).name = 'car';
objects(7).totalDistinctParts = 13;
objects(7).parts = {'bliplate','backside','door_1','fliplate','frontside','headlight_1','leftmirror',...
    'leftside','rightmirror','rightside','roofside','wheel_1','window_1'};

objects(8).name = 'cat';
objects(8).totalDistinctParts = 17;

objects(9).name = 'chair';
objects(9).totalDistinctParts = 1;

objects(10).name = 'cow';
objects(10).totalDistinctParts = 19;

objects(11).name = 'table';
objects(11).totalDistinctParts = 1;

objects(12).name = 'dog';
objects(12).totalDistinctParts = 18;

objects(13).name = 'horse';
objects(13).totalDistinctParts = 21;

objects(14).name = 'motorbike';
objects(14).totalDistinctParts = 5;
objects(14).parts = {'bwheel','fwheel','handlebar','headlight_1','saddle'};

objects(15).name = 'person';
objects(15).totalDistinctParts = 24;

objects(16).name = 'pottedplant';
objects(16).totalDistinctParts = 2;

objects(17).name = 'sheep';
objects(17).totalDistinctParts = 19;

objects(18).name = 'sofa';
objects(18).totalDistinctParts = 1;

objects(19).name = 'train';
objects(19).totalDistinctParts = 13;
objects(19).parts = {'cbackside_1','cforntside_1','cleftside_1','crightside_1','croofside_1','coach_1','head',...
    'hbackside','hfrontside','hleftside','hrightside','hroofside','headlight_1'};

objects(20).name = 'tvmonitor';
objects(20).totalDistinctParts = 1;


outputFolderPrefix2 = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjectsWithAllParts/%s';
mkdir(sprintf(outputFolderPrefix2,''));

for i = 1:numel(anno_files)
    fileName = anno_files(i).name;
    load(sprintf(filePrefix,fileName));
    if (numel(anno.objects) == 1)
        objectType = anno.objects.class;
        if (~exist(sprintf(outputFolderPrefix2,objectType), 'file'))
            mkdir(sprintf(outputFolderPrefix2,objectType));
        end
        
        objectIndex = find( cellfun(@(x) strcmp(x,objectType),{objects.name}) );
        
        if(~isempty(objects(objectIndex).parts))        
            if (sum(ismember(objects(objectIndex).parts,{anno.objects.parts.part_name})) == ...
                    objects(objectIndex).totalDistinctParts)
                copyfile(sprintf(filePrefix,fileName),sprintf(outputFolderPrefix2,objectType));
                disp([objectType ' sample copied..']);
            end
        end  
    end
end
