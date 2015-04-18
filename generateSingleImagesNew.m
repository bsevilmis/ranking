% this script goes through singleImages folder and regenerates part masks
% according to myPart2Index.m organization and saves outputs to
% singleImagesNew folder

[old, new, mergeRule,names] = myPart2Index();

filePrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/Annotations_Part/%s';
singleObjectFilesPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjects/%s';
singleObjectFiles = dir(sprintf(singleObjectFilesPrefix,''));
singleImagesNewPrefix = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/trainval/singleObjectsNew/%s';
mkdir(sprintf(singleImagesNewPrefix,''));

for i = 3:numel(singleObjectFiles)
    currentClass = singleObjectFiles(i).name;
    objectIndex = find( cellfun(@(x) strcmp(x,currentClass),names) );
    % check if this category will have new definition
    if(~isempty(mergeRule{objectIndex}))
        % check if the foler of this category already written
        if (~exist(sprintf(singleImagesNewPrefix,currentClass), 'file'))
            mkdir(sprintf(singleImagesNewPrefix,currentClass));
        end
        % get list of .mat files under this category
        files = dir(sprintf(singleObjectFilesPrefix,([currentClass '/*.mat'])));
        % loop through files
        for j = 1:numel(files)
            fileName = files(j).name;
            % load current .mat file
            load(sprintf(filePrefix,fileName));
            % check how many distinct parts are there for this object type
            oldPartNames = keys(old{objectIndex});
            oldPartValues = cell2mat(values(old{objectIndex}));
            partPresenceVector = zeros(1,numel(oldPartNames));
            partsOfCurrentAnno = {anno.objects.parts.part_name};
            maskIndexCorrespondingToOldNames = zeros(1,numel(oldPartNames));
            
            % loop through current parts to mark partPresenceVector
            for k = 1:numel(partsOfCurrentAnno)
                currentPartName = partsOfCurrentAnno{k};
                % check if any part can appear multiple times
                basePartNamePosition = strfind(currentPartName,'_');
                if(~isempty(basePartNamePosition))
                    basePartName = currentPartName(1:basePartNamePosition-1);
                else
                    basePartName = currentPartName;
                end
                [~,ind]=ismember(basePartName,oldPartNames);
                partPresenceVector(1,oldPartValues(ind)) = 1;
                maskIndexCorrespondingToOldNames(1,oldPartValues(ind)) = k;
            end
            
            % get new part names
            newPartNames = keys(new{objectIndex});
            currentMergeRules = mergeRule{objectIndex};
            currentMergeRulesNames = {currentMergeRules.name};
            % set fields for new annotations
            annotation.imname = anno.imname;
            annotation.classIndex = anno.objects.class_ind;
            annotation.class = anno.objects.class;
            annotation.parts = newPartNames;
            annotation.masks = cell(1,numel(newPartNames));
            % loop through new part generation
            for m = 1:numel(newPartNames)
                currentPartName = newPartNames{m};
                % if 'complete' use the already provided mask
                if (strcmp(currentPartName,'complete'))
                    [~,completePartIndex] = ismember('complete',newPartNames);
                    annotation.masks{completePartIndex} = anno.objects.mask;
                else
                    % find merge rule position
                    [~,currentPartIndex] = ismember(currentPartName,currentMergeRulesNames);
                    % get specific merge rules for this part
                    rules = currentMergeRules(currentPartIndex).rule;
                    for s = 1:numel(rules)
                        ruleVector = rules{s};
                        % apply rule to see if successful
                        if(sum(partPresenceVector(ruleVector)) == numel(ruleVector))
                            % obtain merged mask
                            mergedMask = false(size(anno.objects.mask));
                            for t = 1:numel(ruleVector)
                                mergedMask = mergedMask | anno.objects.parts(maskIndexCorrespondingToOldNames(ruleVector(t))).mask;
                            end
                            annotation.masks{m} = mergedMask;
                            break;
                        end
                    end
                end
            end
            % save annotation
            save(sprintf([sprintf(singleImagesNewPrefix,currentClass) '/%s'],fileName),'annotation');
        end
    end
    disp([currentClass ' done..']);
end