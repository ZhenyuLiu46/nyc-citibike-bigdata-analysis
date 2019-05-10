from sklearn import linear_model
import numpy as np
import random
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.ensemble import RandomForestRegressor
from sklearn.datasets import make_regression

def linearModel():
    input = np.loadtxt('citibikeweather.csv', delimiter=',', skiprows=1)
    random.seed(1991)
    random.shuffle(input)
    y = input[:,2]
    x = np.concatenate((input[:,:2], input[:,3:]),axis=1)
    clf = linear_model.LinearRegression()
    l = len(input)//10
    clf.fit(x[:-l], y[:-l])
    pred = clf.predict(x[-l:])
    print("Mean squared error: %.2f"
      % mean_squared_error(y[-l:], pred))
    print('Coefficients: \n', clf.coef_, clf.intercept_)
    print('Variance score: %.2f' % r2_score(y[-l:], pred))
    

def RandForestModel():
    input = np.loadtxt('citibikeweather.csv', delimiter=',', skiprows=1)
    random.seed(1991)
    random.shuffle(input)
    y = input[:,2]
    x = np.concatenate((input[:,:2], input[:,3:]),axis=1)[:,1:]
    l = len(input)//10
    regr = RandomForestRegressor(n_estimators=500, random_state=1991)#, max_features='sqrt')
    regr.fit(x[:-l], y[:-l])
    print(regr.feature_importances_)
    print(regr.score(x[-l:], y[-l:]))

    
    
    
if __name__ == '__main__':
    linearModel()
    RandForestModel()
