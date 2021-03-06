function layers = attention_block_spatial_2(tag,channels,upsamplingRatio)
% use concatenation
% when the coarse feature has the different dimensionality with the fine
% features
% compatability score version
layers = [
    transposedConv2dLayer(upsamplingRatio,channels,'Stride',upsamplingRatio,'Name',[tag,'_compatability_mapping'])
    depthConcatenationLayer(2,'Name',[tag,'_attention_addition']) 
    convolution2dLayer(3,channels,'Padding','same','Stride',1,'Name',[tag,'_compatability_mapping_2'])
    reluLayer('Name',[tag,'_attention_relu'])
    batchNormalizationLayer('Name',[tag,'_attention_BN'])
    convolution2dLayer(1,channels,'Stride',1,'Padding','same','Name',[tag,'_compatability_mapping_phi'])
    softmaxLayer('Name',[tag,'_attention_softmax'])
    %normalisation_layer([tag,'_attention_normalisation'])
    depthConcatenationLayer(2,'Name',[tag,'_attention_transition'])
    dotproductLayer_new([tag,'_attention_dotproduct'])
    ];
end