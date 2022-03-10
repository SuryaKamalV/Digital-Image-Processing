I = imread("hibiscus 1.jpeg");
%% RGB color space
rmat=I(:,:,1);
gmat=I(:,:,2);
bmat=I(:,:,3);
figure(1);
subplot(2,2,1);imshow(rmat);title('Red plane');
subplot(2,2,2);imshow(gmat);title('green plane');
subplot(2,2,3);imshow(bmat);title('blue plane');
subplot(2,2,4);imshow(I);title('original image');
 
%%
figure(2);
levelr =0.63;
levelg =0.5;
levelb =0.4;
i1 = im2bw(rmat,levelr);
i2 = im2bw(gmat,levelg);
i3 = im2bw(bmat,levelb);
Isum =(i1&i2&i3);
subplot(2,2,1);imshow(i1);title('Red plane');
subplot(2,2,2);imshow(i2);title('green plane');
subplot(2,2,3);imshow(i3);title('blue plane');
subplot(2,2,4);imshow(Isum);title('sum of all planes');
%%morphology 
%% fill holes and complement image
Icomp = imcomplement(Isum);
Ifilled = imfill(Icomp,'holes');
figure(3);
imshow(Ifilled);
 
%%structuring element
se = strel('disk',100);
Iopenned = imopen(Ifilled,se);
figure(4);
imshow(Iopenned);
 
%%extract features
Iregion =regionprops(Iopenned, 'centroid');
[labeled,num] =bwlabel(Iopenned,4);
stats = regionprops(labeled,'Eccentricity','Area','BoundingBox','centroid','Filledarea','FilledImage','Image','PixelIdxList','SubarrayIdx');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];
 
%%use feature analysis to count skittles objects
idxofskittles =find(eccentricities);
statsDefects = stats(idxofskittles);
figure(5);
subplot(1,2,1);imshow(Iopenned);title('segmented image');
subplot(1,2,2);imshow(I);title('Original image');
hold on;
for idx = 1 : length(idxofskittles)
    h = rectangle('position',statsDefects(idx).BoundingBox)
    set(h,'EdgeColor',[.75 0 0]);
    hold on;
end
if idx>1
    title(['There are',num2str(num),'objects in the image'])
end
hold off;
 
 
%%structuring element
se = strel('disk',50);
Iopenned = imopen(Ifilled,se);
figure(6);
imshow(Iopenned);
 
%%extract features
Iregion =regionprops(Iopenned, 'centroid');
[labeled,num] =bwlabel(Iopenned,4);
stats = regionprops(labeled,'Eccentricity','Area','BoundingBox','centroid','Filledarea','FilledImage','Image','PixelIdxList','SubarrayIdx');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];
 
%%use feature analysis to count skittles objects
idxofskittles =find(eccentricities);
statsDefects = stats(idxofskittles);
figure(7);
subplot(1,2,1);imshow(Iopenned);title('segmented image');
subplot(1,2,2);imshow(I);title('Original image');
hold on;
for idx = 1 : length(idxofskittles)
    h = rectangle('position',statsDefects(idx).BoundingBox)
    set(h,'EdgeColor',[.75 0 0]);
    hold on;
end
if idx>1
    title(['There are',num2str(num),'flowers in the image'])
end
hold off;