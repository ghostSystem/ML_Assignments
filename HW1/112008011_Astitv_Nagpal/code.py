import random
import math
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import scipy.stats as sta

def question2(N,M):
	'''
	Main function call where we get value for:
	X, Exp of X, Var of X
	Returns Expectation, Variance, Co-Variance for List X.
	'''

	X = []
	ProbX = []
	X = calculateFunctionForX(M)
	exp = calculateExpectationForX(X)
	var = calculateVarianceForX(X)
	covar = calculateCoVarianceForX(X)
	ProbX = calculateProbabilityForX(X,N)
	ent = calculateEntropyOfX(ProbX,M)

	print("\n\n*************")
	print("M = {}".format(M))
	print("exp = {}".format(exp))
	print("var = {}".format(var))
	print("covar = {}".format(covar))
	print("ent = {}".format(ent))
	print("*************")

	return exp,var,covar,ent


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

def calculateCoVarianceForX(X):
	'''
	This method calculates the Co-Variance for X.
	Returns the Co-Variance for X.
	'''

	X1 = []
	for i in range(len(X)):
		X1.append(myRandomList[i][0])

	return np.cov(X,X1)[0,1]

def calculateProbabilityForX(X,N):
	'''
	This method calculates the Probability for X.
	Returns the Probability for X.
	'''

	ProbX = []
	for num in X:
		if num != 0:
			temp = (N-num)/(N*N)
			ProbX.append(temp)
		else:
			temp = (N+1)/(2*N)
			ProbX.append(temp)

	return ProbX

def calculateEntropyOfX(ProbX,M):
	'''
	This method calculates the Entropy for X.
	Returns the Entropy for X.
	'''

	return sta.entropy(ProbX, base = 2)

def generateRandomList(N,M):
	'''
	This method generates a total of M*M Random and all Unique
	tuple pairs for points (X1,X2).
	Returns a list containing all RANDOM and UNIQUE pairs of (X1,X2) points possible.
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

print("\n\n\n****************\nCode is Running...\nWait for a few seconds\n****************")

N = 100
M = 100

#myRandomList -> Global Variable.
#List containing all possible unique pairs of (X1,X2).
#All the values are saved in the form of a tuple,
#with 
#index->0 : X1,
#index->1 : X2 
myRandomList = generateRandomList(N,M)


#Plotting methods
def plotExpectationOfX(DF):
	plt.figure(figsize=(14,7.5))
	plt.xlabel('Values of M')
	plt.ylabel('Expectation of X\nE(X)')
	plt.title("Graph : M vs Expectation(X)")
	plt.xticks(range(0,10001,500))
	plt.plot(range(100,10001, 100), DF['Exp'])
	plt.show()

def plotVarianceOfX(DF):
	plt.figure(figsize=(14,7.5))
	plt.xlabel('Values of M')
	plt.ylabel('Variance of X\nVar(X)')
	plt.title("Graph : M vs Variance(X)")
	plt.xticks(range(0,10001,500))
	plt.plot(range(100,10001, 100), DF['Var'])
	plt.show() 

def plotCoVarianceOfX(DF):
	plt.figure(figsize=(14,7.5))
	plt.xlabel('Values of M')
	plt.ylabel('Co-Variance(X,X1)\nCov(X,X1)')
	plt.title("Graph : M vs Co-Variance(X)")
	plt.xticks(range(0,10001,500))
	plt.plot(range(100,10001, 100), DF['CoVar'])
	plt.show()

def plotEntropyOfX(DF):
	plt.figure(figsize=(14,7.5))
	plt.xlabel('Values of M')
	plt.ylabel('Entropy of X\nH(X)')
	plt.title("Graph : M vs Entropy(X)")
	plt.xticks(range(0,10001,500))
	plt.plot(range(100,10001, 100), DF['Ent'])
	plt.show()

if __name__ == '__main__':
	'''
	This is where we will call our main function -> question2(N,M).
	We Store all the Expectation and Variance Values for X
	for each value of M given.
	'''

	N = 100
	M = 100
	E = []
	V = []
	C = []
	H = []
	for i in range(100):
		e, v, c, h = question2(N,M)
		E.append(e)
		V.append(v)
		C.append(c)
		H.append(h)
		M += 100
	
	print("\n\n****************\nExpectation List : \n****************\n{}".format(E))
	print("\n\n****************\nVariance List : \n****************\n{}".format(V))
	print("\n\n****************\nCoVariance List : \n****************\n{}".format(C))
	print("\n\n****************\nEntropy List : \n****************\n{}".format(H))

	myDF = pd.DataFrame()
	myDF['Exp'] = E
	myDF['Var'] = V
	myDF['CoVar'] = C
	myDF['Ent'] = H

	print("\n\n******** First 5 and last 5 values for E,V,C,H ********\n\n")
	print("{}\n{}".format(myDF.head(5), myDF.tail(5)))


	#Plotting the graphs for:
	#Expectation || Variance || Co-Variance || Entropy

	plotExpectationOfX(myDF)
	plotVarianceOfX(myDF)
	plotCoVarianceOfX(myDF)
	plotEntropyOfX(myDF)

	print("\n\n*****************\nCode has Ended !!!\n*****************")

















