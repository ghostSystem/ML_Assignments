K=1;
p1_final = [];
p2_final = [];
p3_final = [];
SSError_final = [];
iter_final = [];
for z = 1:10
    
    p1_arr = [];
    p2_arr = [];
    p3_arr = [];
    SS_error_arr = [];
   
    p1_n = 0;
    p1_d = 0;
    p2_n = 0;
    p2_d = 0;
    p1 = 0;
    p2 = 0;
    p3 = 0;
    iter_arr = [];
    m = 0;
    while m < 10
        [Center, Indicator, iter, SS_error] = kmeans(digit, K, 20);
    
    % Calculating p1 p2 and p3
    
        for i = 1:size(Indicator,1)
            for j = i+1:size(Indicator,1)
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

        p1_arr = [p1_arr, p1];
        p2_arr = [p2_arr, p2];
        p3_arr = [p3_arr, p3];
        SS_error_arr = [SS_error_arr, SS_error];
        iter_arr = [iter_arr, iter];

        m = m+1;
    end
    
    p1_final = [p1_final, (sum(p1_arr, 2))/size(p1_arr, 2)];
    p2_final = [p2_final, (sum(p2_arr, 2))/size(p2_arr, 2)];
    p3_final = [p3_final, (sum(p3_arr, 2))/size(p3_arr, 2)];
    SSError_final = [SSError_final, (sum(SS_error_arr, 2))/size(SS_error_arr, 2)];
    
    K = K+1;
end
