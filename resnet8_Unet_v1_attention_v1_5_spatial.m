function [lgraph,networkname]=resnet8_Unet_v1_attention_v1_5_spatial(classes,netWidth,height,width,beta)
% concanetation
% after relu
% spatial
% compatability score used
lgraph=resnet8_Unet(classes,netWidth,height,width,beta);
networkname='resnet8_Unet_v1_attention_v1_5_spatial';
[lgraph]=add_attention_block_spatial_1('s4u1_add','bridge_upconv','concat_bridge','bridge',lgraph,netWidth*8);
[lgraph]=add_attention_block_spatial_2('s3u1_add','bridge_upconv','d4_contac','d4',lgraph,netWidth*4,2);
[lgraph]=add_attention_block_spatial_2('s2u1_add','bridge_upconv','d3_contac','d3',lgraph,netWidth*2,4);
[lgraph]=add_attention_block_spatial_2('s1u1_add','bridge_upconv','d2_contac','d2',lgraph,netWidth*1,8);
[lgraph]=add_attention_block_spatial_2('convInp','bridge_upconv','d1_contac','d1',lgraph,netWidth*1,16);
%analyzeNetwork(lgraph);
end