function [old, new, mergeRule] = myPart2Index()
% Define the part index of each objects. 


%************** OLD(ORIGINAL) DEFINITION***************************%
old = cell(20, 1);                    
% Will define part index map for the 20 PASCAL VOC object classes in ascending
% alphabetical order (the standard PASCAL VOC order). 
for ii = 1:20
    old{ii} = containers.Map('KeyType','char','ValueType','int32');
end

% [aeroplane]
old{1}('body')        = 1;                
old{1}('stern')       = 2;                                      
old{1}('lwing')       = 3;                % left wing
old{1}('rwing')       = 4;                % right wing
old{1}('tail')        = 5;                
for ii = 1:10
    old{1}(sprintf('engine_%d', ii)) = 10+ii; % multiple engines
end
for ii = 1:10
    old{1}(sprintf('wheel_%d', ii)) = 20+ii;  % multiple wheels
end

% [bicycle]
old{2}('fwheel')      = 1;                % front wheel
old{2}('bwheel')      = 2;                % back wheel
old{2}('saddle')      = 3;               
old{2}('handlebar')   = 4;                % handle bar
old{2}('chainwheel')  = 5;                % chain wheel
old{2}('headlight')   = 6;

% [bird]
old{3}('head')        = 1;
old{3}('leye')        = 2;                % left eye
old{3}('reye')        = 3;                % right eye
old{3}('beak')        = 4;               
old{3}('torso')       = 5;            
old{3}('neck')        = 6;
old{3}('lwing')       = 7;                % left wing
old{3}('rwing')       = 8;                % right wing
old{3}('lleg')        = 9;                % left leg
old{3}('lfoot')       = 10;               % left foot
old{3}('rleg')        = 11;               % right leg
old{3}('rfoot')       = 12;               % right foot
old{3}('tail')        = 13;

% [boat]
% only has silhouette mask 

% [bottle]
old{5}('cap')         = 1;
old{5}('body')        = 2;

% [bus]
old{6}('frontside')   = 1;
old{6}('leftside')    = 2;
old{6}('rightside')   = 3;
old{6}('backside')    = 4;
old{6}('roofside')    = 5;
old{6}('leftmirror')  = 6;
old{6}('rightmirror') = 7;
old{6}('fliplate')    = 8;                % front license plate
old{6}('bliplate')    = 9;                % back license plate
for ii = 1:10
    old{6}(sprintf('door_%d',ii)) = 10 + ii;
end
for ii = 1:10
    old{6}(sprintf('wheel_%d',ii)) = 20 + ii;
end
for ii = 1:10
    old{6}(sprintf('headlight_%d',ii)) = 30 + ii;
end
for ii = 1:20
    old{6}(sprintf('window_%d',ii)) = 40 + ii;
end

% [car]
old{7}('frontside')   = 1;
old{7}('leftside')    = 2;
old{7}('rightside')   = 3;
old{7}('backside')    = 4;
old{7}('roofside')    = 5;
old{7}('leftmirror')  = 6;
old{7}('rightmirror') = 7;
old{7}('fliplate')    = 8;                % front license plate
old{7}('bliplate')    = 9;                % back license plate
old{7}('door')        = 10;
old{7}('wheel')       = 11;
old{7}('headlight')   = 12;
old{7}('window')      = 13;

% [cat]
old{8}('head')        = 1;
old{8}('leye')        = 2;                % left eye
old{8}('reye')        = 3;                % right eye
old{8}('lear')        = 4;                % left ear
old{8}('rear')        = 5;                % right ear
old{8}('nose')        = 6;
old{8}('torso')       = 7;   
old{8}('neck')        = 8;
old{8}('lfleg')       = 9;                % left front leg
old{8}('lfpa')        = 10;               % left front paw
old{8}('rfleg')       = 11;               % right front leg
old{8}('rfpa')        = 12;               % right front paw
old{8}('lbleg')       = 13;               % left back leg
old{8}('lbpa')        = 14;               % left back paw
old{8}('rbleg')       = 15;               % right back leg
old{8}('rbpa')        = 16;               % right back paw
old{8}('tail')        = 17;               

% [chair]
% only has sihouette mask 

