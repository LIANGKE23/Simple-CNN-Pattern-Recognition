%% Click the save the net.mat files you save for what you want to show
%% For example wide_network1_ori.mat is for wide network, click it 
%% to load it to the workspace then to uncomment the part for skinny or 
%% wide based on which you want
%% skinny_network1_ori.mat is for skinny network.
%% for skinny (uncomment line 7)
% k =20
%% for wide (uncomment line 9)
% k =25
%% for for alexnet (uncomment line 10)
% k = 96
channels = 1:k;
layer = 'conv_1'%% for skiiny and wide
% layer = 'conv1' %%  for alexnet
% I = deepDreamImage(net1,layer,channels) %% for skiiny and wide
I = deepDreamImage(net,layer,channels) %% for alexnet
figure
for i = 1:k
    subplot(5,5,i) %% for skinny and wide
%     subplot(8,12,i) %% for alexnet
    imshow(I(:,:,:,i))
end