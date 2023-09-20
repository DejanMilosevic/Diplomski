import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
from keras.models import Sequential
from keras.layers import Dense
import math
import matplotlib.pyplot as plt

nn_data = pd.read_csv("C:/Users/Dejan/Desktop/diplomski/Diplomski/finalni_dataset_2.csv")
nn_data_all_features = nn_data.drop(columns=["korisnik", "week.in.year","total.week.diff.(t)"])

nn_data_features = nn_data[["total.week.payin.(t-2)","total.week.payin.(t-1)",
                            "total.week.diff.(t-2)", "total.week.diff.(t-1)",
                            "median.payin.on.ticket.(t-2)","median.payin.on.ticket.(t-1)",
                            "favorite.no..of.matches.diff.(t-1)", "X2nd.favorite.no..of.matches.diff.(t-1)"]]

nn_data_target = nn_data["total.week.diff.(t)"]

x_train, x_test, y_train, y_test = train_test_split(nn_data_features,
                                                    nn_data_target,
                                                    random_state=500,
                                                    test_size=0.3,
                                                    shuffle=True)

scaler = StandardScaler()

x_train = scaler.fit_transform(x_train)
x_test = scaler.fit_transform(x_test)

# no_of_layers = [1,2,3]
# no_of_neurons = [15,20,25]
#
# rmse_list = []
# mae_list = []
# r2_list = []

# for i in no_of_layers:
#     for j in no_of_neurons:
#         nnet = Sequential()
#         nnet.add(Dense(j, input_dim=x_train.shape[1], activation="relu"))
#         if i == 2:
#             nnet.add(Dense(j-10, activation="relu"))
#         if i == 3:
#             nnet.add(Dense(j - 5, activation="relu"))
#             nnet.add(Dense(j - 10, activation="relu"))
#         nnet.add(Dense(1, activation="linear"))

nnet = Sequential()
nnet.add(Dense(25, input_dim=x_train.shape[1], activation="relu"))
nnet.add(Dense(15, activation="relu"))
nnet.add(Dense(1, activation="linear"))

nnet.compile(loss="mean_squared_error", optimizer="adam")

epochs = 100
batch_size = 64

nnet.fit(x_train, y_train, epochs=epochs, batch_size=batch_size, verbose=1)
nnet.pred = nnet.predict(x_test)

mae = round(mean_absolute_error(y_test, nnet.pred), 3)
rmse = round(math.sqrt(mean_squared_error(y_test, nnet.pred)), 3)
r2 = round(r2_score(y_test, nnet.pred), 6)

# rmse_list.append(rmse)
# mae_list.append(mae)
# r2_list.append(r2)


print(f"RMSE: {rmse}")
print(f"MAE: {mae}")
print(f"R2: {r2}")

y_test_first_30 = y_test[slice(30)]
nnet.pred_first_30 = nnet.pred[slice(30)]

plt.plot(nnet.pred_first_30, color = 'magenta', label = 'predicted')

x = range(0,30,1)

plt.scatter(x, y_test_first_30, color = 'green',label = 'real')
plt.title('Neural Network Model')
plt.xlabel('First 30 observations in test subset')
plt.ylabel('Total.week.diff.(t)')
plt.legend()
plt.show()

# print(f"Index of minimal RMSE: {rmse_list.index(min(rmse_list))}, RMSE: {min(rmse_list)}")
# print(f"Index of minimal MAE: {mae_list.index(min(mae_list))}, MAE: {min(mae_list)}")
# print(f"Index of maximal R2: {r2_list.index(max(r2_list))}, R2: {max(r2_list)}")