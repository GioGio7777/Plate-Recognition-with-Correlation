clc;clear;close all;

%%import the folder
fold=dir('Chars');

%%taking folders name
folderName={fold.name};

%%Taking images but we must begin from 3.
folderName=folderName(3:end);

%%2*62 cell data type
images = cell(2,length(folderName));

for i=1:length(folderName)
   
    images(1,i)={imread(['Chars','/',cell2mat(folderName(i))])};
    
    temp=cell2mat(folderName(i));
    
    images(2,i)={temp(1)};
    
end;

save('imgfilldata.mat','images');
clear;



