function [sampleLabel, obj, F] = main2(X, Y, F, Z, lowFeaNum, maxIter)

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
    
    % ================== Step 2: Update Z ================= %
    lossZ = zeros(lowFeaNum, labelNum);
    for view = 1 : viewNum
        lossZ = lossZ + alpha(view) * EuDist2(W{view}' * X{view}', S' * F', 0);
    end
    [~, featureLabel] = min(lossZ, [], 2);
    Z = sparse(1:lowFeaNum, featureLabel, 1, lowFeaNum, labelNum, lowFeaNum);
    clear lossZ;
    % ===================================================== %

    % ================== Step 3: Update S ================= %
    tempS = zeros(labelNum, labelNum);
    for view = 1 : viewNum
        tempS = tempS + alpha(view) * F' * X{view} * W{view} * Z;
    end
    S = (F' * F + eps*eye(labelNum, labelNum))^-1 * (tempS ./ (sum(alpha)+eps)) * (Z' * Z + eps*eye(labelNum, labelNum))^-1; 
    clear tempS;
    % ===================================================== %

    % ================== Step 4: Update F ================= %
    lossF = zeros(sampleNum, labelNum);
    for view = 1 : viewNum
        lossF = lossF + alpha(view) * EuDist2(X{view}, S * Z' * W{view}', 0);
    end
    [~, sampleLabel] = min(lossF, [], 2);
    F = sparse(1:sampleNum, sampleLabel, 1, sampleNum, labelNum, sampleNum);
    clear lossF;
    % ===================================================== %
    
    % ============= Step 5: Update view weight ============ %
    for view = 1 : viewNum
        alpha(view) = norm(X{view} - F * S * Z' * W{view}', 'fro');
    end
    obj(iter, 1) = sum(alpha);
    alpha = 0.5 ./ alpha;
    % ===================================================== %
    
end