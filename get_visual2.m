%% Get visualization 2 tsen
%% click data.mat to load the train, test set first
%% click the net.mat for net

%% Examples of what I offer in the folder
%% For example skinny_test_aug_data.mat is for augdata used by skinny testing, 
%% (skinny_train_aug_data.mat,skinny_val_aug_data.mat)
%% skinny_test_data.mat is for the original data used by skinny testing
%% (skinny_train_data.mat,skinny_val_data.mat)
%% So does the wide network, check the folder, the laws of naming is same
%% to load it to the workspace and skinny_network1_ori.mat is for skinny 
%% network (wide_network1_ori.mat is for wide network.mat)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% layer = 'fc_2' %% for wide network and skinny network
layer = 'fc8'%% for alexnet

%% for train set (uncomment this part)
% featuresTrain = activations(net1,train,layer,'OutputAs','rows');%% for wide network and skinny network
% featuresTrain = activations(net,train,layer,'OutputAs','rows');%% for alexnet
% Y1 = tsne(featuresTrain);
% figure(1);
% gscatter(Y1(:,1), Y1(:,2), train.Labels);
% title('gscatter');

%% for val set(uncomment this part)
% featuresVal = activations(net1,val,layer,'OutputAs','rows');%% for wide network and skinny network
% featuresVal = activations(net,val,layer,'OutputAs','rows');%% for alexnet
% Y2 = tsne(featuresVal);
% figure(2);
% gscatter(Y2(:,1), Y2(:,2), val.Labels);
% title('gscatter');

%% for test set(uncomment this part)
% featuresTest = activations(net1,test,layer,'OutputAs','rows');%% for wide network and skinny network
% featuresTest = activations(net,test,layer,'OutputAs','rows');%% for alexnet
% Y3 = tsne(featuresTest);
% figure(3);
% gscatter(Y3(:,1), Y3(:,2), test.Labels);
% title('gscatter');