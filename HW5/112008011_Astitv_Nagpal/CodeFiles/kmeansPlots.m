K_arr = [1,2,3,4,5,6,7,8,9,10];

% % SSError vs K plot
% xlabel('K values');
% ylabel('Total SSError values');
% title("Total SSError vs K");
% plot(K_arr, SSError_final);
% xlabel('K values');
% ylabel('Total SS Error values');
% title("Total SS Error values vs K");


% p1, p2, p3 vs K plot

plot(K_arr, p1_final);
hold on
plot(K_arr, p2_final);
hold on
plot(K_arr, p3_final);
legend('p1','p2','p3');
xlabel('K values');
ylabel('%age p values');
title("P values vs K");
hold off