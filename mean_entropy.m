clc
clear all
%%
folder = 'C:\Users\NeuroBeast\Desktop\case1video1_size_15_30_rectangle_y\Others';
allfiles=dir(fullfile(folder,'*.jpg'));
allfiles={allfiles.name};
entropy_mean = 0;
entropy_imgs = [];
for i=1:length(allfiles)
    file=allfiles{i};
    img_file=fullfile(folder,file);
    img=imread(img_file);
    e = entropy(img);
    entropy_imgs(end+1)=e;
    entropy_mean=entropy_mean+e;
end
entropy_mean=entropy_mean/(length(allfiles));
entropy_std = std(entropy_imgs);
fprintf('The mean entropy of images is %d',entropy_mean);
fprintf('\n\n');
fprintf('The standard deviation entropy of images is %d',entropy_std);