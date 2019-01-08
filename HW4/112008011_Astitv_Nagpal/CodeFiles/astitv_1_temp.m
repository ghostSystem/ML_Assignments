load q2_1_data.mat
X_t = trD;
X = transpose(X_t);
y = trLb;
y_t = transpose(y);
X_dot = X*X_t;
y_dot = y*y_t;
H = y_dot.*X_dot;
[m,n] = size(H);
f = -ones(1,m);
A = zeros(1,m);
b = 0;
Aeq = y_t;
beq = 0;
LB = zeros(m,1);
C = 0.1;
UB = C*ones(m,1);
alpha = quadprog(H,f,A,b,Aeq,beq,LB,UB);
alpha_t = transpose(alpha);
temp_w = alpha_t.*X_t;
w = temp_w*y;
w_t = transpose(w);

ind = 0;
for n = 1:length(alpha)
    if alpha(n) < vpa(0.1)
        ind = n
        break
    end
end
b = y(ind) - w_t*X_t(:, ind);

y_pred = w_t*X_t + b;
y_pred_t = sign(transpose(y_pred));
accuracy = sum(y_pred_t == trLb);
acc_train = accuracy/362;

X_val_t = valD;
X_val = transpose(X_val_t);
y_val = valLb;
y_val_t = transpose(y_val);

y_pred_val = w_t*X_val_t + b;
y_pred_val_t = sign(transpose(y_pred_val));
accuracy_val = sum(y_pred_val_t == valLb);
acc_val = accuracy_val/367;