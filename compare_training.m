% compare training
clc
clear all
% create stitched segmented images
% load net
model_folder= '../trained models/20180828';
addpath(model_folder);
model_name_mat1 = '5 stages Unet cross entropy_train_case2+case3 large train original_validate_case2+case3 large test original__epoches300_learnrate0.1_netwidth48.mat';
model_name_mat2 = 'attention_network_5stages_new_new_train_case2+case3 large train original_validate_case2+case3 large test original_fb loss fb=1_epoches300_learnrate0.1_netwidth48.mat';
model_name_mat3 = 'resnet8_Unet_v1_attention_v1_3_new_new_train_case2+case3 large train original_validate_case2+case3 large test original_fb loss fb=1.5_epoches300_learnrate0.1_netwidth48.mat';
model_name_mat4 = 'resnet8_Unet_v1_attention_v1_4_new_new_train_case2+case3 large train original_validate_case2+case3 large test original_fb loss fb=0_epoches300_learnrate0.1_netwidth48.mat';
model_name_mat5=  'resnet8_Unet_v1_attention_v1_4_new_new_train_case2+case3 large train original_validate_case2+case3 large test original_fb =1_300epochs_netwidth48.mat';
model_name_mat6=  'fcn8s__netwidth48_1.mat';
%[f_model,model_name,ext_model]=fileparts(model_name_mat);
%mkdir('C:\Users\NeuroBeast\Desktop\results 20180822',model_name);
model_file1=fullfile(model_folder,model_name_mat1);
network1=load (model_file1);
model_file2=fullfile(model_folder,model_name_mat2);
network2=load (model_file2);
model_file3=fullfile(model_folder,model_name_mat3);
network3=load (model_file3);
model_file4=fullfile(model_folder,model_name_mat4);
network4=load (model_file4);
model_file5=fullfile(model_folder,model_name_mat5);
network5=load (model_file5);
model_file6=fullfile(model_folder,model_name_mat6);
network6=load (model_file6);
%
information_1=network1.infor;
validation1_accuracy=information_1.ValidationAccuracy;
training1_accuracy=information_1.TrainingAccuracy;
%
information_2=network2.infor;
validation2_accuracy=information_2.ValidationAccuracy;
training2_accuracy=information_2.TrainingAccuracy;
% %
information_3=network3.infor;
validation3_accuracy=information_3.ValidationAccuracy;
training3_accuracy=information_3.TrainingAccuracy;
%
information_4=network4.infor;
validation4_accuracy=information_4.ValidationAccuracy;
training4_accuracy=information_4.TrainingAccuracy;
%}
%
information_5=network5.infor;
validation5_accuracy=information_5.ValidationAccuracy;
training5_accuracy=information_5.TrainingAccuracy;
%
information_6=network6.infor;
validation6_accuracy=information_6.ValidationAccuracy;
training6_accuracy=information_6.TrainingAccuracy;
%
f=figure;
p1=plot(smooth(validation1_accuracy,0.001),'LineWidth',1.5,'Color','r');
hold on
p2=plot(smooth(validation2_accuracy,0.001),'LineWidth',1.5,'Color','b');
p3=plot(smooth(validation3_accuracy,0.001),'LineWidth',1.5,'Color','g');
p4=plot(smooth(validation4_accuracy,0.001),'LineWidth',1.5,'Color','y');
p5=plot(smooth(validation5_accuracy,0.001),'LineWidth',1.5,'Color','m');
p6=plot(smooth(validation6_accuracy,0.001),'LineWidth',1.5,'Color','k');
hold off
ylim([72 94]);
xlim([2000 7500]);
leg=legend([p1 p2 p3 p4 p5 p6],{'U-net',...
                                'attention U-net',...
                                'mixed-attention U-net v4 beta=1.5(proposed)',...
                                'mixed-attention U-net v4 beta=0(proposed)',...
                                'mixed-attention U-net v4 beta=1(proposed)'});
leg.Location = 'south';
set(leg,'units','normalized');
%set(leg,'position','best');
figurename='Comparison of state-of-the-art neural networks';
xlabel('Training iterations');
ylabel('Validation accuracy');
title(figurename);
figurenamefull=strcat(figurename,'.png');
saving_folder='C:\Users\NeuroBeast\Desktop\results 20180829';
figuresavename=fullfile(saving_folder,figurenamefull);
saveas(f,figuresavename);
disp('end')