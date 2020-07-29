function [accuracy,class] = getconfusionmat(net,whatdata)
YTest = classify(net,whatdata);
accuracy = mean(YTest == whatdata.Labels);
class = confusionmat(YTest,whatdata.Labels);
end