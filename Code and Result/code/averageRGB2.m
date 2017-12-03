function [ R, G, B ] = averageRGB2( blockR, blockG, blockB )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(blockR);
R = sum(sum(blockR))/m/n;
G = sum(sum(blockG))/m/n;
B = sum(sum(blockB))/m/n;

end

