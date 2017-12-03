function [ R, G, B ] = averageRGB(blockR, blockG, blockB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(blockR);
pixel = 0;
for i = 1:m
    for j = 1:n
        if blockR(i,j) ~= 0 && blockG(i,j) ~= 0 && blockB(i,j) ~= 0 
            pixel = pixel+1;
        end
    end
end
R = sum(sum(blockR))/pixel;
G = sum(sum(blockG))/pixel;
B = sum(sum(blockB))/pixel;


