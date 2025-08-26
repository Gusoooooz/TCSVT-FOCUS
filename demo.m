clear all;  clc; close all;
warning off;
addpath(genpath('./'));

dataName = 'HW';
load(['./multidata/' , dataName, '.mat']);

% ======= For ALOI ======== %
% X{1} = im2double(X{1});   %
% Y = double(Y);            %
% for count = 1 : length(X) %
%     X{count} = X{count}'; %
% end                       %
% ========================= %

viewNum = length(X);
sampleNum = length(Y);
labelNum = length(unique(Y)); 
lowFeaNum = 6 * labelNum;

repeatTime = 20;
maxIter = 20;

for view = 1:viewNum
    X{view} = mapstd(X{view}', 0, 1)';
end


for count = 1 : repeatTime

    disp(num2str(count));

    % ===================== Random Initialization ===================== %
    %     sampleLabel = round(rand(1, sampleNum) * (labelNum - 1)) + 1;
    %     F = sparse(1:sampleNum, sampleLabel, 1, sampleNum, labelNum, sampleNum);
    %     featureLabel = round(rand(1, lowFeaNum) * (labelNum - 1)) + 1;
    %     Z = sparse(1:lowFeaNum, featureLabel, 1, lowFeaNum, labelNum, lowFeaNum);

    % ================== Reproducible Initialization ================== %
    load(['./Initial/',dataName, '.mat']);
    
    % ============================ FOCUS1 ============================= %
    preY1 = main1(X, Y, F, Z, lowFeaNum, maxIter); 
    result1 = Clustering8Measure(Y, preY1);  disp(result1);

    % ============================ FOCUS2 ============================= %
    preY2 = main2(X, Y, F, Z, lowFeaNum, maxIter); 
    result2 = Clustering8Measure(Y, preY2);  disp(result2);

end
