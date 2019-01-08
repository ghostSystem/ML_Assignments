o_len = [];
for i = 1:size(obj_func,2)
    o_len = [o_len,i];
end

plot(o_len, obj_func);

ap_len = [];
for i = 1:size(ap_list,2)
    ap_len = [ap_len,i];
end

plot(ap_len, ap_list);
