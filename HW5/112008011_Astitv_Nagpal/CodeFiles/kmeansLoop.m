K=2;
p1_arr = [];
p2_arr = [];
p3_arr = [];
SS_error_arr = []
p1_n = 0;
p1_d = 0;
p2_n = 0;
p2_d = 0;
p1 = 0;
p2 = 0;
p3 = 0;
iter_arr = [];

for z = 1:3
    [Center, Indicator, iter, SS_error] = kmeans(digit, K, 20);
    
    % Calculating p1 p2 and p3
    for i = 1:size(Indicator,1)-1
        for j = i+1:size(Indicator)
            if labels(i) == labels(j)
                p1_d = p1_d + 1;
                if Indicator(i) == Indicator(j)
                    p1_n = p1_n + 1;
                end
            elseif labels(i) ~= labels(j)
                p2_d = p2_d + 1;
                if Indicator(i) ~= Indicator(j)
                    p2_n = p2_n + 1;
                end
            end
        end
    end
    
    p1 = p1_n/p1_d;
    p1 = p1*100;
    p2 = p2_n/p2_d;
    p2 = p2*100;
    p3 = (p1+p2)/2;
    p3 = p3*100;
            
    p1_arr = [p1_arr, p1];
    p2_arr = [p2_arr, p2];
    p3_arr = [p3_arr, p3];
    
    SS_error_arr = [SS_error_arr, SS_error];
    iter_arr = [iter_arr, iter];
    
    K = K+2;
end

fprintf('\nFor K = 2\n');
fprintf('P1 = %d\n', p1_arr(1));
fprintf('P2 = %d\n', p2_arr(1));
fprintf('P3 = %d\n', p3_arr(1));
fprintf('Total SS Error = %d\n', SS_error_arr(1));


fprintf('\n\nFor K = 4\n');
fprintf('P1 = %d\n', p1_arr(2));
fprintf('P2 = %d\n', p2_arr(2));
fprintf('P3 = %d\n', p3_arr(2));
fprintf('Total SS Error = %d\n', SS_error_arr(2));


fprintf('\n\nFor K = 6\n');
fprintf('P1 = %d\n', p1_arr(3));
fprintf('P2 = %d\n', p2_arr(3));
fprintf('P3 = %d\n', p3_arr(3));
fprintf('Total SS Error = %d\n', SS_error_arr(3));


fprintf('\n\n\nK = 2');
fprintf('\nTotal Iterations = %d', iter_arr(1));
fprintf('\n\nK = 4');
fprintf('\nTotal Iterations = %d', iter_arr(2));
fprintf('\n\nK = 6');
fprintf('\nTotal Iterations = %d\n\n', iter_arr(3));

