%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remember to save all the info.mat,test_class.mat,
%% train_class.mat, val_class.mat, net.mat
%% train.mat, test.mat, val.mat, net.mat and layer.mat manually! 
%% which is useful for drawing the figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear 
close all
dataDir= './data/wallpapers/';
checkpointDir = 'modelCheckpoints';

rng(1) % For reproducibility
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
    'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M', 'P6', 'P6M'};
% uncomment after you create the augmentation dataset
train_folder = 'train_aug_alexnet';
test_folder  = 'test_aug_alexnet';
fprintf('Loading Train Filenames and Label Data...'); t = tic;
train_all = imageDatastore(fullfile(dataDir,train_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
train_all.Labels = reordercats(train_all.Labels,Symmetry_Groups);
% Split with validation set
[train, val] = splitEachLabel(train_all,.9);
fprintf('Done in %.02f seconds\n', toc(t));

fprintf('Loading Test Filenames and Label Data...'); t = tic;
test = imageDatastore(fullfile(dataDir,test_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
test.Labels = reordercats(test.Labels,Symmetry_Groups);
fprintf('Done in %.02f seconds\n', toc(t));


net = alexnet;
% analyzeNetwork(net);


rng('default');
numEpochs = 20; % 5 for both learning rates
batchSize = 75;
nTraining = length(train.Labels);


layersTransfer = net.Layers(1:end-3)
layers = [
    layersTransfer
    fullyConnectedLayer(17,'WeightLearnRateFactor',25,'BiasLearnRateFactor',25)
    softmaxLayer
    classificationLayer];

if ~exist(checkpointDir,'dir'); mkdir(checkpointDir); end

options = trainingOptions('sgdm','MaxEpochs',20,... 
    'InitialLearnRate',1e-4,...% learning rate
    'CheckpointPath', checkpointDir,...
     'Shuffle','every-epoch', ...
    'MiniBatchSize', batchSize, ...
    'MaxEpochs',numEpochs,...
     'Verbose',false,...
      'Plots','training-progress')

t = tic;
[netTransfer,info] = trainNetwork(train,layers,options);
fprintf('Trained in in %.02f seconds\n', toc(t));

% Test on the training data
[train_acc,train_class] = getconfusionmat(netTransfer,train)
% Test on the validation data
[val_acc,val_class] = getconfusionmat(netTransfer,val)
% Test on the testing data
[test_acc,test_class] = getconfusionmat(netTransfer,test)
% figure(1)
% plotTrainingAccuracy_All(info,numEpochs);