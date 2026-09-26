syms x11 x12 x13 x14 x21 x22 x23 x24 w1 w2 w3 w4 w5 w11 w12 w13 w14 w15 b11 b12 b13 b14 b21 b22 b23 b24

% Define a small positive constant epsilon
epsilon = 1e-8;  % Adjust as needed

% Define input matrix X, weight matrices W, W1 and bias matrix B
X = [x11, x12; x21, x22];  
W = [w1, w2; w3, w4];  
W1 = [w11, w12; w13, w14];  
B = [b11, b12; b21, b22];   

XW = X * W;
mu = mean(XW, 1);  % Mean value
sigma_sq = var(XW, 0, 1);  % Variance
XW_normalized = (XW - mu) ./ sqrt(sigma_sq + epsilon);  % Batch normalization
XWW1 = XW_normalized * W1;
row_sums_sq = sqrt(sum(XWW1.^2, 2));  % Sum of squares for each row
XWW1_normalized = XWW1 ./ row_sums_sq;  % Row normalization

% Define objective function -Tr((XWW1_normalized)' * B)
objective1 = -trace(XWW1_normalized' * B);

d_objective_dW = jacobian(objective, W);
% Output results
disp('Derivative of the objective function:');
disp(d_objective_dW);
