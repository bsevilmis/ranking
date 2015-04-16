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
objects(1).discoveredParts = zeros(1,7);
objects(1).maximumDiscoveredParts = 0;
objects(1).maximumDiscoveredPartsName = '';

objects(2).name = 'bicycle';
objects(2).totalDistinctParts = 6;
objects(2).parts = {'bwheel','chainwheel','fwheel','handlebar','headlight_1','saddle'};
objects(2).discoveredParts = zeros(1,6);
objects(2).maximumDiscoveredParts = 0;
objects(2).maximumDiscoveredPartsName = '';

objects(3).name = 'bird';
objects(3).totalDistinctParts = 13;
objects(3).parts = {'beak','head','leye','lfoot','lleg','lwing','neck','reye','rfoot','rleg','rwing','tail','torso'};
objects(3).discoveredParts = zeros(1,13);
objects(3).maximumDiscoveredParts = 0;
objects(3).maximumDiscoveredPartsName = '';

objects(4).name = 'boat';
objects(4).totalDistinctParts = 1;
objects(4).parts = [];
objects(4).discoveredParts = [];
objects(4).maximumDiscoveredParts = 0;
objects(4).maximumDiscoveredPartsName = '';

objects(5).name = 'bottle';
objects(5).totalDistinctParts = 2;
objects(5).parts = {'body','cap'};
objects(5).discoveredParts = zeros(1,2);
objects(5).maximumDiscoveredParts = 0;
objects(5).maximumDiscoveredPartsName = '';

objects(6).name = 'bus';
objects(6).totalDistinctParts = 13;
objects(6).parts = {'bliplate','backside','door_1','fliplate','frontside','headlight_1','leftmirror',...
    'leftside','rightmirror','rightside','roofside','wheel_1','window_1'};
objects(6).discoveredParts = zeros(1,13);
objects(6).maximumDiscoveredParts = 0;
objects(6).maximumDiscoveredPartsName = '';

objects(7).name = 'car';
objects(7).totalDistinctParts = 13;
objects(7).parts = {'bliplate','backside','door_1','fliplate','frontside','headlight_1','leftmirror',...
    'leftside','rightmirror','rightside','roofside','wheel_1','window_1'};
objects(7).discoveredParts = zeros(1,13);
objects(7).maximumDiscoveredParts = 0;
objects(7).maximumDiscoveredPartsName = '';

objects(8).name = 'cat';
objects(8).totalDistinctParts = 17;
objects(8).parts = {'head','lbleg','lbpa','lear','leye','lfleg','lfpa','neck','nose','rbleg','rbpa',...
    'rear','reye','rfleg','rfpa','tail','torso'};
objects(8).discoveredParts = zeros(1,17);
objects(8).maximumDiscoveredParts = 0;
objects(8).maximumDiscoveredPartsName = '';

objects(9).name = 'chair';
objects(9).totalDistinctParts = 1;
objects(9).parts = [];
objects(9).discoveredParts = [];
objects(9).maximumDiscoveredParts = 0;
objects(9).maximumDiscoveredPartsName = '';

objects(10).name = 'cow';
objects(10).totalDistinctParts = 19;
objects(10).parts = {'head','lblleg','lbuleg','lear','leye','lflleg','lfuleg','lhorn','muzzle','neck','rblleg','rbuleg','rear',...
    'reye','rflleg','rfuleg','rhorn','tail','torso'};
objects(10).discoveredParts = zeros(1,19);
objects(10).maximumDiscoveredParts = 0;
objects(10).maximumDiscoveredPartsName = '';

objects(11).name = 'table';
objects(11).totalDistinctParts = 1;
objects(11).parts = [];
objects(11).discoveredParts = [];
objects(11).maximumDiscoveredParts = 0;
objects(11).maximumDiscoveredPartsName = '';

objects(12).name = 'dog';
objects(12).totalDistinctParts = 18;
objects(12).parts = {'head','lbleg','lbpa','lear','leye','lfleg','lfpa','muzzle','neck','nose','rbleg','rbpa','rear',...
    'reye','rfleg','rfpa','tail','torso'};
objects(12).discoveredParts = zeros(1,18);
objects(12).maximumDiscoveredParts = 0;
objects(12).maximumDiscoveredPartsName = '';

objects(13).name = 'horse';
objects(13).totalDistinctParts = 21;
objects(13).parts = {'head','lbho','lblleg','lbuleg','lear','leye','lfho','lflleg','lfuleg','muzzle','neck','rbho','rblleg','rbuleg','rear',...
    'reye','rfho','rflleg','rfuleg','tail','torso'};
objects(13).discoveredParts = zeros(1,21);
objects(13).maximumDiscoveredParts = 0;
objects(13).maximumDiscoveredPartsName = '';

