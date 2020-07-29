%% You have to use matlab 2019 to get the data first. I first use 
%% the data, while matlab 2019 cannot recognize the cuda9.1, So based
%% on the data, I reused matlab 2017 to run. while I find imwrite()
%% cannot work on matlab2017, so if you want to get the data, using 
%% version 2019.

clc;clear;close all;

augmentation_times_train = 5;
augmentation_times_test = 1;
%%%%%%%%%%%%get the data copy from main_matlab which is a start code%%%%%%%
dataDir = './data/wallpapers/';
checkpointDir = 'modelCheckpoints';
rng(1)
Symmetry_Groups = {'P1', 'P2', 'PM' ,'PG', 'CM', 'PMM', 'PMG', 'PGG', 'CMM',...
    'P4', 'P4M', 'P4G', 'P3', 'P3M1', 'P31M', 'P6', 'P6M'};
train_folder = 'train';
test_folder  = 'test';
train_all = imageDatastore(fullfile(dataDir,train_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
train_all.Labels = reordercats(train_all.Labels,Symmetry_Groups);
test = imageDatastore(fullfile(dataDir,test_folder),'IncludeSubfolders',true,'LabelSource',...
    'foldernames');
test.Labels = reordercats(test.Labels,Symmetry_Groups);
%%%%%%%%%%%%%%%%%%%%%%%
%% build new folder
trainaug_folder = './data/wallpapers/train_aug';
if ~exist(trainaug_folder,'dir')
    mkdir(trainaug_folder);
end

ncat = categories(train_all.Labels);
numberofcat = size(ncat,1);
for i=1:numberofcat
    cat_dir1 = strcat(trainaug_folder,'/');
    cat_dir2 = char(ncat(i));
    cat_dir = strcat(cat_dir1,cat_dir2);
    if ~exist(cat_dir,'dir')
        mkdir(cat_dir);
    end
end

testaug_folder = './data/wallpapers/test_aug';
if ~exist(testaug_folder,'dir')
    mkdir(testaug_folder);
end

ncat = categories(test.Labels);
numberofcat = size(ncat,1);
for i=1:numberofcat
    cat_dir1 = strcat(testaug_folder,'/');
    cat_dir2 = char(ncat(i));
    cat_dir = strcat(cat_dir1,cat_dir2);    
    if ~exist(cat_dir,'dir')
        mkdir(cat_dir);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%
%%data augmentation
N_train = size(train_all.Files,1) %%number of image in training
N_test = size(test.Files,1) 
Times = zeros(N_train*augmentation_times_train + N_test*augmentation_times_test,augmentation_times_train);
Angle = zeros(N_train*augmentation_times_train + N_test*augmentation_times_test,augmentation_times_train);
Biasx = zeros(N_train*augmentation_times_train + N_test*augmentation_times_test,augmentation_times_train);
Biasy = zeros(N_train*augmentation_times_train + N_test*augmentation_times_test,augmentation_times_train);
%data augmentation in train set
for i = 1:N_train
    for j = 1:augmentation_times_train
       %% get random value for scale, rotate and translate
        times = 1.5 + 0.5*rand;%for scale
        angle = 360*rand;%for rotate
        biasx = round(10 + 10*randi([-1 1],1)*rand);%for translate x
        biasy = round(10 + 10*randi([-1 1],1)*rand);%for translate y
        Times(i,j) = times;
        Angle(i,j) = angle;
        Biasx(i,j) = biasx;
        Biasy(i,j) = biasy;
        [times angle biasx biasy]
       %% augmentation
        Formal_img = imread(train_all.Files{i,1});
        rect_orig = [64 64 127 127];
        
        %scale first
        Scale_img = imresize(Formal_img, times);
%         imshow(Scale_img)
        %rotate
        Rotate_img = imrotate(Scale_img,angle,'bilinear','crop');
%         imshow(Rotate_img)
        %translation
        rect = rect_orig + [biasx biasy 0 0];
        %crop
        Crop_img = imcrop(Rotate_img, rect);
%         imshow(Crop_img)
        filename = getfilename(trainaug_folder,train_all,i,j)      
        imwrite(Crop_img, filename);    
    end
end
%data augmentation in test set
for i = 1:N_test
    for j = 1:augmentation_times_test
       %% get random value for scale, rotate and translate
        times = 1.5 + 0.5*rand;%for scale
        angle = 360*rand;%for rotate
        biasx = round(10 + 10*randi([-1 1],1)*rand);%for translate x
        biasy = round(10 + 10*randi([-1 1],1)*rand);%for translate y
        Times(N_train+i,j) = times;
        Angle(N_train+i,j) = angle;
        Biasx(N_train+i,j) = biasx;
        Biasy(N_train+i,j) = biasy;
        [times angle biasx biasy];
       %% augmentation
        Formal_img = imread(test.Files{i,1});
        rect_orig = [64 64 127 127];
        
        %scale first
        Scale_img = imresize(Formal_img, times);
%         imshow(Scale_img)
        %rotate
        Rotate_img = imrotate(Scale_img,angle,'bilinear','crop');
%         imshow(Rotate_img)
        %translation
        rect = rect_orig + [biasx biasy 0 0];
        %crop
        Crop_img = imcrop(Rotate_img, rect);
%         imshow(Crop_img)
        filename = getfilename(testaug_folder,test,i,j)
        imwrite(Crop_img, filename);    
    end
end

