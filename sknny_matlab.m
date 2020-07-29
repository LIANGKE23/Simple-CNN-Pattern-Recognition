%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remember to save all the info1.mat, info2.mat, test_class.mat,
%% train_class.mat, val_class.mat, train_class_droppinglr.mat,
%% val_class_droppinglr.mat, and test_class_droppinglr.mat, net1.mat
%% net2.mat, train.mat, test.mat, val.mat net.mat and layer.mat 
%% manually! which is useful for drawing the figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear 
close all
dataDir= './data/wallpapers/';
checkpointDir = 'modelCheckpoints';

rng(1) % For reproducibility
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
    'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M', 'P6', 'P6M'};

% train_folder = 'train';
% test_folder  = 'test';
% uncomment after you create the augmentation dataset
train_folder = 'train_aug';
test_folder  = 'test_aug';
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

%%
rng('default');
numEpochs = 30; 
batchSize = 75;
nTraining = length(train.Labels);

layers = [
    imageInputLayer([128 128 1]); % Input to the network is a 128x128x1 sized image 
%     imageInputLayer([256 256 1]); % Input to the network is a 256x256x1 sized image 

    convolution2dLayer(5,20,'Padding',[0 0],'Stride', [2,2]);  % convolution layer with 20, 5x5 filters
    batchNormalizationLayer()
    reluLayer();  % ReLU layer
    maxPooling2dLayer(2,'Stride',2); % Max pooling layer
    
    convolution2dLayer(5,20,'Padding',[2 2],'Stride', [1,1]);  % convolution layer with 20, 5x5 filters
    batchNormalizationLayer()
    reluLayer();  % ReLU layer
    maxPooling2dLayer(2,'Stride',2); % Max pooling layer
    
    convolution2dLayer(3,40,'Padding',[1 1],'Stride', [1,1]);  % convolution layer with 40, 3x3 filters
    batchNormalizationLayer()
    reluLayer();  % ReLU layer
    maxPooling2dLayer(2,'Stride',2); % Max pooling layer
    
    fullyConnectedLayer(25); % Fullly connected layer with 50 activations
    dropoutLayer(.10); % Dropout layer
    fullyConnectedLayer(17); % Fully connected with 17 layers
    softmaxLayer(); % Softmax normalization layer
    classificationLayer(); % Classification layer
    ];

if ~exist(checkpointDir,'dir'); mkdir(checkpointDir); end
% Set the training options
options = trainingOptions('sgdm','MaxEpochs',20,... 
    'InitialLearnRate',1e-4,...% learning rate
    'CheckpointPath', checkpointDir,...
    'MiniBatchSize', batchSize, ...
    'MaxEpochs',numEpochs);
    % uncommand and add the line below to the options above if you have 
    % version 17a or above to see the learning in realtime
    %'OutputFcn',@plotTrainingAccuracy,... 

% Train the network, info contains information about the training accuracy
% and loss
 t = tic;
[net1,info1] = trainNetwork(train,layers,options);
fprintf('Trained in in %.02f seconds\n', toc(t));

% Test on the training data
[train_acc,train_class] = getconfusionmat(net1,train)
% Test on the validation data
[val_acc,val_class] = getconfusionmat(net1,val)
% Test on the testing data
[test_acc,test_class] = getconfusionmat(net1,test)
% figure(1)
% plotTrainingAccuracy_All(info1,numEpochs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% It seems like it isn't converging ater looking at the graph but lets
%   try dropping the learning rate to show you how.  
options = trainingOptions('sgdm','MaxEpochs',20,...
    'InitialLearnRate',1e-5,... % learning rate
    'CheckpointPath', checkpointDir,...
    'MiniBatchSize', batchSize, ...
    'MaxEpochs',numEpochs);
    % uncommand and add the line below to the options above if you have 
    % version 17a or above to see the learning in realtime
%     'OutputFcn',@plotTrainingAccuracy,...

 t = tic;
[net2,info2] = trainNetwork(train,net1.Layers,options);
fprintf('Trained in in %.02f seconds\n', toc(t));

% Test on the train data
[train_acc_droppinglr,train_class_droppinglr] = getconfusionmat(net2,train)
% Test on the validation data
[val_acc_droppinglr,val_class_droppinglr] = getconfusionmat(net2,val)
% Test on the testing data
[test_acc_droppinglr,test_class_droppinglr] = getconfusionmat(net2,test)

% figure(2)
% plotTrainingAccuracy_All(info2,numEpochs);

% It seems like continued training would improve the scores
