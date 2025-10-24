function [sampleLabel, obj, F] = main1(X, Y, F, Z, lowFeaNum, maxIter)

% ================== Variable Description ================= %
% == Name == || ======== Meaning ======= || == Dimension == %
%     X_v    ||      Sample Matrix       ||     N * d_v     %
%     W_v    ||     Embedding Matrix     ||     d_v * t     %
%      Z     ||    Feature Label Matrix  ||      t * c      %
%      F     ||    Sample Label Matrix   ||      N * c      %
% ========================================================= %
viewNum = length(X);           % V : the number of views    %
sampleNum = length(Y);         % N ：the number of samples  %
labelNum = length(unique(Y));  % c : the number of clusters %
% ========================================================= %

% ===================== Initialization  =================== %
W = cell(viewNum, 1);                                       %
for i = 1 : viewNum                                         %
    W{i} = zeros(size(X{i}, 2), lowFeaNum); % W_v           %
end                                                         %
alpha = ones(1, viewNum) ./ viewNum;        % view weight   %
S = eye(labelNum, labelNum);                % couple matrix %
% ========================================================= %

obj = zeros(maxIter, 1);

for iter = 1 : maxIter

    % ================= Step 1: Update W_v ================ %
    svdW = F * S * Z';
    for view = 1 : viewNum
        [U_w, ~, V_w] = svd(X{view}' * svdW, 'econ');
        W{view} = U_w * V_w';
    end
    clear svdW;
    % ===================================================== %

    % ================== Step 2: Update F ================= %
    tempF = zeros(labelNum, sampleNum);
    for view = 1 : viewNum
        tempF = tempF + alpha(view) * 2 * S * Z' * W{view}' * X{view}';
    end
    tempF = tempF - sum(alpha) * S * S * Z' * ones(lowFeaNum, sampleNum);
    for sampleCount = 1 : sampleNum
        F(sampleCount, :) = zeros(labelNum,1);
        [~, posi] = max(tempF(:, sampleCount));
        F(sampleCount, posi) = 1;
    end
    clear tempF;
    % ===================================================== %
    
    % ================== Step 3: Update S ================= %
    tempS = zeros(sampleNum, lowFeaNum);
    for view = 1 : viewNum
        tempS = tempS + alpha(view) * X{view} * W{view};
    end
    tempS = diag(F' * tempS * Z ./ (sum(alpha) + eps));
    S = (F' * F * Z' * Z + eps * eye(labelNum, labelNum) )^-1 * diag(tempS);
    clear tempS;
    % ===================================================== %

    % ================== Step 4: Update Z ================= %
    tempZ = zeros(labelNum, lowFeaNum);
    for view = 1 : viewNum
        tempZ = tempZ + alpha(view) * 2 * S * F' * X{view} * W{view};
    end
    tempZ = tempZ - sum(alpha) * S * S * F' * ones(sampleNum, lowFeaNum);
    for feaCount = 1 : lowFeaNum
        Z(feaCount, :) = zeros(labelNum,1);
        [~, posi] = max(tempZ(:, feaCount));
        Z(feaCount, posi) = 1;
    end
    clear tempZ;
    % ===================================================== %
    
    % ============= Step 5: Update view weight ============ %
    for view = 1 : viewNum
        alpha(view) = norm(X{view} - F * S * Z' * W{view}', 'fro');    
    end
    obj(iter, 1) = sum(alpha);
    alpha = 0.5 ./ alpha;
    % ===================================================== %
    
    
end

[~, sampleLabel] = max(F, [], 2);