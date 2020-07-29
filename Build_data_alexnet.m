%% Build data for alexnet
%%%%%%%%%%%%%%%%%%%%%%%
%% You have to use matlab 2019 to get the data first. I first use 
%% the data, while matlab 2019 cannot recognize the cuda9.1, So based
%% on the data, I reused matlab 2017 to run. while I find imwrite()
%% cannot work on matlab2017, so if you want to get the data, using 
%% version 2019.

clc;clear;close all;
%%%%%%%%%%%%% get the data copy from main_matlab which is a start code %%%
dataDir = './data/wallpapers/';
checkpointDir = 'modelCheckpoints';
rng(1)
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
    'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M', 'P6', 'P6M'};
train_folder = 'train_aug';
test_folder  = 'test_aug';
train_all = imageDatastore(fullfile(dataDir,train_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
train_all.Labels = reordercats(train_all.Labels,Symmetry_Groups);
test = imageDatastore(fullfile(dataDir,test_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
test.Labels = reordercats(test.Labels,Symmetry_Groups);

%%%%%%%%%%%%%%%%%%%%%%%
%% build new folder
trainaug_alexnet_folder = './data/wallpapers/train_aug_alexnet';
if ~exist(trainaug_alexnet_folder,'dir')
    mkdir(trainaug_alexnet_folder);
end

ncat = categories(train_all.Labels);
numberofcat = size(ncat,1);
for i=1:numberofcat
    cat_dir1 = strcat(trainaug_alexnet_folder,'/');
    cat_dir2 = char(ncat(i));
    cat_dir = strcat(cat_dir1,cat_dir2);
    if ~exist(cat_dir,'dir')
        mkdir(cat_dir);
    end
end

testaug_alexnet_folder = './data/wallpapers/test_aug_alexnet';
if ~exist(testaug_alexnet_folder,'dir')
    mkdir(testaug_alexnet_folder);
end

ncat = categories(test.Labels);
numberofcat = size(ncat,1);
for i=1:numberofcat
    cat_dir1 = strcat(testaug_alexnet_folder,'/');
    cat_dir2 = char(ncat(i));
    cat_dir = strcat(cat_dir1,cat_dir2);    
    if ~exist(cat_dir,'dir')
        mkdir(cat_dir);
    end
end

%%resize
N_train = size(train_all.Files,1)
N_test = size(test.Files,1)
for i =1:N_train
    Formal_img_train = imread(train_all.Files{i,1});
    x = imresize(Formal_img_train, (227/128));
    train_alex = repmat(x,[1,1,3]);
    filename = getfilename2(trainaug_alexnet_folder,train_all,i)
    imwrite(train_alex, filename);  
end
for i =1:N_test
      for j = 1:1
        Formal_img_test = imread(test.Files{i,1});
        y = imresize(Formal_img_test, (227/128));
        test_alex = repmat(y,[1,1,3]);
        filename = getfilename(testaug_alexnet_folder,test,i,j)
        imwrite(test_alex, filename); 
      end
end