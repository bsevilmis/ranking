% This script generates plots for cross proposal/ranker analysis.
% Author: Berk Sevilmis

clear;close all;
addpath('/home/berksevilmis/Downloads/export_fig/');

% set input directory to collect results
inputDirectory = '/home/berksevilmis/workspace/proposalRankingProject/dataSets/subsetBirds/';
inputDirectoryTree = dir(inputDirectory);

% set number of images to generate plots
N = 100;
SSCombined = cell(N,1);
HHCombined = cell(N,1);
SHCombined = cell(N,1);
HSCombined = cell(N,1);

% find minumum number of proposals generated
minN = Inf;

for i = 1:N
    currentFolder = [inputDirectory inputDirectoryTree(i+2).name '/%s'];
    % load SS
    currentSS = load(sprintf(currentFolder,'SS.mat'));
    currentSS = currentSS.SS;
    % load HH
    currentHH = load(sprintf(currentFolder,'HH.mat'));
    currentHH = currentHH.HH;
    % load SH
    currentSH = load(sprintf(currentFolder,'SH.mat'));
    currentSH = currentSH.SH;
    % load HS
    currentHS = load(sprintf(currentFolder,'HS.mat'));
    currentHS = currentHS.HS;
    
    % stack .mat files
    SSCombined{i} = currentSS;
    HHCombined{i} = currentHH;
    SHCombined{i} = currentSH;
    HSCombined{i} = currentHS;
    
    % update minumum number of proposals generated
    minN = min(min(min(min(minN,numel(currentSS.jaccardIndexArray)),numel(currentHH.jaccardIndexArray)),...
        numel(currentSH.jaccardIndexArray)),numel(currentHS.jaccardIndexArray));
end

% define top K proposals to consider
K = min(100,minN);
SSPlot = zeros(N,K);
HHPlot = zeros(N,K);
SHPlot = zeros(N,K);
HSPlot = zeros(N,K);
maxSSAverage = 0;
maxSHAverage = 0;
maxHSAverage = 0;
maxHHAverage = 0;
for i = 1:N
    maxSSAverage = maxSSAverage + SSCombined{i}.bestJaccardIndex;
    maxSHAverage = maxSHAverage + SHCombined{i}.bestJaccardIndex;
    maxHSAverage = maxHSAverage + HSCombined{i}.bestJaccardIndex;
    maxHHAverage = maxHHAverage + HHCombined{i}.bestJaccardIndex;
    for k = 1:K
        SSPlot(i,k) = max(SSCombined{i}.jaccardIndexArray(1:k));
        HHPlot(i,k) = max(HHCombined{i}.jaccardIndexArray(1:k));
        HSPlot(i,k) = max(HSCombined{i}.jaccardIndexArray(1:k));
        SHPlot(i,k) = max(SHCombined{i}.jaccardIndexArray(1:k));
    end
end
maxSSAverage = maxSSAverage / N;
maxSHAverage = maxSHAverage / N;
maxHSAverage = maxHSAverage / N;
maxHHAverage = maxHHAverage / N;

% calculate plot averages
SSPlotAverages = zeros(1,K);
HHPlotAverages = zeros(1,K);
HSPlotAverages = zeros(1,K);
SHPlotAverages = zeros(1,K);

for k = 1:K
    SSPlotAverages(k) = mean(SSPlot(:,k));
    HHPlotAverages(k) = mean(HHPlot(:,k));
    HSPlotAverages(k) = mean(HSPlot(:,k));
    SHPlotAverages(k) = mean(SHPlot(:,k));     
end

% plot all results
h1 = figure(1);plot(1:K,repmat(maxSSAverage,1,K),'--','LineWidth',2);hold on;...
    plot(1:K,repmat(maxHHAverage,1,K),'r--','LineWidth',2);...
    plot(1:K,SSPlotAverages,'LineWidth',3);...
    plot(1:K,HHPlotAverages,'r','LineWidth',3);...
    plot(1:K,SHPlotAverages,'g','LineWidth',3);...
    plot(1:K,HSPlotAverages,'k','LineWidth',3);...
    grid,axis([1 K 0 1]);
legend('Best average CPMC proposal','Best average Hoiem proposal',...
    'CPMC proposal/CPMC ranker','Hoiem proposal/Hoiem ranker',...
    'CPMC proposal/Hoiem ranker','Hoiem proposal/CPMC ranker',...
    'Location','southeast');
xlabel('Top K proposals','FontSize',12,'FontWeight','bold'),...
    ylabel('Average Jaccard Index','FontSize',12,'FontWeight','bold'),...
    title('Cross proposal/ranker analysis','FontSize',12,'FontWeight','bold');

% save high quality plot
export_fig(h1,'rankingComparison.pdf','-transparent','-nocrop');


