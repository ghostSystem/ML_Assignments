[trD, trLb, valD, valLb, trRegs, valRegs] = HW4_Utils.getPosAndRandomNeg();

[w,b, alpha, obj] = ques2(trD, trLb, 0.1);

HW4_Utils.genRsltFile(w, b, 'val', 'output_val.mat');

[ap, prec, rec] = HW4_Utils.cmpAP('output_val.mat', 'val');

disp(ap);  