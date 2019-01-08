function [trainKFinal, testKFinal] = cmpExpX2Kernel(trainD, testD)
[trDSize,~] = size(trainD);
[tstDSize, ~] = size(testD);
trainK = zeros(trDSize, trDSize);
testK = zeros(tstDSize, trDSize);

for i = 1:trDSize
    num = trainD - trainD(i,:);
    den = trainD + trainD(i,:);
    trainK(:,i) = sum(num.^2 ./ (den+eps), 2);
end

trainGamma = mean(trainK, 'all');
trainK = exp(trainK*(-1/trainGamma));

for i = 1:trDSize
    num = testD - trainD(i,:);
    den = testD + trainD(i,:);
    testK(:,i) = sum(num.^2 ./ (den+eps), 2);
end

testGamma = mean(testK, 'all');
testK = exp(testK*(-1/testGamma));

trainKFinal = [(1:size(trainD, 1))' trainK];
testKFinal = [(1:size(testD, 1))' testK];
end



    
