import random
import math
import numpy as np

def question2(N,M):

	X1, X2 = generateRandomNumbers(N)
	#print("X1 = {}\n\nX2 = {}".format(X1, X2))
	X = []
	X = calculateFunctionForX(M,X1,X2)

	#print("\nX = {}\nLength = {}".format(X, len(X)))

	ProbX = []
	#ProbX = calculateProbabilityForX(X,N)

	#print("\nprobX = {}".format(ProbX))

	ExpX = 0
	ExpX = calculateExpectationOfX(X)

	VarX = 0
	VarX = calculateVarianceOfX(X)

	#print("\nExp = {}".format(ExpX))

	print("*******************\nSample Size M = {}\nExpectation = {}\nVariance = {}\n*******************\n".format(M, ExpX, VarX))

	return ExpX, VarX


def calculateFunctionForX(M,X1,X2):

	

	# #X1_Vis = []
	# #X2_Vis = []
	# X_Visited = []
	# X = []
	# count = 0

	# while count < M:
	# 	X1_temp = random.choice(X1)
	# 	X2_temp = random.choice(X2)
	# 	# if tuple((X1_temp, X2_temp)) not in X_Visited:
	# 	# 	funcAns = max(X1_temp, X2_temp) - X1_temp
	# 	# 	X.append(funcAns)
	# 	# 	X_Visited.append(tuple((X1_temp, X2_temp)))
	# 	# 	#X1_Vis.append(X1_temp)
	# 	# 	#X2_Vis.append(X2_temp)
	# 	# 	count += 1
	# 	funcAns = max(X1_temp, X2_temp) - X1_temp
	# 	X.append(funcAns)
	# 	count += 1

	# return X


# def calculateProbabilityForX(X,N):

# 	ProbX = []
# 	# check for num == 0 
# 	for num in X:
# 		temp = (N-num)/(N*N)
# 		ProbX.append(temp)

# 	return ProbX


def calculateExpectationOfX(X):

	return np.mean(X)


def calculateVarianceOfX(X):

	return np.var(X)

def generateRandomNumbers(N):

	X1 = []
	X2 = []
	#X1 = random.sample(range(1,N+1), math.ceil(math.sqrt(M)))
	#X2 = random.sample(range(1,N+1), math.ceil(math.sqrt(M)))
	X1 = random.sample(range(1,N+1), 100)
	X2 = random.sample(range(1,N+1), 100)

	return X1, X2

def getRandomTuplesList():

	X1 = random.sample(range(1,101), 100)
	X2 = random.sample(range(1,101), 100)
	tempList = []
	for i in X1:
		for j in X2:
			tempList.append(tuple((i,j)))

	return tempList


randomTuples = getRandomTuplesList()

if __name__ == '__main__':

	
	ExpX = []
	VarX = []

	for i in range(0,100):
		exp, var = question2(N,M)
		ExpX.append(exp)
		VarX.append(var)
		M += 100

	print("\nFinal ExpList = \n\n{}\n\nFinal VarList = \n\n{}\n".format(ExpX, VarX))

