y_pred = -inf(10050, 1);
y_final = [];

y_pred_tst = -inf(3190, 1);
y_final_tst = [];

load q2_2_data.mat
X = [trD,valD];
y = vertcat(trLb, valLb);

% for i = 1:10050
%     index = -inf;
%     for j = 1:10
%         y_temp = transpose(w_final(:,j))*X(:, i) + b_final(j);
%         if y_temp > y_pred(i)
%             index = j;
%             y_pred(i) = y_temp;
%         end
%     end
%     y_final = [y_final, index];
% end
% accuracy = sum(y_pred_t == trLb);

% for i = 1:3190
%     index = -inf;
%     for j = 1:10
%         y_temp_tst = transpose(w_final(:,j))*tstD(:, i) + b_final(j);
%         if y_temp_tst > y_pred_tst(i)
%             index = j;
%             y_pred_tst(i) = y_temp_tst;
%         end
%     end
%     y_final_tst = [y_final_tst, index];
% end
% 
% 
% id = [];
% for n=1:3190
%     id = [id, n];
% end
% final = [transpose(id),transpose(y_final_tst)];
% csvwrite('y_pred_tst4.csv',final)
