import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.svm import SVR
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
import math
import matplotlib.pyplot as plt

svm_data = pd.read_csv("C:/Users/Dejan/Desktop/diplomski/Diplomski/finalni_dataset_2.csv")


svm_data_all_features = svm_data.drop(columns=["korisnik","week.in.year","total.week.diff.(t)"])

svm_data_features = svm_data[["total.week.payin.(t-2)","total.week.payin.(t-1)",
                              "total.week.diff.(t-2)", "total.week.diff.(t-1)",
                              "median.payin.on.ticket.(t-2)","median.payin.on.ticket.(t-1)",
                              "favorite.no..of.matches.diff.(t-1)", "X2nd.favorite.no..of.matches.diff.(t-1)"]]

svm_data_target = svm_data["total.week.diff.(t)"]

x_train, x_test, y_train, y_test = train_test_split(svm_data_features,
                                                    svm_data_target,
                                                    random_state=400,
                                                    test_size=0.3,
                                                    shuffle=True)

scaler = StandardScaler()

x_train = scaler.fit_transform(x_train)
x_test = scaler.fit_transform(x_test)

svm = SVR(kernel="linear")
svm.fit(x_train,y_train)
svm.pred = svm.predict(x_test)

rmse = round(math.sqrt(mean_squared_error(y_test, svm.pred)), 3)
mae = round(mean_absolute_error(y_test, svm.pred), 3)
r2 = round(r2_score(y_test, svm.pred), 6)

print(f"RMSE: {rmse}")
print(f"MAE: {mae}")
print(f"R2: {r2}")

y_test_first_30 = y_test[slice(30)]
svm.pred_first_30 = svm.pred[slice(30)]

plt.plot(svm.pred_first_30, color = 'magenta', label = 'predicted')

x = range(0,30,1)

plt.scatter(x, y_test_first_30, color = 'green',label = 'real')
plt.title('Support Vector Regression Model')
plt.xlabel('First 30 observations in test subset')
plt.ylabel('Total.week.diff.(t)')
plt.legend()
plt.show()