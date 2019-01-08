[trD, trLb, valD, valLb, trRegs, valRegs] = HW4_Utils.getPosAndRandomNeg();

obj_func = [];
ap_list = [];

X = trD;
y = trLb;
for i = 1:size(trLb)
    if trLb(i) == 1
        p = i;
    end
end
PosD = X(:, 1:p);
NegD = X(:, p+1:i);

% X = [trD,valD];
% y = vertcat(trLb, valLb);
% 
% PosD_1 = X(:, 1:176);
% NegD_1 = X(:, 177:362);
% PosD_2 = X(:, 363:545);
% NegD_2 = X(:, 546:729);
% 
% PosD = [PosD_1,PosD_2];
% NegD = [NegD_1,NegD_2];
% 
% PosY_1 = y(1:176,:);
% NegY_1 = y(177:362,:);
% PosY_2 = y(363:545,:);
% NegY_2 = y(546:729,:);
% PosY = vertcat(PosY_1, PosY_2);
% NegY = vertcat(NegY_1, NegY_2);
% 
% X = [PosD,NegD];
% y = vertcat(PosY, NegY);

A = [];
B = [];
[w, b, alpha, obj] = ques2(X, y, 10);
X_train = X;
y_train = y;
tempNegD = NegD;
for z=1:10
    fprintf("Iteration : %d\n",z)
    for n = 1:size(alpha,1)
        if alpha(n) == 0 && y_train(n) == -1
            A = X_train(:,n);
            for i = 1:length(size(NegD,2))
                if NegD(:,i) == A(:,:)
                    disp('Inside zero');
                    NegD(:, i) = [];
                end
            end
        end
    end
    B = calculateB(w, b);
    NegD = [NegD, transpose(B)];
    X_train = [PosD, NegD];
    [p,q] = size(X_train)
    y_train = -ones(q,1);
    for j = 1:size(PosD,2)
        y_train(j) = 1;
    end
    [w ,b , alpha, obj] = ques2(X_train, y_train, 10);
    HW4_Utils.genRsltFile(w, b, 'val', 'output_val_hm.mat');
    [ap, ~, ~] = HW4_Utils.cmpAP('output_val_hm.mat', 'val');
    ap_list = [ap_list, ap];
    obj_func = [obj_func, obj];
    
    disp(obj)
end

o_len = [];
for i = 1:size(obj_func,1)
    o_len = [o_len,i];
end
ap_len = [];
for i = 1:size(ap_list,1)
    ap_len = [ap_len,i];
end
plot(ap_len, ap_list);
plot(o_len, obj_func);

