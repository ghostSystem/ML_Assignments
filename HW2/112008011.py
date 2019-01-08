'''
Astitv Nagpal
112008011
HW2 - ML
'''

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def RidgeRegression(X, y, lamda):
    X_t = np.transpose(X)
    X_X_t = np.dot(X, X_t)
    i_mat = np.identity(X_X_t.shape[0])
    i_mat[-1][-1] = 0
    lamda_i = i_mat*lamda
    c_inverse = np.linalg.inv(lamda_i + X_X_t)
    X_y = np.dot(X, y)
    w_bar = np.dot(c_inverse, X_y)
    w_bar_t = np.transpose(w_bar)
    b = w_bar[-1]
    w = np.delete(w_bar, -1, 0)
    w_t = np.transpose(w)
    
    #calculating parameters for errors
    obj = 0
    part1 = lamda*(np.dot(w_t, w))
    part2 = np.dot(w_bar_t, X) - np.transpose(y)
    part2_t = np.transpose(part2)
    obj = part1 + np.dot(part2, part2_t)
    
    #Finding the errors
    cvErr_list = []
    for i in range(X.shape[1]):
        X_test = X[:, i]
        X_test_t = np.transpose(X_test)
        y_test = y[i]
        loocv_1 = np.dot(w_bar_t, X_test) - y_test
        loocv_2 = 1 - (np.dot((np.dot(X_test_t, c_inverse)), X_test))
        loocv_eq = loocv_1/loocv_2
        cvErr_list.append(loocv_eq)
    print("Processed for Lamda = {}".format(lamda))
    return w, b, cvErr_list, obj

def RMSE(X, y, w_list, b_list):
    rmse_list = []
    for i in [0,1,2,3,4,5]:
        y_pred = 0
        w_i = w_list[i]
        X_w_i = np.dot(X, w_i)
        b_i = []
        for _ in range(len(y)):
            b_i.append(b_list[i][0])
        b_i = np.array(b_i)
        b_i = b_i.reshape((len(y), 1))
        y_pred = X_w_i + b_i
        rmse = 0
        rmse = np.sqrt(np.sum(np.square(y_pred - y))/len(y))
        rmse_list.append(rmse)
    return rmse_list

def deg(X):
    a = X
    b = np.power(a[:, :], 3)
    out = np.hstack((a, b))
    
    out = np.delete(out, np.s_[0:3000], axis=1)
    
    return out

def testRMSE(X, w, b):
    b_i = []
    y_pred = 0
    X_w = np.dot(X, w)
    for _ in range(X.shape[0]):
        b_i.append(b)
    b_i = np.array(b_i)
    b_i = b_i.reshape((X.shape[0], 1))
    y_pred = X_w + b_i
    ind = list(range(len(y_pred)))
    df = pd.DataFrame()
    df['Id'] = ind
    df['Prediction'] = y_pred
    return df

def featureSelection(w):
    w_final = []
    for i in range(len(w)):
        w_final.append(w[i][0])
    w_final = map(abs, w_final)
    w_final = list(w_final)
    w_args = np.argsort(w_final)
    newList = []
    for i in range(len(w_args)):
        newList.append((w_final[i], w_args[i]))
    newList.sort()
    w_imp = []
    w_not_imp = []
    for i in range(1, 11):
        w_imp.append(newList[-i][1])
    for i in range(0,10):
        w_not_imp.append(newList[i][1])
    return w_imp, w_not_imp


