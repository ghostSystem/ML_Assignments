acc_arr = [];
acc_arr2 = [];

% Default Prediction
% model = svmtrain(trLbs, trD', '-t 2 -v 5');
% disp(model)

model = svmtrain(trLbs, trD', '-t 2 -v 5 -g 1 -c 10000');
disp(model);

% for i = 1:10
%     model = svmtrain(trLbs, transpose(trD), ['-t 2 -v 5 -g ' num2str(i/10) ' -c 50']);
%     acc_arr = [acc_arr, model];
% end
% 
% max accuracy at -g = 1
% [val, idx] = max(acc_arr);
% 
% for i = 1:10
%     model = svmtrain(trLbs, transpose(trD), ['-t 2 -v 5 -g ' num2str(idx/10) ' -c ' num2str(i*100)]);
%     acc_arr2 = [acc_arr2, model];
% end
% 
% [val, idx] = max(acc_arr2);
% disp(val);