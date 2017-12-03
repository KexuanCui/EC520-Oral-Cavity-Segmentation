%EC520 project
GroundTruth = imread('Images_Ground_Truth/img6_annot.png');
Image = imread('Images/img6.jpg');

% 1. get tissue 
MaskedImage = zeros(size(Image));
[im,jm] = size(Image);
for i=1:im
    for j = 1:jm/3
        if (GroundTruth(i,j)<5) && (GroundTruth(i,j)>0)
            MaskedImage(i,j,1) = Image(i,j,1);
            MaskedImage(i,j,2) = Image(i,j,2);
            MaskedImage(i,j,3) = Image(i,j,3);
        end

    end
end
imwrite(MaskedImage/255,'6/Tissue.jpg')
% MaskedImage 0-255 need to divided by 255 while displaying

% 2. remove Photometric Artifacts (Over exposed protions) 
threshold = 190; %
MaskedImage2 = MaskedImage;
for i=1:im
    for j = 1:jm/3
        if MaskedImage(i,j,1)> threshold && MaskedImage(i,j,2)> threshold && MaskedImage(i,j,3)> threshold
            MaskedImage2(i,j,:) = 0;
        end
    end
end
imwrite(MaskedImage2/255,'6/Tissue-Photometric Artifacts.jpg')

% 3. Select Valid Blocks

rows = floor(im/20);
columns = floor(jm/60);
%blockaverage = zeros(1,1,:);
MaskedImage3= MaskedImage2;
ArrayofRGB = zeros(rows, columns, 3);
ListofRGB =[];
for i = 1:rows
    for j = 1:columns
        blockR = MaskedImage2((i-1)*20+1:i*20,(j-1)*20+1:j*20,1);
        blockG = MaskedImage2((i-1)*20+1:i*20,(j-1)*20+1:j*20,2);
        blockB = MaskedImage2((i-1)*20+1:i*20,(j-1)*20+1:j*20,3);
        if ( max(max(blockR)) > 0) ||  (max(max(blockG)) > 0) ||  (max(max(blockB)) > 0)
            %block has value
            valid = 0;
            novalue = 0;
            for k = 1:20
                for l = 1:20
                    if blockR(k,l) == 0 && blockG(k,l) == 0 && blockB(k,l) == 0
                        %no value
                        novalue = novalue + 1;
                    end
                end
            end
            if novalue < 200
                valid = 1; % block is valid
                %calculate average RGB
                [R,G,B]=averageRGB(blockR,blockG,blockB); 
                ArrayofRGB(i,j,1)=R;
                ArrayofRGB(i,j,2)=G;
                ArrayofRGB(i,j,3)=B;
                RGB=[R G B];
                ListofRGB = [ListofRGB;RGB];
            else
                MaskedImage3((i-1)*20+1:i*20,(j-1)*20+1:j*20,:) = 0;
            end
        end   
    end
end
imwrite(MaskedImage3/255,'6/blocked.jpg')


NonTissueRGB = zeros(rows,columns,3);
ListofNonTRGB = [];
for i = 1:rows
    for j = 1:columns
        blockR1 = Image((i-1)*20+1:i*20,(j-1)*20+1:j*20,1);
        blockG1 = Image((i-1)*20+1:i*20,(j-1)*20+1:j*20,2);
        blockB1 = Image((i-1)*20+1:i*20,(j-1)*20+1:j*20,3);
        [R,G,B]=averageRGB2(blockR1,blockG1,blockB1); 
        RGB = [R G B];
        if ArrayofRGB(i,j,1)== 0 && ArrayofRGB(i,j,2)==0 && ArrayofRGB(i,j,3)==0
            NonTissueRGB(i,j,1)=R;
            NonTissueRGB(i,j,2)=G;
            NonTissueRGB(i,j,3)=B;
            RGB = [R G B];
            ListofNonTRGB = [ListofNonTRGB;RGB];
        else
            NonTissueRGB(i,j,1)=0;
            NonTissueRGB(i,j,2)=0;
            NonTissueRGB(i,j,3)=0;
            RGB = [R G B];
        end
    end
end

figure
scatter3(ListofRGB(:,1),ListofRGB(:,2),ListofRGB(:,3),'.');
hold on;
scatter3(ListofNonTRGB(:,1),ListofNonTRGB(:,2),ListofNonTRGB(:,3),'.','MarkerFaceColor','r');
