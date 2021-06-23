close all;clear all;clc;

%%loading datasets
load imgfilldata;

%%Selecting image 
[folder,folderdir]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Select image');

%%Folder creating
folder=[folderdir,folder];



image=imread(folder);

%%cropping image but user must not crop only plate.
[image,rect] = imcrop(image);


[~,siz]=size(image);

%%change images size
image=imresize(image,[300,500]);

%%change image color to gray

   image=rgb2gray(image); 


se=strel('rectangle',[2,2]);
image=imopen(image,se);
figure,imshow(image);
%%detect the gray level
threshold=graythresh(image);

%%make black and white the image
image=im2bw(image,threshold);

imageRev=~image;
figure,imshow(image);
figure,imshow(imageRev),'imrev';


%%clear the image noise
if siz>2000
    %%if image's size bigger than 3500 stay else delete 
    image1=bwareaopen(imageRev,3500);
else
    image1=bwareaopen(imageRev,3000);
end

figure,imshow(image1);

image2=imageRev-image1;

image2=bwareaopen(image2,250);
figure,imshow(image2);

[labels,object]=bwlabel(image2);
objectSpecs=regionprops(labels,'BoundingBox');

hold on
pause(1)

for n=1:size(objectSpecs,1)
    
    rectangle('Position',objectSpecs(n).BoundingBox,'EdgeColor','g','LineWidth',2);
    
end

hold off;
figure

%%Plate characters in this array
finalExit=[];
%%corelation values
t=[];

for n=1:object
   %%search char in labeling image
    [r,c]=find(labels==n);
    character=imageRev(min(r): max(r),min(c): max(c));
    character=imresize(character,[42,24]);
    figure,imshow(character),title('Character');


pause(0:2);
x=[];
%%finding length of characters
charNum=size(images,2);

%%compare object with characters in the database
for k=1:charNum
y=corr2(images{1,k},character);
x=[x y];
end

t=[t max(x)];
if max(x)>0.47
    maxIndex=find(x==max(x));
    
    fin=cell2mat(images(2,maxIndex));
    finalExit=[finalExit,fin];
end
end
disp(finalExit);

foldername='plates.txt';
folder=fopen(foldername,'wt');

fprintf(folder,'%s%n',finalExit);

fclose(folder);
winopen('plates.txt');