% [cow]
old{10}('head')       = 1;
old{10}('leye')       = 2;                % left eye
old{10}('reye')       = 3;                % right eye
old{10}('lear')       = 4;                % left ear
old{10}('rear')       = 5;                % right ear
old{10}('muzzle')     = 6;
old{10}('lhorn')      = 7;                % left horn
old{10}('rhorn')      = 8;                % right horn
old{10}('torso')      = 9;            
old{10}('neck')       = 10;
old{10}('lfuleg')     = 11;               % left front upper leg
old{10}('lflleg')     = 12;               % left front lower leg
old{10}('rfuleg')     = 13;               % right front upper leg
old{10}('rflleg')     = 14;               % right front lower leg
old{10}('lbuleg')     = 15;               % left back upper leg
old{10}('lblleg')     = 16;               % left back lower leg
old{10}('rbuleg')     = 17;               % right back upper leg
old{10}('rblleg')     = 18;               % right back lower leg
old{10}('tail')       = 19;               

% [diningtable]
% only has silhouette mask 

% [dog]
keySet = keys(old{8});
valueSet = values(old{8});
old{12} = containers.Map(keySet, valueSet);       % dog has the same set of parts with cat, 
                                            		% except for the additional
                                            		% muzzle
old{12}('muzzle')     = 20;

% [horse]
old{13}('head')       = 1;
old{13}('leye')       = 2;                % left eye
old{13}('reye')       = 3;                % right eye
old{13}('lear')       = 4;                % left ear
old{13}('rear')       = 5;                % right ear
old{13}('muzzle')     = 6;
old{13}('torso')      = 7;            
old{13}('neck')       = 8;
old{13}('lfuleg')     = 9;               % left front upper leg
old{13}('lflleg')     = 10;               % left front lower leg
old{13}('rfuleg')     = 11;               % right front upper leg
old{13}('rflleg')     = 12;               % right front lower leg
old{13}('lbuleg')     = 13;               % left back upper leg
old{13}('lblleg')     = 14;               % left back lower leg
old{13}('rbuleg')     = 15;               % right back upper leg
old{13}('rblleg')     = 16;               % right back lower leg
old{13}('tail')       = 17;   
old{13}('lfho')       = 18;
old{13}('rfho')       = 19;
old{13}('lbho')       = 20;
old{13}('rbho')       = 21;

% [motorbike]
old{14}('fwheel')     = 1;
old{14}('bwheel')     = 2;
old{14}('handlebar')  = 3;
old{14}('saddle')     = 4;
old{14}('headlight')  = 5;

% [person]
old{15}('head')       = 1;
old{15}('leye')       = 2;                    % left eye
old{15}('reye')       = 3;                    % right eye
old{15}('lear')       = 4;                    % left ear
old{15}('rear')       = 5;                    % right ear
old{15}('lebrow')     = 6;                    % left eyebrow    
old{15}('rebrow')     = 7;                    % right eyebrow
old{15}('nose')       = 8;                    
old{15}('mouth')      = 9;                    
old{15}('hair')       = 10;                   

old{15}('torso')      = 11;                   
old{15}('neck')       = 12;           
old{15}('llarm')      = 13;                   % left lower arm
old{15}('luarm')      = 14;                   % left upper arm
old{15}('lhand')      = 15;                   % left hand
old{15}('rlarm')      = 16;                   % right lower arm
old{15}('ruarm')      = 17;                   % right upper arm
old{15}('rhand')      = 18;                   % right hand

old{15}('llleg')      = 19;               	% left lower leg
old{15}('luleg')      = 20;               	% left upper leg
old{15}('lfoot')      = 21;               	% left foot
old{15}('rlleg')      = 22;               	% right lower leg
old{15}('ruleg')      = 23;               	% right upper leg
old{15}('rfoot')      = 24;               	% right foot

% [pottedplant]
old{16}('pot')        = 1;
old{16}('plant')      = 2;

% [sheep]
keySet = keys(old{10});
valueSet = values(old{10});
old{17} = containers.Map(keySet, valueSet);        % sheep has the same set of parts with cow

% [sofa]
% only has sihouette mask 

% [train]
old{19}('head')       = 1;
old{19}('hfrontside') = 2;                	% head front side                
old{19}('hleftside')  = 3;                	% head left side
old{19}('hrightside') = 4;                	% head right side
old{19}('hbackside')  = 5;                 	% head back side
old{19}('hroofside')  = 6;                	% head roof side

