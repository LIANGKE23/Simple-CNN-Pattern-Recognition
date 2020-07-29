%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% step 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run on Matlab2017

% Based on the main_matlab.m, follow the readme file and the comments in 
% main_matlab.m

% run main_matlab.m, making the batchsize for 75, the first 
% learning rate is 1e-4 and the second learning rate is 1e-5. 
% Choose imageInputLayer([256 256 1]) 
% Choose train_folder = 'train'; test_folder  = 'test';
% You can get process_original_results_batchsize75.txt mannually.

% run main_matlab.m, making the batchsize for 100, the first 
% learning rate is 1e-4 and the second learning rate is 1e-5. 
% Choose imageInputLayer([256 256 1]) 
% Choose train_folder = 'train'; test_folder  = 'test';
% You can get process_original_results_batchsize75.txt mannually.

% Save the .mat files you need manually.

% Since I run the code in matlab on servers when I use the code to get the figures,
% it will come up an error.
% Get the accuracy and loss figures, use "plotTrainingAccuracy_All(info,numEpochs)"
% You can find the numEpochs in the code and process.txt
% If you want to show the heatmap, load the mat files for the classification
% and using the heatmap function, such as "heatmap(test_class)" to show the figure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% step 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  PART1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run data_augmentation.m on MatlabR2019, and Then save the Times.mat, 
% Angle.mat, Biasx.mat, and Biasy.mat manually.
% Note:
The reason for using 2 verison of matlab is because I used the matlab2019 
first while since for the cuda9.1 cannot be recognized by 19 then I use 17 
to do all the training, testing again. While for the dataaugmention.m because 
of the error for 17 cannot recognize the imwrite function (I don't know why)
So for efficient I directly use the matlab 2019 to do data part.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  PART2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run on Matlab2017

% run main_matlab.m, making the batchsize for 75, the first 
% learning rate is 1e-4 and the second learning rate is 1e-5. 
% Choose imageInputLayer([128 128 1]) 
% Choose train_folder = 'train_aug'; test_folder  = 'test_aug';
% You can get process_original_aug_results.txt mannually.

% Save the .mat files you need.

% Since I run the code in matlab on servers when I use the code to get the figures,
% it will come up an error.
% Get the accuracy and loss figures, use "plotTrainingAccuracy_All(info,numEpochs)"
% You can find the numEpochs in the code and process.txt
% If you want to show the heatmap, load the mat files for the classification
% and using the heatmap function, such as "heatmap(test_class)" to show the figure.

% gethistogramforaug.m is used to get histogram of the parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% step 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  PART1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run on Matlab2017

% run sknny_matlab.m, making the batchsize for 75, the first 
% learning rate is 1e-4 and the second learning rate is 1e-5. 
% Choose imageInputLayer([128 128 1]) 
% Choose train_folder = 'train_aug'; test_folder  = 'test_aug';
% You can get process_skinny_network_aug.txt mannually.

% run sknny_matlab.m, making the batchsize for 75, the first 
% learning rate is 1e-4 and the second learning rate is 1e-5. 
% Choose imageInputLayer([256 256 1]) 
% Choose train_folder = 'train'; test_folder  = 'test';
% You can get process_skinny_network.txt mannually.

% Use show_first_layer.m to get the first conv_1 layer

% Use get_visual2.m to get the tsen figures

% Save the .mat files you need.

% Since I run the code in matlab on servers when I use the code to get the figures,
% it will come up an error.
% Get the accuracy and loss figures, use "plotTrainingAccuracy_All(info,numEpochs)"
% You can find the numEpochs in the code and process.txt
% If you want to show the heatmap, load the mat files for the classification
% and using the heatmap function, such as "heatmap(test_class)" to show the figure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  PART2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run on Matlab2017

% run wide_matlab.m, making the batchsize for 75, the first 
% learning rate is 1e-3 and the second learning rate is 5e-4. 
% Choose imageInputLayer([128 128 1]) 
% Choose train_folder = 'train_aug'; test_folder  = 'test_aug';
% Choose numEpochs=30
% You can get process_wide_network_aug.txt mannually.

% run wide_matlab.m, making the batchsize for 75, the first 
% learning rate is 1e-3 and the second learning rate is 5e-4. 
% Choose imageInputLayer([256 256 1]) 
% Choose train_folder = 'train'; test_folder  = 'test';
% Choose numEpochs=15
% You can get process_wide_network.txt mannually.

% Use show_first_layer.m to get the first conv_1 layer

% Use get_visual2.m to get the tsen figures

% Save the .mat files you need.

% Since I run the code in matlab on servers when I use the code to get the figures,
% it will come up an error.
% Get the accuracy and loss figures, use "plotTrainingAccuracy_All(info,numEpochs)"
% You can find the numEpochs in the code and process.txt
% If you want to show the heatmap, load the mat files for the classification
% and using the heatmap function, such as "heatmap(test_class)" to show the figure.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  PART3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For the finetune part, we use alexnet network to do this part.

% First get the new format for the first layer of alexnet network by using 
% Build_data_alexnet.m to get the new format of 227x227x3 on Matlab2019R

% Then directly using alexnet_finetune.m to run on the dataset we build 
% before on Matlab2017

% You can get process_alexnet_network.txt mannually.

% Use show_first_layer.m to get the first conv_1 layer

% Use get_visual2.m to get the tsen figures

% Save the .mat files you need.

% Since I run the code in matlab on servers when I use the code to get the figures,
% it will come up an error.
% Get the accuracy and loss figures, use "plotTrainingAccuracy_All(info,numEpochs)"
% You can find the numEpochs in the code and process.txt
% If you want to show the heatmap, load the mat files for the classification
% and using the heatmap function, such as "heatmap(test_class)" to show the figure.