objects(14).name = 'motorbike';
objects(14).totalDistinctParts = 5;
objects(14).parts = {'bwheel','fwheel','handlebar','headlight_1','saddle'};
objects(14).discoveredParts = zeros(1,5);
objects(14).maximumDiscoveredParts = 0;
objects(14).maximumDiscoveredPartsName = '';

objects(15).name = 'person';
objects(15).totalDistinctParts = 24;
objects(15).parts = {'hair','head','lear','leye','lebrow','lfoot','lhand','llarm','llleg','luarm','luleg','mouth','neck',...
    'nose','rear','reye','rebrow','rfoot','rhand','rlarm','rlleg','ruarm','ruleg','torso'};
objects(15).discoveredParts = zeros(1,24);
objects(15).maximumDiscoveredParts = 0;
objects(15).maximumDiscoveredPartsName = '';

objects(16).name = 'pottedplant';
objects(16).totalDistinctParts = 2;
objects(16).parts = {'plant','pot'};
objects(16).discoveredParts = zeros(1,2);
objects(16).maximumDiscoveredParts = 0;
objects(16).maximumDiscoveredPartsName = '';

objects(17).name = 'sheep';
objects(17).totalDistinctParts = 19;
objects(17).parts = {'head','lblleg','lbuleg','lear','leye','lflleg','lfuleg','lhorn','muzzle',...
    'neck','rblleg','rbuleg','rear','reye','rflleg','rfuleg','rhorn','tail','torso'};
objects(17).discoveredParts = zeros(1,19);
objects(17).maximumDiscoveredParts = 0;
objects(17).maximumDiscoveredPartsName = '';

objects(18).name = 'sofa';
objects(18).totalDistinctParts = 1;
objects(18).parts = [];
objects(18).discoveredParts = [];
objects(18).maximumDiscoveredParts = 0;
objects(18).maximumDiscoveredPartsName = '';

objects(19).name = 'train';
objects(19).totalDistinctParts = 13;
objects(19).parts = {'cbackside_1','cforntside_1','cleftside_1','crightside_1','croofside_1','coach_1','head',...
    'hbackside','hfrontside','hleftside','hrightside','hroofside','headlight_1'};
objects(19).maximumDiscoveredParts = 0;
objects(19).maximumDiscoveredPartsName = '';

objects(20).name = 'tvmonitor';
objects(20).totalDistinctParts = 1;
objects(20).parts = [];
objects(20).discoveredParts = [];
objects(20).maximumDiscoveredParts = 0;
objects(20).maximumDiscoveredPartsName = '';

% find minimum number of examplars with many parts as possible
singleObjectFilesPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjects/%s';
singleObjectFiles = dir(sprintf(singleObjectFilesPrefix,''));
for i = 3:numel(singleObjectFiles)
    currentClass = singleObjectFiles(i).name;
    objectIndex = find( cellfun(@(x) strcmp(x,currentClass),{objects.name}) );
    
    files = dir(sprintf(singleObjectFilesPrefix,([currentClass '/*.mat'])));
    if(~isempty(objects(objectIndex).parts))

        partPresenceMatrix = zeros(numel(files),objects(objectIndex).totalDistinctParts);
        
        for j = 1:numel(files)
            load(sprintf(singleObjectFilesPrefix,([currentClass '/' files(j).name])));
  
            for k = 1 : objects(objectIndex).totalDistinctParts
                
                partIndex = find( cellfun(@(x) strcmp(x,objects(objectIndex).parts{k}),{anno.objects.parts.part_name}) );
                if(sum(partIndex) ~= 0)
                    partPresenceMatrix(j,k) = 1;
                end
            end
        end 
    end
    
    % find best images
    while(objects(objectIndex).maximumDiscoveredParts < ...
            objects(objectIndex).totalDistinctParts && ...
            sum(sum(partPresenceMatrix)) ~=0 )
        
        partSum = sum(partPresenceMatrix,2);
        [val,index] = max(partSum);
        
        objects(objectIndex).maximumDiscoveredPartsName = ...
            [objects(objectIndex).maximumDiscoveredPartsName {files(index).name}];
        
        objects(objectIndex).maximumDiscoveredParts = ...
            objects(objectIndex).maximumDiscoveredParts + val;
        
        cols = find(partPresenceMatrix(index,:));
        partPresenceMatrix(:,cols) = 0;
        partPresenceMatrix(index,:) = 0;
    end
     disp(['Class: ' currentClass ' checked..']);
end
   
% save examplars
outputFolderPrefix2 = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjectsWithAllParts/%s';
mkdir(sprintf(outputFolderPrefix2,'')); 
for i = 1:numel(objects)
      mkdir(sprintf(outputFolderPrefix2,objects(i).name));
      for j = 1:numel(objects(i).maximumDiscoveredPartsName)
          copyfile(sprintf(filePrefix,objects(i).maximumDiscoveredPartsName{j}),sprintf(outputFolderPrefix2,objects(i).name));
      end
end

save('/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/objects.mat','objects');
