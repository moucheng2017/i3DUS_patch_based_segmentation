function layers = attention_block_v3(tag)
layers = [
    batchNormalizationLayer('Name',[tag,'_attention_BN'])
    reluLayer('Name',[tag,'_attention_relu'])
    softmaxLayer('Name',[tag,'_attention_softmax'])
    depthConcatenationLayer(2,'Name',[tag,'_attention_transition'])
    dotproductLayer([tag,'_attention_dotproduct'])
    additionLayer(2,'Name',[tag,'_attention_addition']);
    ];
end