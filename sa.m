[folder,folderdir]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Select image');
folder=[folderdir,folder];



image=imread(folder);

[J,rect] = imcrop(image);

disp(rect);

figure,imshow(J);