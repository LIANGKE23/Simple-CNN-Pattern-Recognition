function [filename] = getfilename2(folderpath,dataset,whichimage)
filename1 = "_aug_";
filename4 = strcat(filename1,".png");
filename5 = char(dataset.Labels(whichimage));
filename6 = strcat(folderpath, '/');
filename7 = strcat(filename6, filename5, '/', filename5);
filename8 = string(whichimage);
filename9 = strcat(filename7,filename8,filename4);
filename = filename9;
end