for ii = 1:10
    old{19}(sprintf('headlight_%d',ii)) = 10 + ii;
end

for ii = 1:10
    old{19}(sprintf('coach_%d',ii)) = 20 + ii;
end

for ii = 1:10
    old{19}(sprintf('cfrontside_%d', ii)) = 30 + ii;   % coach front side
end

for ii = 1:10
    old{19}(sprintf('cleftside_%d', ii)) = 40 + ii;   % coach left side
end

for ii = 1:10
    old{19}(sprintf('crightside_%d', ii)) = 50 + ii;  % coach right side
end

for ii = 1:10
    old{19}(sprintf('cbackside_%d', ii)) = 60 + ii;   % coach back side
end

for ii = 1:10
    old{19}(sprintf('croofside_%d', ii)) = 70 + ii;   % coach roof side
end

% [tvmonitor]
old{20}('screen')     = 1;
%*********************************************************************%

%***********************NEW DEFINITION********************************%
new = cell(20, 1);                    
% Will define part index map for the 20 PASCAL VOC object classes in ascending
% alphabetical order (the standard PASCAL VOC order). 
for ii = 1:20
    new{ii} = containers.Map('KeyType','char','ValueType','int32');
end

% [aeroplane]
new{1}('body')        = 1;                
new{1}('stern')       = 2;                                      
new{1}('lwing')       = 3;                % left wing
new{1}('rwing')       = 4;                % right wing
new{1}('tail')        = 5;                
for ii = 1:10
    new{1}(sprintf('engine_%d', ii)) = 10+ii; % multiple engines
end
for ii = 1:10
    new{1}(sprintf('wheel_%d', ii)) = 20+ii;  % multiple wheels
end

% [bicycle]
new{2}('fwheel')      = 1;                % front wheel
new{2}('bwheel')      = 2;                % back wheel
new{2}('saddle')      = 3;               
new{2}('handlebar')   = 4;                % handle bar
new{2}('chainwheel')  = 5;                % chain wheel
for ii = 1:10
    new{2}(sprintf('headlight_%d', ii)) = 10 + ii;
end

% [bird]
new{3}('head')          = 1;
new{3}('lf')            = 2;
new{3}('wing')          = 3;
new{3}('tail')          = 4;
new{3}('torso')         = 5;
new{3}('tt')            = 6;
new{3}('hnt')           = 7;
new{3}('nt')            = 8;
new{3}('tlf')           = 9;
new{3}('complete')      = 10;

% [boat]
% only has silhouette mask 

% [bottle]
new{5}('cap')         = 1;
new{5}('body')        = 2;

% [bus]
new{6}('frontside')   = 1;
new{6}('leftside')    = 2;
new{6}('rightside')   = 3;
new{6}('backside')    = 4;
new{6}('roofside')    = 5;
new{6}('leftmirror')  = 6;
new{6}('rightmirror') = 7;
new{6}('fliplate')    = 8;                % front license plate
new{6}('bliplate')    = 9;                % back license plate
for ii = 1:10
    new{6}(sprintf('door_%d',ii)) = 10 + ii;
end
for ii = 1:10
    new{6}(sprintf('wheel_%d',ii)) = 20 + ii;
end
for ii = 1:10
    new{6}(sprintf('headlight_%d',ii)) = 30 + ii;
end
for ii = 1:20
    new{6}(sprintf('window_%d',ii)) = 40 + ii;
end

% [car]
new{7}('frontside')   = 1;
new{7}('leftside')    = 2;
new{7}('rightside')   = 3;
new{7}('backside')    = 4;
new{7}('roofside')    = 5;
new{7}('fliplate')    = 6;                % front license plate
new{7}('bliplate')    = 7;                % back license plate
new{7}('wheel')       = 8;
new{7}('complete')    = 9;

% [cat]
new{8}('head')        = 1;
new{8}('lp')          = 2;
new{8}('tail')        = 3;
new{8}('torso')       = 4;
new{8}('hnt')         = 5;
new{8}('tt')          = 6;
new{8}('nt')          = 7;
new{8}('tlp')         = 8;
new{8}('complete')    = 9;

% [chair]
% only has sihouette mask 

