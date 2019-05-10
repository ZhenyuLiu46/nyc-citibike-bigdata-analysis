import matplotlib.pyplot as plt
import numpy as np

def plotmonth (input):
    plt.close()
    plt.figure(figsize=(7.5,6))
    x, y = range(12), range(4, 10)
    markerline, stemlines, baseline = plt.stem(input[x, 0], input[x,1], color='royalblue')
    markerline2, stemlines2, baseline2 = plt.stem(input[y,0], input[y,1], color = 'crimson')
    plt.xlabel('Month', fontsize='xx-large')
    plt.ylabel('Average Hourly Count', fontsize='xx-large')
    plt.ylim(0, 3000)
    plt.xticks(range(1,13), fontsize = 'x-large')
    plt.yticks(range(0,3000, 500), fontsize='x-large')
    plt.setp(baseline, color='w')
    plt.setp(baseline2, color='w')
    plt.setp(markerline, color='royalblue')
    plt.setp(stemlines, color='royalblue')
    plt.setp(markerline2, color='crimson')
    plt.setp(stemlines2, color='crimson')
    plt.savefig('CitiBikeCountAvg.jpg',dpi=200)
    
    
def plothour(input):
    plt.close()
    plt.figure(figsize=(7.5,6))
    x, y, z = range(24), [8,9,17,18],[0,1,2,3,4,5,6,21,22,23]
    markerline, stemlines, baseline = plt.stem(input[x, 0], input[x,1], label='other')
    markerline2, stemlines2, baseline2 = plt.stem(input[y, 0], input[y,1], label='peak')
    markerline3, stemlines3, baseline3 = plt.stem(input[z, 0], input[z,1], label='valley')
    plt.setp(baseline, color='w')
    plt.setp(baseline2, color='w')
    plt.setp(baseline3, color='w')
    plt.setp(markerline, color='royalblue')
    plt.setp(stemlines, color='royalblue')
    plt.setp(markerline2, color='crimson')
    plt.setp(stemlines2, color='crimson')
    plt.setp(markerline3, color='mediumseagreen')
    plt.setp(stemlines3, color='mediumseagreen')
    plt.xlabel('Hour', fontsize='xx-large')
    plt.ylabel('Average Hourly Count', fontsize='xx-large')
    plt.xticks(range(0,23,2), fontsize = 'x-large')
    plt.yticks(range(0,5100, 1000), fontsize='x-large')
    plt.ylim(0, 5000)
    plt.axhline(y=1971, color='gray',linestyle='--')
    plt.legend(fontsize='xx-large')
    plt.savefig('CitiBikeHourAvg.jpg', dpi=200)
    #plt.show()
    
def plothourcorr():
    plt.close()
    input = [[0.65, -0.30, -0.07], [0.60, -0.25, -0.10], [0.39, -0.15, -0.05]]
    x = np.arange(3)
    width = 0.3
    plt.bar(x - width/2, input[0], width, color='royalblue', label='other')
    plt.bar(x + width/2, input[1], width, color='crimson', label='peak')
    plt.bar(x + width*3/2, input[2], width, color='mediumseagreen', label='valley')
    plt.legend(fontsize='xx-large')
    plt.ylim(-0.4, 0.8)
    plt.xticks((0.2, 1.2, 2.2),('Temperature', 'Wind', 'Precipitation'), fontsize='xx-large')
    plt.ylabel('Correlation', fontsize='xx-large')
    plt.savefig('HourCorrelation.jpg', dpi=200)
    #plt.show()
    
def plotPrecip():
    plt.close()
    plt.figure(figsize=(7.5,6))
    input = [[-0.1, -0.13, -0.06], [-0.17, -0.19, -0.09]]
    x = np.arange(3)
    width = 0.25
    plt.bar(x - width/2, input[0], width, color='crimson', label='warm')
    plt.bar(x + width/2, input[1], width, color='royalblue', label='cold')
    plt.xticks((0.2, 1.2, 2.2),('Other', 'Peak', 'Valley'), fontsize='xx-large')
    plt.legend(fontsize='xx-large')
    plt.yticks((-0.3, -0.2, -0.1, 0), fontsize='x-large')
    plt.ylim(-0.25, 0)
    plt.ylabel('Correlation', fontsize='xx-large')
    plt.savefig('PrecipCorr.jpg', dpi=200)
    #plt.show()
    
def plotWeatherMonth (input):
    plt.close()
    plt.figure(figsize=(7.5,6))
    x, y = range(12), range(4, 10)
    markerline, stemlines, baseline = plt.stem(input[x, 0], input[x,1], color='royalblue')
    markerline2, stemlines2, baseline2 = plt.stem(input[y,0], input[y,1], color = 'crimson')
    plt.xlabel('Month', fontsize='xx-large')
    plt.ylabel('Average Temperature ($^\circ$C)', fontsize='xx-large')
    #plt.ylabel('Average Precipitation (mm)', fontsize='xx-large')
    #plt.ylabel('Average Wind Speed (m/s)', fontsize='xx-large')
    plt.ylim(-8, 30)
    plt.xticks(range(1,13), fontsize = 'x-large')
    #plt.yticks((0,0.5,1.0,1.5,2.0,2.5,3.0), fontsize='x-large')
    #plt.yticks(range(0,310, 50), (0,5,10,15,20,25,30), fontsize='x-large')
    plt.yticks((0,50,100,150,200,250,300),(0,5,10,15,20,25,30), fontsize='x-large')
    plt.setp(baseline, color='w')
    plt.setp(baseline2, color='w')
    plt.setp(markerline, color='royalblue')
    plt.setp(stemlines, color='royalblue')
    plt.setp(markerline2, color='crimson')
    plt.setp(stemlines2, color='crimson')
    #plt.show()
    plt.savefig('TempMonthAvg2.jpg',dpi=200)
    
def featureImportance():
    input = [ 0.60924656, 0.22926596, 0.07932727, 0.05576902, 0.02639119]
    plt.close()
    plt.figure(figsize=(9.5,5))
    #the coefficient of determination R^2 of the prediction
    x = np.arange(5)
    plt.barh(x, input[::-1], color='royalblue')
    plt.yticks((0,1,2,3,4,5), ('Precipitation', 'Wind', 'Month', 'Temperature', 'Hour'),fontsize='large')
    plt.xlabel('Relative Importance', fontsize='xx-large')
    plt.xticks((0, 0.1,0.2,0.3,0.4,0.5,0.6,0.7), fontsize='x-large')
    plt.title('Feature Importance', fontsize='xx-large')
    #plt.show()
    plt.savefig('figure/featureImportance.jpg',dpi=200)
    
if __name__ == '__main__':
    #input = np.loadtxt('CitiBikeCountAvg.csv',delimiter=',', usecols=(1,2))
    #input2 = input[input[:,0].argsort()]
    input = np.loadtxt('weatherMonthAvg.csv',delimiter=',', usecols=(1,2,3,4))
    input2 = input[input[:,0].argsort()]
    plotWeatherMonth(input2)
    plotPrecip()
    #plotmonth(input2)
    #input = np.loadtxt('CitiBikeHourAvg.csv',delimiter=',')
    #avg = np.mean(input[:,1])
    #plothour(input)
    #plothourcorr()
    #featureImportance()
    