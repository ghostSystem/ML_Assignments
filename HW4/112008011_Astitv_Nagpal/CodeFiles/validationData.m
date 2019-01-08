%Testing on Validation Data
w_t = transpose(w);
X_val_t = valD;
X_val = transpose(X_val_t);
y_val = valLb;
y_val_t = transpose(y_val);

y_pred_val = w_t*X_val_t + b;
y_pred_val_t = sign(transpose(y_pred_val));
acc_val = sum(y_pred_val_t == valLb);
acc_val = acc_val/size(valLb,1);

disp("\nBelow values are for C = 10\n\n");

fprintf("Accuracy = %d", acc_val);
fprintf("\nObjective Function Value For Training data: %d\n", obj);
fprintf("\nObjective Function Value For Validation data: %d\n", obj_val);
count = 0;
for i = 1:size(alpha,1)
    if alpha(i) > 0
        count = count + 1;
    end
end
fprintf("Number of Support Vectors : %d\n\n", count);

C = confusionmat(valLb,y_pred_val_t);
disp("Confusion Matrix");
disp(C);
X_t = double(valD);
X = transpose(X_t);
y = double(valLb);
y_t = transpose(y);
X_dot = X*X_t;
y_dot = y*y_t;
H = y_dot.*X_dot;
H = (H+H')/2;