% [cow]
new{10}('head')       = 1;
new{10}('leg')        = 2;
new{10}('tail')       = 3;
new{10}('torso')      = 4;
new{10}('hnt')        = 5;
new{10}('tt')         = 6;
new{10}('nt')         = 7;
new{10}('torsoleg')   = 8;
new{10}('complete')   = 9;

% [diningtable]
% only has silhouette mask 

% [dog]
new{12}('head')        = 1;
new{12}('lp')          = 2;
new{12}('tail')        = 3;
new{12}('torso')       = 4;
new{12}('hnt')         = 5;
new{12}('tt')          = 6;
new{12}('nt')          = 7;
new{12}('tlp')         = 8;
new{12}('complete')    = 9;

% [horse]
new{13}('head')       = 1;
new{13}('lh')         = 2;
new{13}('tail')       = 3;
new{13}('torso')      = 4;
new{13}('tt')         = 5;
new{13}('hnt')        = 6;
new{13}('nt')         = 7;
new{13}('tlh')        = 8;
new{13}('complete')   = 9;

% [motorbike]
new{14}('fwheel')     = 1;
new{14}('bwheel')     = 2;
new{14}('handlebar')  = 3;
new{14}('saddle')     = 4;
for ii = 1:10
    new{14}(sprintf('headlight_%d', ii)) = 10 + ii;
end

% [person]
new{15}('hair')           = 1;
new{15}('head')           = 2;
new{15}('hand')           = 3;
new{15}('arm')            = 4;
new{15}('leg')            = 5;
new{15}('torso')          = 6;
new{15}('nt')             = 7;
new{15}('hnt')            = 8;
new{15}('torsoleg')       = 9;
new{15}('at')             = 10;
new{15}('complete')       = 11;

% [pottedplant]
new{16}('pot')        = 1;
new{16}('plant')      = 2;

% [sheep]
new{17}('head')       = 1;
new{17}('leg')        = 2;
new{17}('torso')      = 3;
new{17}('tail')       = 4;
new{17}('hnt')        = 5;
new{17}('tt')         = 6;
new{17}('nt')         = 7;
new{17}('torsoleg')   = 8;
new{17}('complete')   = 9;

% [sofa]
% only has sihouette mask 

% [train]
new{19}('head')       = 1;
new{19}('hfrontside') = 2;                	% head front side                
new{19}('hleftside')  = 3;                	% head left side
new{19}('hrightside') = 4;                	% head right side
new{19}('hbackside')  = 5;                 	% head back side
new{19}('hroofside')  = 6;                	% head roof side

for ii = 1:10
    new{19}(sprintf('headlight_%d',ii)) = 10 + ii;
end

for ii = 1:10
    new{19}(sprintf('coach_%d',ii)) = 20 + ii;
end

for ii = 1:10
    new{19}(sprintf('cfrontside_%d', ii)) = 30 + ii;   % coach front side
end

for ii = 1:10
    new{19}(sprintf('cleftside_%d', ii)) = 40 + ii;   % coach left side
end

for ii = 1:10
    new{19}(sprintf('crightside_%d', ii)) = 50 + ii;  % coach right side
end

for ii = 1:10
    new{19}(sprintf('cbackside_%d', ii)) = 60 + ii;   % coach back side
end

for ii = 1:10
    new{19}(sprintf('croofside_%d', ii)) = 70 + ii;   % coach roof side
end

% [tvmonitor]
new{20}('screen')     = 1;
%************************************************************************%

%***************************RULE DEFINITION******************************%
% BIRD
birdMergedParts(1).name = 'head';
birdMergedParts(1).rule = {[cell2mat(values(old{3},{'head'}))]};

birdMergedParts(2).name = 'lf';
birdMergedParts(2).rule = {[cell2mat(values(old{3},{'lleg'})) cell2mat(values(old{3},{'lfoot'}))];...
    [cell2mat(values(old{3},{'rleg'})) cell2mat(values(old{3},{'rfoot'}))]};    

birdMergedParts(3).name = 'wing';
birdMergedParts(3).rule = {[cell2mat(values(old{3},{'lwing'})) cell2mat(values(old{3},{'rwing'}))]};
    
birdMergedParts(4).name = 'tail';
birdMergedParts(4).rule = {[cell2mat(values(old{3},{'tail'}))]};

birdMergedParts(5).name = 'torso';
birdMergedParts(5).rule = {[cell2mat(values(old{3},{'torso'}))]};

