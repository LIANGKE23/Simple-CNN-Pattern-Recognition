function [filename] = getfilename(folderpath,dataset,whichimage,augmentation_times)
if mod(whichimage,1000) == 0
    whichimage1 = 1000;
else
    whichimage1 = mod(whichimage,1000);
end
filename1 = "_aug_";
filename2 = string(augmentation_times);
filename3 = strcat(filename1,filename2);
filename4 = strcat(filename3,".png");
filename5 = char(dataset.Labels(whichimage));
filename6 = strcat(folderpath, '/');
filename7 = strcat(filename6, filename5, '/', filename5);
filename8 = strcat('_',string(whichimage1));
filename9 = strcat(filename7,filename8,filename4);
filename = filename9;
end