if __name__ == '__main__':
    
    print("\nCode is running....\nGive it some time\n")
    X_train = np.genfromtxt('trainData.csv', delimiter=',')
    X_train = np.delete(X_train, 0, axis=1)
    
    X_train = np.transpose(X_train)

    y_train = np.genfromtxt('trainLabels.csv', delimiter=',')
    y_train = np.delete(y_train, 0, axis=1)

    ones = [1]*5000
    X_train = np.vstack((X_train, ones))
    obj_function_list = []
    w_list = [] 
    b_list = []
    cvErr_list = []
    for i in [0.01, 0.1, 1, 10, 100, 1000]:
        w, b, cvErr, obj = RidgeRegression(X_train, y_train, i)
        obj_function_list.append(obj[0][0])
        w_list.append(w)
        b_list.append(b)
        cvErr_list.append(cvErr)
    
    print("################")
    # Calculating Loocv Values
    loocv_l = []
    for i in [0,1,2,3,4,5]:
        loo = 0
        for j in range((X_train.shape[1])):
            loo += cvErr_list[i][j][0]**2
        loocv_l.append(loo)
    
    print("\nLOOCV_Values : \n{}".format(loocv_l))

    
    lamda = [0.01, 0.1, 1, 10, 100, 1000]
    
    X_train_r = np.genfromtxt('trainData.csv', delimiter=',')
    X_train_r = np.delete(X_train_r, 0, axis=1)
    y_train_r = np.genfromtxt('trainLabels.csv', delimiter=',')
    y_train_r = np.delete(y_train_r, 0, axis=1)
    rmse_list = RMSE(X_train_r, y_train_r, w_list, b_list)
    print("\nRMSE_Values on Training Data : \n{}".format(rmse_list))
    
    
    # Checking for Validation Data
    X_train_val = np.genfromtxt('valData.csv', delimiter=',')
    X_train_val = np.delete(X_train_val, 0, axis=1)
    
    y_train_val = np.genfromtxt('valLabels.csv', delimiter=',')
    y_train_val = np.delete(y_train_val, 0, axis=1)
    
    rmse_val_list = RMSE(X_train_val, y_train_val, w_list, b_list)
    print("\nRMSE_Values for Validation Data : \n{}".format(rmse_val_list))
    
    print("\n\n\n############ Separate Plots #############\n")
          
    # Question 3.2 Part 1    
    print("Lamda vs LOOCV Errors")
    plt.plot(lamda, loocv_l)
    plt.show()
    print("Lamda vs RMSE_Training Errors")
    plt.plot(lamda, rmse_list)
    plt.show()
    print("Lamda vs RMSE_Validation Errors")
    plt.plot(lamda, rmse_val_list)
    plt.show()
    
    
    print("Plotting LOOCV error values as 1/8th of the original to show on the plot with others.")
    # Plotting of Plots
    fig = plt.figure()
    axes = fig.add_axes([0,0,1,1])
    axes.plot(lamda, np.sqrt(np.sqrt(np.sqrt(loocv_l))), label = 'loocv')
    axes.plot(lamda, rmse_list, label = 'rmse_trining')
    axes.plot(lamda, rmse_val_list, label = 'rmse_validation')
    axes.set_title("Plots")
    axes.set_ylabel("Errors Value")
    axes.set_xlabel("Lamda Values")
    axes.legend(loc=0)
    plt.show()
    
    # Minimum lamda calculation
    lamda_min_index = rmse_val_list.index(min(rmse_val_list))
    
    X_test = np.genfromtxt('testData.csv', delimiter=',')
    X_test = np.delete(X_test, 0, axis=1)
    
    # Question 3.2 Part 2
    print("\nMinimum Lamda = {}".format(lamda[lamda_min_index]))
    print("\nObjective Function Value = {}".format(obj_function_list[lamda_min_index]))
    print("\nLOOCV Error Training Data = {}".format(loocv_l[lamda_min_index]))
    print("\nRMSE Error Training Data = {}".format(rmse_list[lamda_min_index]))
    w_l = []
    for i in range(len(w_list[lamda_min_index])):
        w_l.append(w_list[lamda_min_index][0])
    print("\nValue of Regularization term = {}".format(lamda[lamda_min_index]*(w_l*np.transpose(w_l))[0][0]))
    
    
    # Question 3.2 Part 3
    # 10 Most important and 10 Least Important Features are:
    imp, notimp = featureSelection(w_list[lamda_min_index])
    print("\n10 Most Important Features\n")
    for i in range(0, 10):
        print("{} : W-{} at index-{}".format(i+1, imp[i]+1, imp[i]))
    
    print("\n10 Least Important Features\n")
    for i in range(0, 10):
        print("{} : W-{} at index- {}".format(i+1, notimp[i]+1, notimp[i]))
    
    # Question 3.2 Part 4
    testDF = testRMSE(X_test, w_list[lamda_min_index], b_list[lamda_min_index][0])    
    testDF.to_csv('112008011_1.csv', index=False)
    
    print("\n\nCode Ended !")
    
    
    


