[trIds, trLbs] = ml_load('/Users/astitvnagpal/Ghost_Files/SBU/Sem1/ML/HomeWork/HW5/hw5data/bigbangtheory/train.mat',  'imIds', 'lbs');             

% % 5-Fold Training using Kernel 
% model = svmtrain(trLbs, trainK, '-t 4 -v 5 -c 10000');
% disp(model);



model = svmtrain(trLbs, trainK, '-t 4 -c 10000');
testing_label_vector = ones(size(testK,1),1);
predicted_label = svmpredict(testing_label_vector, testK, model);
disp('prediction done');
tstIds = ml_load('/Users/astitvnagpal/Ghost_Files/SBU/Sem1/ML/HomeWork/HW5/hw5data/bigbangtheory/test.mat', 'imIds'); 
prediction = [tstIds', predicted_label];
csvwrite('hw5_2.csv',prediction);