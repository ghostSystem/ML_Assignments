function [w,b, alpha, obj] = ques2(X_train, y_train, c_val)
X_t = double(X_train);
X = transpose(X_t);
y = double(y_train);
y_t = transpose(y);
X_dot = X*X_t;
y_dot = y*y_t;
H = y_dot.*X_dot;
[m,n] = size(H);
f = -ones(1,m);
A = [];
b = [];
Aeq = y_t;
beq = 0;
LB = zeros(m,1);
UB = c_val*ones(m,1);
[alpha, obj] = quadprog(H,f,A,b,Aeq,beq,LB,UB);
obj = obj*-1;
for i = 1:size(alpha,1)
    if alpha(i) <= 0.00001
        alpha(i) = 0;
    end
end
alpha_t = transpose(alpha);
temp_w = alpha_t.*X_t;
w = temp_w*y;
w_t = transpose(w);

ind = 0;
for n = 1:length(alpha)
    if alpha(n) < vpa(c_val)
        ind = n;
        break
    end
end

b = y(ind) - w_t*X_t(:, ind);


y_pred = w_t*X_t + b;
y_pred_t = sign(transpose(y_pred));
accuracy = sum(y_pred_t == y_train);
acc_train = accuracy/size(y_train,1);
disp(acc_train);
end
