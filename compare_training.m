% compare training
clc
clear all
% create stitched segmented images
% load net
model_folder= 'C:\Users\NeuroBeast\Desktop\comparison\fcn_segnet';
addpath(model_folder);
model_name_mat1 = 'fcn8s__1.mat';
model_name_mat2 = 'fcn8s__2.mat';
model_name_mat3 = 'fcn8s__3.mat';
model_name_mat4 = 'segnet__1.mat';
model_name_mat5=  'segnet__2.mat';
model_name_mat6=  'segnet__3.mat';
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
%
information_2=network2.infor;
validation2_accuracy=information_2.ValidationAccuracy;
%
information_3=network3.infor;
validation3_accuracy=information_3.ValidationAccuracy;
training3_accuracy=information_3.TrainingAccuracy;
%
information_4=network4.infor;
validation4_accuracy=information_4.ValidationAccuracy;
training4_accuracy=information_4.TrainingAccuracy;
validation4_accuracy=(validation4_accuracy+validation3_accuracy)./2;
% %}
% %
information_5=network5.infor;
validation5_accuracy=information_5.ValidationAccuracy;
training5_accuracy=information_5.TrainingAccuracy;
%
information_6=network6.infor;
validation6_accuracy=information_6.ValidationAccuracy;
training6_accuracy=information_6.TrainingAccuracy;
%
average1=(validation1_accuracy+validation2_accuracy+validation3_accuracy)./3;
average2=(validation4_accuracy+validation5_accuracy+validation6_accuracy)./3;
f=figure;
p1=plot(smooth(average1,0.001),'LineWidth',1.5,'Color','r');
hold on
p2=plot(smooth(average2,0.001),'LineWidth',1.5,'Color','b');
%p3=plot(smooth(validation3_accuracy,0.001),'LineWidth',1.5,'Color','g');
%p4=plot(smooth(validation4_accuracy,0.001),'LineWidth',1.5,'Color','y');
% p5=plot(smooth(validation5_accuracy,0.001),'LineWidth',1.5,'Color','m');
% p6=plot(smooth(validation6_accuracy,0.001),'LineWidth',1.5,'Color','k');
hold off
ylim([70 90]);
xlim([5000 6500]);
leg=legend([p1 p2],{'FCN-8s','SegNet'});
leg.Location = 'south';
set(leg,'units','normalized');
%set(leg,'position','best');
figurename='FCN and SegNet';
xlabel('Training iterations');
ylabel('Validation accuracy');
title(figurename);
figurenamefull=strcat(figurename,'.png');
saving_folder=model_folder;
figuresavename=fullfile(saving_folder,figurenamefull);
saveas(f,figuresavename);
disp('end')