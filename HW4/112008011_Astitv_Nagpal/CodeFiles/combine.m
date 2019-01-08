% load q2_2_data.mat
% X = [trD,valD];
% y = vertcat(trLb, valLb);


% y_pred_val = w'*valD + b;
% y_pred_val = sign(transpose(y_pred_val));
% accuracy_val = sum(y_pred_val == valLb);
% acc_val = accuracy_val/367;

% HW4_Utils.genRsltFile(w,b,'test', '112008011.mat')

% HW4_Utils.genRsltFile(w,b,'val', 'pred_val2.mat');
% [ap, prec, rec] = HW4_Utils.cmpAP('pred_val2.mat', 'val');

HW4_Utils.genRsltFile(w,b,'test', '112008011.mat')


% X = [trD,valD];
% y = vertcat(trLb, valLb);
% 
% PosD_1 = X(:, 1:176);
% NegD_1 = X(:, 177:362);
% PosD_2 = X(:, 363:545);
% NegD_2 = X(:, 546:729);
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