birdMergedParts(6).name = 'tt';
birdMergedParts(6).rule = {[cell2mat(values(old{3},{'tail'})) cell2mat(values(old{3},{'torso'}))]};

birdMergedParts(7).name = 'hnt';
birdMergedParts(7).rule = {[cell2mat(values(old{3},{'head'})) cell2mat(values(old{3},{'neck'})) cell2mat(values(old{3},{'torso'}))]};

birdMergedParts(8).name = 'nt';
birdMergedParts(8).rule = {[cell2mat(values(old{3},{'neck'})) cell2mat(values(old{3},{'torso'}))]};

birdMergedParts(8).name = 'tlf';
birdMergedParts(8).rule = {[cell2mat(values(old{3},{'torso'})) cell2mat(values(old{3},{'lleg'})) cell2mat(values(old{3},{'lfoot'}))];...
    [cell2mat(values(old{3},{'torso'})) cell2mat(values(old{3},{'rleg'})) cell2mat(values(old{3},{'rfoot'}))]};
% CAT
catMergedParts(1).name = 'head';
catMergedParts(1).rule = {[cell2mat(values(old{8},{'head'}))]};

catMergedParts(2).name = 'lp';
catMergedParts(2).rule = {[cell2mat(values(old{8},{'lbleg'})) cell2mat(values(old{8},{'lbpa'}))];...
    [cell2mat(values(old{8},{'lfleg'})) cell2mat(values(old{8},{'lfpa'}))];...
    [cell2mat(values(old{8},{'rbleg'})) cell2mat(values(old{8},{'rbpa'}))];...
    [cell2mat(values(old{8},{'rfleg'})) cell2mat(values(old{8},{'rfpa'}))]};    

catMergedParts(3).name = 'tail';
catMergedParts(3).rule = {[cell2mat(values(old{8},{'tail'}))]};
    
catMergedParts(4).name = 'torso';
catMergedParts(4).rule = {[cell2mat(values(old{8},{'torso'}))]};

catMergedParts(5).name = 'hnt';
catMergedParts(5).rule = {[cell2mat(values(old{8},{'head'})) cell2mat(values(old{8},{'neck'})) cell2mat(values(old{8},{'torso'}))]};

catMergedParts(6).name = 'tt';
catMergedParts(6).rule = {[cell2mat(values(old{8},{'tail'})) cell2mat(values(old{8},{'torso'}))]};

catMergedParts(7).name = 'nt';
catMergedParts(7).rule = {[cell2mat(values(old{8},{'neck'})) cell2mat(values(old{8},{'torso'}))]};

catMergedParts(8).name = 'tlp';
catMergedParts(8).rule = {[cell2mat(values(old{8},{'torso'})) cell2mat(values(old{8},{'lbleg'})) cell2mat(values(old{8},{'lbpa'}))];...
    [cell2mat(values(old{8},{'torso'})) cell2mat(values(old{8},{'lfleg'})) cell2mat(values(old{8},{'lfpa'}))];...
    [cell2mat(values(old{8},{'torso'})) cell2mat(values(old{8},{'rbleg'})) cell2mat(values(old{8},{'rbpa'}))];...
    [cell2mat(values(old{8},{'torso'})) cell2mat(values(old{8},{'rfleg'})) cell2mat(values(old{8},{'rfpa'}))]};
% COW
cowMergedParts(1).name = 'head';
cowMergedParts(1).rule = {[cell2mat(values(old{10},{'head'}))]};

cowMergedParts(2).name = 'leg';
cowMergedParts(2).rule = {[cell2mat(values(old{10},{'lblleg'})) cell2mat(values(old{10},{'lbuleg'}))];...
    [cell2mat(values(old{10},{'lflleg'})) cell2mat(values(old{10},{'lfuleg'}))];...
    [cell2mat(values(old{10},{'rblleg'})) cell2mat(values(old{10},{'rbuleg'}))];...
    [cell2mat(values(old{10},{'rflleg'})) cell2mat(values(old{10},{'rfuleg'}))]};    

cowMergedParts(3).name = 'tail';
cowMergedParts(3).rule = {[cell2mat(values(old{10},{'tail'}))]};
    
cowMergedParts(4).name = 'torso';
cowMergedParts(4).rule = {[cell2mat(values(old{10},{'torso'}))]};

