%training
ListofRGB = [];
T1 = load('1/T1.mat');
T2 = load('2/T2.mat');
T3 = load('3/T3.mat');
T4 = load('4/T4.mat');
T5 = load('5/T5.mat');
T6 = load('6/T6.mat');
ListofRGB = [ListofRGB;T1.ListofRGB];
ListofRGB = [ListofRGB;T2.ListofRGB];
ListofRGB = [ListofRGB;T3.ListofRGB];
ListofRGB = [ListofRGB;T4.ListofRGB];
ListofRGB = [ListofRGB;T5.ListofRGB];
ListofRGB = [ListofRGB;T6.ListofRGB];


ListofnonRGB = [];
nonT1 = load('1/nonT1.mat');
nonT2 = load('2/nonT2.mat');
nonT3 = load('3/nonT3.mat');
nonT4 = load('4/nonT4.mat');
nonT5 = load('5/nonT5.mat');
nonT6 = load('6/nonT6.mat');
ListofnonRGB = [ListofnonRGB;nonT1.ListofNonTRGB];
ListofnonRGB = [ListofnonRGB;nonT2.ListofNonTRGB];
ListofnonRGB = [ListofnonRGB;nonT3.ListofNonTRGB];
ListofnonRGB = [ListofnonRGB;nonT4.ListofNonTRGB];
ListofnonRGB = [ListofnonRGB;nonT5.ListofNonTRGB];
ListofnonRGB = [ListofnonRGB;nonT6.ListofNonTRGB];

figure
subplot(1,3,1)
[fR,xiR] = ksdensity(ListofRGB(:,1));
[nonfR,nonxiR]  = ksdensity(ListofnonRGB(:,1));
plot(xiR,fR,'r',nonxiR,nonfR,'black')
title('R channel')

subplot(1,3,2)
[fG,xiG] = ksdensity(ListofRGB(:,2));
[nonfG,nonxiG]  = ksdensity(ListofnonRGB(:,2));
plot(xiG,fG,'g',nonxiR,nonfR,'black')
title('G channel')

subplot(1,3,3)
[fB,xiB] = ksdensity(ListofRGB(:,3));
[nonfB,nonxiB]  = ksdensity(ListofnonRGB(:,3));
plot(xiB,fB,'b',nonxiB,nonfB,'black')
title('B channel')


Image = imread('Images/img8.jpg');
[m,n]=size(Image);

%tesing R channel
xq = 0:1:255;
vq = interp1(xiR,fR,xq);
vqnon = interp1(nonxiR,nonfR,xq);

TestImage = Image;
t = 0; %label tissue/non-tissue
for i = 1:m
    for j = 1:n/3
        R = Image(i,j,1);
        if vq(R+1)/vqnon(R+1) < 2    %non tissue
            TestImage(i,j,:) = 0;
        elseif R > 190
            TestImage(i,j,:) = 0;
        end
    end
end

%tesing G channel
xq = 0:1:255;
vq = interp1(xiG,fG,xq);
vqnon = interp1(nonxiG,nonfG,xq);

t = 0; %label tissue/non-tissue
for i = 1:m
    for j = 1:n/3
        G = Image(i,j,2);
        if vq(G+1)/vqnon(G+1) < 2  %non tissue
            TestImage(i,j,:) = 0;
        elseif G > 190
            TestImage(i,j,:) = 0;
        end
    end
end

%tesing B channel
xq = 0:1:255;
vq = interp1(xiB,fB,xq);
vqnon = interp1(nonxiB,nonfB,xq);

t = 0; %label tissue/non-tissue
for i = 1:m
    for j = 1:n/3
        B = Image(i,j,3);
        if vq(B+1)/vqnon(B+1) < 2  %non tissue
            TestImage(i,j,:) = 0;
        elseif B > 190
            TestImage(i,j,:) = 0;
        end
    end
end

figure
subplot(1,2,1)
imshow(TestImage,[])
subplot(1,2,2)
G = imread('Images_Ground_Truth/img_annot8.png');
imshow(G,[])