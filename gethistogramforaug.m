%% First print (clear all)
%% Then follow the step below
%% click Times.mat(in my work I save data_augmentation_Times.mat) 
%% click Biasy.mat(in my work I save data_augmentation_Biasy.mat)
%% click Biasx.mat(in my work I save data_augmentation_Biasx.mat)
%% clcik Angle.mat(in my work I save data_augmentation_angle.mat)
%% After that we load all the mat files.
figure(1);
xlabel("degree")
title("Histogram of angles")
Angle(find(Angle==0))= [];
hist(Angle,36);
figure(2)
xlabel("scale times")
title("Histogram of scale")
Times(find(Times==0))= [];
hist(Times,10);
figure(3)
xlabel("x transition")
title("Histogram of x transition")
Biasx(find(Biasx==0))= [];
hist(Biasx,10);
figure(4)
xlabel("y transition")
title("Histogram of y transition")
Biasy(find(Biasy==0))= [];
hist(Biasy,10);