cowMergedParts(5).name = 'hnt';
cowMergedParts(5).rule = {[cell2mat(values(old{10},{'head'})) cell2mat(values(old{10},{'neck'})) cell2mat(values(old{10},{'torso'}))]};

cowMergedParts(6).name = 'tt';
cowMergedParts(6).rule = {[cell2mat(values(old{10},{'tail'})) cell2mat(values(old{10},{'torso'}))]};

cowMergedParts(7).name = 'nt';
cowMergedParts(7).rule = {[cell2mat(values(old{10},{'neck'})) cell2mat(values(old{10},{'torso'}))]};

cowMergedParts(8).name = 'torsoleg';
cowMergedParts(8).rule = {[cell2mat(values(old{10},{'torso'})) cell2mat(values(old{10},{'lblleg'})) cell2mat(values(old{10},{'lbuleg'}))];...
    [cell2mat(values(old{10},{'torso'})) cell2mat(values(old{10},{'lflleg'})) cell2mat(values(old{10},{'lfuleg'}))];...
    [cell2mat(values(old{10},{'torso'})) cell2mat(values(old{10},{'rblleg'})) cell2mat(values(old{10},{'rbuleg'}))];...
    [cell2mat(values(old{10},{'torso'})) cell2mat(values(old{10},{'rflleg'})) cell2mat(values(old{10},{'rfuleg'}))]};
% DOG
dogMergedParts(1).name = 'head';
dogMergedParts(1).rule = {[cell2mat(values(old{12},{'head'}))]};

dogMergedParts(2).name = 'lp';
dogMergedParts(2).rule = {[cell2mat(values(old{12},{'lbleg'})) cell2mat(values(old{12},{'lbpa'}))];...
    [cell2mat(values(old{12},{'lfleg'})) cell2mat(values(old{12},{'lfpa'}))];...
    [cell2mat(values(old{12},{'rbleg'})) cell2mat(values(old{12},{'rbpa'}))];...
    [cell2mat(values(old{12},{'rfleg'})) cell2mat(values(old{12},{'rfpa'}))]};    

dogMergedParts(3).name = 'tail';
dogMergedParts(3).rule = {[cell2mat(values(old{12},{'tail'}))]};
    
dogMergedParts(4).name = 'torso';
dogMergedParts(4).rule = {[cell2mat(values(old{12},{'torso'}))]};

dogMergedParts(5).name = 'hnt';
dogMergedParts(5).rule = {[cell2mat(values(old{12},{'head'})) cell2mat(values(old{12},{'neck'})) cell2mat(values(old{12},{'torso'}))]};

dogMergedParts(6).name = 'tt';
dogMergedParts(6).rule = {[cell2mat(values(old{12},{'tail'})) cell2mat(values(old{12},{'torso'}))]};

dogMergedParts(7).name = 'nt';
dogMergedParts(7).rule = {[cell2mat(values(old{12},{'neck'})) cell2mat(values(old{12},{'torso'}))]};

dogMergedParts(8).name = 'tlp';
dogMergedParts(8).rule = {[cell2mat(values(old{12},{'torso'})) cell2mat(values(old{12},{'lbleg'})) cell2mat(values(old{12},{'lbpa'}))];...
    [cell2mat(values(old{12},{'torso'})) cell2mat(values(old{12},{'lfleg'})) cell2mat(values(old{12},{'lfpa'}))];...
    [cell2mat(values(old{12},{'torso'})) cell2mat(values(old{12},{'rbleg'})) cell2mat(values(old{12},{'rbpa'}))];...
    [cell2mat(values(old{12},{'torso'})) cell2mat(values(old{12},{'rfleg'})) cell2mat(values(old{12},{'rfpa'}))]};
% HORSE
horseMergedParts(1).name = 'head';
horseMergedParts(1).rule = {[cell2mat(values(old{13},{'head'}))]};

horseMergedParts(2).name = 'lh';
horseMergedParts(2).rule = {[cell2mat(values(old{13},{'lbho'})) cell2mat(values(old{13},{'lblleg'})) cell2mat(values(old{13},{'lbuleg'}))];...
    [cell2mat(values(old{13},{'lfho'})) cell2mat(values(old{13},{'lflleg'})) cell2mat(values(old{13},{'lfuleg'}))];...
    [cell2mat(values(old{13},{'rbho'})) cell2mat(values(old{13},{'rblleg'})) cell2mat(values(old{13},{'rbuleg'}))];...
    [cell2mat(values(old{13},{'rfho'})) cell2mat(values(old{13},{'rflleg'})) cell2mat(values(old{13},{'rfuleg'}))]};    

