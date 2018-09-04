import random
import math
import numpy as np

def question2(N,M):
	'''
	Main function call where we get value for:
	X, Exp of X, Var of X
	Returns Expectation, Variance for List X.
	'''

	X = []
	X = calculateFunctionForX(M)
	exp = calculateExpectationForX(X)
	var = calculateVarianceForX(X)

	print("\n*************\nM = {}\nexp = {}\nvar = {}\n*************".format(M, exp, var))

	return exp,var


def calculateFunctionForX(M):
	'''
	This method implements the function:
	f(X) = max(X1,X2) - X1
	Returns a list containing values for X.
	'''

	temp = 0
	X = []
	for num in myRandomList[:M]:
		temp = max(num[0], num[1]) - num[0]
		X.append(temp)

	return X


def calculateExpectationForX(X):
	'''
	This method calculates the Expectation for X.
	Returns the Expectation for X.
	'''

	return np.mean(X)

def calculateVarianceForX(X):
	'''
	This method calculates the Variance for X.
	Returns the Variance for X.
	'''

	return np.var(X)


def generateRandomList(N,M):
	'''
	This method generates a total of M*M Random and all Unique
	tuple pairs for points (X1,X2).
	Returns a list containing all random and unique pairs of points possible.
	'''

	X1 = random.sample(range(1,N+1), M)
	X2 = random.sample(range(1,N+1), M)
	randomList = []
	X_Visited = []
	count = 0
	while count < M*M:
		X1_temp = random.choice(X1)
		X2_temp = random.choice(X2)
		if tuple((X1_temp, X2_temp)) not in X_Visited:
			randomList.append(tuple((X1_temp,X2_temp)))
			X_Visited.append(tuple((X1_temp, X2_temp)))
			count += 1

	return randomList

print("****************\nCode is Running...\n****************")
N = 100
M = 100
#Global Variable:
#List contaying all possible unique pairs of (X1,X2).
myRandomList = generateRandomList(N,M)

if __name__ == '__main__':
	'''
	This is where we will call our main function -> question2(N,M).
	Will Store all the Expectation and Variance Values for X
	for each value of M given.
	'''

	N = 100
	M = 100
	ExpX = []
	VarX = []
	for i in range(100):
		exp, var = question2(N,M)
		ExpX.append(exp)
		VarX.append(var)
		M += 100
	
	print("\n\n****************\nExpectation List : \n****************\n{}\n\n\n****************\nVariance List : \n****************\n{}\n\n".format(ExpX, VarX))
	print("*****************\nCode has Ended !!!\n*****************")

















