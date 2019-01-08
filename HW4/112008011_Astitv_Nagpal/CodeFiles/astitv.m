load q2_1_data.mat
X = trD;
y = trLb;
X_t = transpose(X);
y_t = transpose(y);
X_dot = X_t*X;
y_dot = y*y_t;
H = X_dot*y_dot;
[m,n] = size(H);
f = -ones(m,1);
A = zeros(1,m);
b = 0;
Aeq = y_t;
beq = 0;
LB = zeros(m,1);
UB = inf*ones(m,1);
alpha = quadprog(H,f,A,b,Aeq,beq,LB,UB);
alpha_t = transpose(alpha);
temp_w = alpha_t.*X;
w = temp_w*y;
w_t = transpose(w);
b = y_t - w_t*X;
y_pred = w_t*X + b;
y_pred_t = transpose(y_pred);
accuracy = sum(y_pred_t == trLb);
accuracy/362

X_val = valD;
X_val_t = transpose(X_val);
y_val = valLb;
y_val_t = transpose(y_val);

temp_w_val = alpha_t.*X_val;
w_val = temp_w_val*y_val;
w_val_t = transpose(w_val);
b_val = y_val_t - w_val_t*X_val;
y_pred_val = w_val_t*X_val + b_val;
y_pred_val_t = transpose(y_pred_val);
accuracy_val = sum(y_pred_val_t == valLb);
accuracy_val/367