horseMergedParts(3).name = 'tail';
horseMergedParts(3).rule = {[cell2mat(values(old{13},{'tail'}))]};
    
horseMergedParts(4).name = 'torso';
horseMergedParts(4).rule = {[cell2mat(values(old{13},{'torso'}))]};

horseMergedParts(5).name = 'tt';
horseMergedParts(5).rule = {[cell2mat(values(old{13},{'tail'})) cell2mat(values(old{13},{'torso'}))]};

horseMergedParts(6).name = 'hnt';
horseMergedParts(6).rule = {[cell2mat(values(old{13},{'head'})) cell2mat(values(old{13},{'neck'})) cell2mat(values(old{13},{'torso'}))]};

horseMergedParts(7).name = 'nt';
horseMergedParts(7).rule = {[cell2mat(values(old{13},{'neck'})) cell2mat(values(old{13},{'torso'}))]};

horseMergedParts(8).name = 'tlh';
horseMergedParts(8).rule = {[cell2mat(values(old{13},{'torso'})) cell2mat(values(old{13},{'lbho'})) cell2mat(values(old{13},{'lblleg'})) cell2mat(values(old{13},{'lbuleg'}))];...
    [cell2mat(values(old{13},{'torso'})) cell2mat(values(old{13},{'lfho'})) cell2mat(values(old{13},{'lflleg'})) cell2mat(values(old{13},{'lfuleg'}))];...
    [cell2mat(values(old{13},{'torso'})) cell2mat(values(old{13},{'rbho'})) cell2mat(values(old{13},{'rblleg'})) cell2mat(values(old{13},{'rbuleg'}))];...
    [cell2mat(values(old{13},{'torso'})) cell2mat(values(old{13},{'rfho'})) cell2mat(values(old{13},{'rflleg'})) cell2mat(values(old{13},{'rfuleg'}))]};
% PERSON
personMergedParts(1).name = 'hair';
personMergedParts(1).rule = {[cell2mat(values(old{15},{'hair'}))]};

personMergedParts(2).name = 'head';
personMergedParts(2).rule = {[cell2mat(values(old{15},{'head'}))]};

personMergedParts(3).name = 'hand';
personMergedParts(3).rule = {[cell2mat(values(old{15},{'lhand'}))];...
    [cell2mat(values(old{15},{'rhand'}))]};
    
personMergedParts(4).name = 'arm';
personMergedParts(4).rule = {[cell2mat(values(old{15},{'llarm'})) cell2mat(values(old{15},{'luarm'}))];...
    [cell2mat(values(old{15},{'rlarm'})) cell2mat(values(old{15},{'ruarm'}))]};

personMergedParts(5).name = 'leg';
personMergedParts(5).rule = {[cell2mat(values(old{15},{'llleg'})) cell2mat(values(old{15},{'luleg'}))];...
    [cell2mat(values(old{15},{'rlleg'})) cell2mat(values(old{15},{'ruleg'}))]};

personMergedParts(6).name = 'torso';
personMergedParts(6).rule = {[cell2mat(values(old{15},{'torso'}))]};

personMergedParts(7).name = 'nt';
personMergedParts(7).rule = {[cell2mat(values(old{15},{'neck'})) cell2mat(values(old{15},{'torso'}))]};

personMergedParts(8).name = 'hnt';
personMergedParts(8).rule = {[cell2mat(values(old{15},{'head'})) cell2mat(values(old{15},{'neck'})) cell2mat(values(old{15},{'torso'}))]};

personMergedParts(9).name = 'torsoleg';
personMergedParts(9).rule = {[cell2mat(values(old{15},{'torso'})) cell2mat(values(old{15},{'llleg'})) cell2mat(values(old{15},{'luleg'}))];...
    [cell2mat(values(old{15},{'torso'})) cell2mat(values(old{15},{'rlleg'})) cell2mat(values(old{15},{'ruleg'}))]};

