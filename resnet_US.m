%% training data
clc
clear all
training_folder = uigetdir;
training_data_total = imageDatastore(training_folder,'IncludeSubfolders',true,'LabelSource','foldernames');
[train,test,validate] = splitEachLabel(training_data_total,1800,200,90,'randomized');
%%
net = resnet101;
lgraph = layerGraph(net);
%{
figure('Units','normalized','Position',[0.1 0.1 0.8 0.8]);
plot(lgraph)
%}
net.Layers(1)
lgraph = removeLayers(lgraph, {'fc1000','prob','ClassificationLayer_predictions'});
newLayers = [
    fullyConnectedLayer(3,'Name','new_fc1000','WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classoutput')];
lgraph = addLayers(lgraph,newLayers);
lgraph = connectLayers(lgraph,'pool5','new_fc1000');
%figure('Units','normalized','Position',[0.3 0.3 0.4 0.4]);
%plot(lgraph)
%ylim([0,10])
%% freeze layers
layers = lgraph.Layers;
connections = lgraph.Connections;
%layers(1:311) = freezeWeights(layers(1:311));% up to res4b22 layer, except for res5a,b,c modules
layers(1:333) = freezeWeights(layers(1:333));% up to res5b layer, except for last res modules
lgraph = createLgraphUsingConnections(layers,connections);
%% data augmentation
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore([224 224],train, ...
    'DataAugmentation',imageAugmenter);

%%
%{
opts = trainingOptions('sgdm', ...
    'InitialLearnRate',0.1, ...
    'MaxEpochs',2000,...
    'MiniBatchSize',128,...
    'ValidationData',validate,...
    'ValidationFrequency',40,...
    'LearnRateDropFactor',0.1,...
    'LearnRateDropPeriod',50,...
    'Verbose',false ,...
    'ExecutionEnvironment','multi-gpu',...
    'Plots','training-progress');
%}
opts = trainingOptions('sgdm', ...
    'InitialLearnRate',0.0001, ...
    'MaxEpochs',2000,...
    'MiniBatchSize',256,...
    'ValidationData',validate,...
    'ValidationFrequency',50,...
    'ValidationPatience',10,...
    'Verbose',false ,...
    'LearnRateDropFactor',0.5,...
    'LearnRateDropPeriod',500,...
    'ExecutionEnvironment','multi-gpu',...
    'Plots','training-progress');
[resnetUS,info] = trainNetwork(augimdsTrain, lgraph, opts);
save ('resnet_multi_scales_patches_data_augmentation_AllWeightsNotFrozen.mat','resnetUS')
