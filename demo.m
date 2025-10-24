clear all;  clc; close all;
warning off;
addpath(genpath('./'));

dataName = 'ALOI';
load(['./multidata/' , dataName, '.mat']);

viewNum = length(X);
labelNum = length(unique(Y)); 
lowFeaNum = 6 * labelNum;

repeatTime = 1;
maxIter = 20;

for view = 1:viewNum
    X{view} = mapstd(X{view}', 0, 1)';      % Do not delete this function
end

for count = 1 : repeatTime

    % ===================== Random Initialization ===================== %
    %     sampleLabel = round(rand(1, sampleNum) * (labelNum - 1)) + 1;
    %     F = sparse(1:sampleNum, sampleLabel, 1, sampleNum, labelNum, sampleNum);
    %     featureLabel = round(rand(1, lowFeaNum) * (labelNum - 1)) + 1;
    %     Z = sparse(1:lowFeaNum, featureLabel, 1, lowFeaNum, labelNum, lowFeaNum);

    % ============ Reproducible Initialization for FOCUS1 ============= %
    load(['./Initial/',dataName, '1.mat']);

    disp('========================== The Performance of FOCUS1 =========================');
    disp('||   ACC   ||   NMI   || Purity || F-score ||   Pre   ||  Recall  ||  ARI   ||');
    preY1 = main1(X, Y, F, Z, lowFeaNum, maxIter); result1 = Clustering8Measure(Y, preY1);
    fprintf('||  %.4f ||  %.4f || %.4f || %.4f  || %.4f  ||  %.4f  || %.4f ||\n', result1(1,1:7));

    % ============ Reproducible Initialization for FOCUS2 ============= %
    load(['./Initial/',dataName, '2.mat']);

    disp('========================== The Performance of FOCUS2 =========================');
    disp('||   ACC   ||   NMI   || Purity || F-score ||   Pre   ||  Recall  ||  ARI   ||');
    preY2 = main2(X, Y, F, Z, lowFeaNum, maxIter); result2 = Clustering8Measure(Y, preY2);
    fprintf('||  %.4f ||  %.4f || %.4f || %.4f  || %.4f  ||  %.4f  || %.4f ||\n', result2(1,1:7));
    disp('==============================================================================');

end