personMergedParts(10).name = 'at';
personMergedParts(10).rule = {[cell2mat(values(old{15},{'torso'})) cell2mat(values(old{15},{'llarm'})) cell2mat(values(old{15},{'luarm'}))];...
    [cell2mat(values(old{15},{'torso'})) cell2mat(values(old{15},{'rlarm'})) cell2mat(values(old{15},{'ruarm'}))]};
% SHEEP
sheepMergedParts(1).name = 'head';
sheepMergedParts(1).rule = {[cell2mat(values(old{17},{'head'}))]};

sheepMergedParts(2).name = 'leg';
sheepMergedParts(2).rule = {[cell2mat(values(old{17},{'lblleg'})) cell2mat(values(old{17},{'lbuleg'}))];...
    [cell2mat(values(old{17},{'lflleg'})) cell2mat(values(old{17},{'lfuleg'}))];...
    [cell2mat(values(old{17},{'rblleg'})) cell2mat(values(old{17},{'rbuleg'}))];...
    [cell2mat(values(old{17},{'rflleg'})) cell2mat(values(old{17},{'rfuleg'}))]};    

sheepMergedParts(3).name = 'torso';
sheepMergedParts(3).rule = {[cell2mat(values(old{17},{'torso'}))]};

sheepMergedParts(4).name = 'tail';
sheepMergedParts(4).rule = {[cell2mat(values(old{17},{'tail'}))]};
    
sheepMergedParts(5).name = 'hnt';
sheepMergedParts(5).rule = {[cell2mat(values(old{17},{'head'})) cell2mat(values(old{17},{'neck'})) cell2mat(values(old{17},{'torso'}))]};

sheepMergedParts(6).name = 'tt';
sheepMergedParts(6).rule = {[cell2mat(values(old{17},{'tail'})) cell2mat(values(old{17},{'torso'}))]};

sheepMergedParts(7).name = 'nt';
sheepMergedParts(7).rule = {[cell2mat(values(old{17},{'neck'})) cell2mat(values(old{17},{'torso'}))]};

sheepMergedParts(8).name = 'torsoleg';
sheepMergedParts(8).rule = {[cell2mat(values(old{17},{'torso'})) cell2mat(values(old{17},{'lblleg'})) cell2mat(values(old{17},{'lbuleg'}))];...
    [cell2mat(values(old{17},{'torso'})) cell2mat(values(old{17},{'lflleg'})) cell2mat(values(old{17},{'lfuleg'}))];...
    [cell2mat(values(old{17},{'torso'})) cell2mat(values(old{17},{'rblleg'})) cell2mat(values(old{17},{'rbuleg'}))];...
    [cell2mat(values(old{17},{'torso'})) cell2mat(values(old{17},{'rflleg'})) cell2mat(values(old{17},{'rfuleg'}))]};
% CAR
carMergedParts(1).name = 'frontside';
carMergedParts(1).rule = {[cell2mat(values(old{7},{'frontside'}))]};

carMergedParts(2).name = 'leftside';
carMergedParts(2).rule = {[cell2mat(values(old{7},{'leftside'}))]};

carMergedParts(3).name = 'rightside';
carMergedParts(3).rule = {[cell2mat(values(old{7},{'rightside'}))]};
    
carMergedParts(4).name = 'backside';
carMergedParts(4).rule = {[cell2mat(values(old{7},{'backside'}))]};

carMergedParts(5).name = 'roofside';
carMergedParts(5).rule = {[cell2mat(values(old{7},{'roofside'}))]};

carMergedParts(6).name = 'fliplate';
carMergedParts(6).rule = {[cell2mat(values(old{7},{'fliplate'}))]};

carMergedParts(7).name = 'bliplate';
carMergedParts(7).rule = {[cell2mat(values(old{7},{'bliplate'}))]};

carMergedParts(8).name = 'wheel';
carMergedParts(8).rule = {[cell2mat(values(old{7},{'wheel'}))]};

mergeRule = {   [];...
                [];...
                birdMergedParts;...
                [];...
                [];...
                [];...
                carMergedParts;...
                catMergedParts;...
                [];...
                cowMergedParts;...
                [];...
                dogMergedParts;...
                horseMergedParts;...
                [];...
                personMergedParts;...
                [];...
                sheepMergedParts;...
                [];...
                [];...
                []                      };