% read blocked image
Irgb = imread('Images/img6.jpg');
Ihsv = rgb2hsv(Irgb);
Blockrgb = imread('6/blocked.jpg');

% the size of the image   im   jm/3
[im,jm] = size(Irgb);
rows = floor(im/20);
columns = floor(jm/60);

ListHSVtissue = [];
ListHSVnontissue = [];
for i = 1:rows
    for j = 1:columns
        blockH = Ihsv((i-1)*20+1:i*20,(j-1)*20+1:j*20,1);
        blockS = Ihsv((i-1)*20+1:i*20,(j-1)*20+1:j*20,2);
        blockV = Ihsv((i-1)*20+1:i*20,(j-1)*20+1:j*20,3);
        [H,S,V]=averageRGB2(blockH,blockS,blockV); 
        HSV = [H S V];
        % for testing if this block belong to tissue or non-tissue
        block = Blockrgb((i-1)*20+1:i*20,(j-1)*20+1:j*20,1);
        if sum(block(:)==0) < 200  %tissue
            ListHSVtissue = [ListHSVtissue;HSV];
        else  %non tissue
            ListHSVnontissue = [ListHSVnontissue;HSV];
        end
    end
end

figure
subplot(1,3,1)
[fH,xiH] = ksdensity(ListHSVtissue(:,1));
[nonfH,nonxiH]  = ksdensity(ListHSVnontissue(:,1));
plot(xiH,fH,'r',nonxiH,nonfH,'black')
title('Hue channel')

subplot(1,3,2)
[fS,xiS] = ksdensity(ListHSVtissue(:,2));
[nonfS,nonxiS]  = ksdensity(ListHSVnontissue(:,2));
plot(xiS,fS,'r',nonxiS,nonfS,'black')
title('Saturation channel')

subplot(1,3,3)
[fV,xiV] = ksdensity(ListHSVtissue(:,3));
[nonfV,nonxiV]  = ksdensity(ListHSVnontissue(:,3));
plot(xiV,fV,'r',nonxiV,nonfV,'black')
title('Value channel')

figure
scatter3(ListHSVtissue(:,1),ListHSVtissue(:,2),ListHSVtissue(:,3),'.');
hold on;
scatter3(ListHSVnontissue(:,1),ListHSVnontissue(:,2),ListHSVnontissue(:,3),'.','MarkerFaceColor','r');



Image = imread('Images/img10.jpg');

[m,n]=size(Image);
Imagehsv = rgb2hsv(Image);

%tesing H channel
xq = 0:1/255:1;
vqH = interp1(xiH,fH,xq);
vqnonH = interp1(nonxiH,nonfH,xq);

vqV = interp1(xiV,fV,xq);
vqnonV = interp1(nonxiV,nonfV,xq);

TestImage = Image;
t = 0; %label tissue/non-tissue
for i = 1:m
    for j = 1:n/3
        H = floor(Imagehsv(i,j,1)*255);
        V = Imagehsv(i,j,3);
        if vqH(H+1)/vqnonH(H+1) < 2.5 || V < 0.3  %non tissue
            TestImage(i,j,:) = 0;
        end
    end
end
imwrite(TestImage,'hueresult/10.tif')
figure
imshow(TestImage)
