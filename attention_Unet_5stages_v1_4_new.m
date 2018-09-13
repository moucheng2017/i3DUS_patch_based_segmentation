function [lgraph,networkname]=attention_Unet_5stages_v1_4_new(height,width,netwidth)
% compatibility mapping is using 1x1 convolutionl layer
networkname='attention_network_5stages_v1_4_new';
% U net with attention
lgraph = createUnet(5,height,width,netwidth);
larray=imageInputLayer([height width 3],'Name','Input','Normalization','None');
lgraph=replaceLayer(lgraph,'ImageInputLayer',larray);
[lgraph]=add_attention_block_new('Encoder-Stage-5-ReLU-2','Decoder-Stage-1-upBN-1','Decoder-Stage-1-DepthConcatenation','bridge',lgraph,netwidth*16);
[lgraph]=add_attention_block_new_2('Encoder-Stage-4-ReLU-2','Decoder-Stage-1-upBN-1','Decoder-Stage-2-DepthConcatenation','s4',lgraph,netwidth*8,2);
[lgraph]=add_attention_block_new_2('Encoder-Stage-3-ReLU-2','Decoder-Stage-1-upBN-1','Decoder-Stage-3-DepthConcatenation','s3',lgraph,netwidth*4,4);
[lgraph]=add_attention_block_new_2('Encoder-Stage-2-ReLU-2','Decoder-Stage-1-upBN-1','Decoder-Stage-4-DepthConcatenation','s2',lgraph,netwidth*2,8);
%[lgraph]=add_attention_block_new_2('Encoder-Stage-1-ReLU-2','Decoder-Stage-5-upBN-1','Decoder-Stage-5-DepthConcatenation','s1',lgraph,netwidth*1);
%analyzeNetwork(lgraph);
end