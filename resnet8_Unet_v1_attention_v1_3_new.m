function [lgraph,networkname]=resnet8_Unet_v1_attention_v1_3_new(classes,netWidth,height,width,beta)
% addition
% mixed
% after relu
% compatability score used
lgraph=resnet8_Unet(classes,netWidth,height,width,beta);
networkname='resnet8_Unet_v1_attention_v1_3_new';
[lgraph]=add_attention_block_new('s4u1_add','bridge_upconv','concat_bridge','bridge',lgraph,netWidth*8);
[lgraph]=add_attention_block_new_2('s3u1_add','bridge_upconv','d4_contac','d4',lgraph,netWidth*4,2);
[lgraph]=add_attention_block_new_2('s2u1_add','bridge_upconv','d3_contac','d3',lgraph,netWidth*2,4);
%[lgraph]=add_attention_block('convInp','d1_upconv','d1_contac','d1',lgraph);
%analyzeNetwork(lgraph);
end