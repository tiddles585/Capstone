import json
with open("list_data.json") as json_file:
    json_data = json.load(json_file)

##DEFINE FUNCTIONS

import time
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense,Dropout
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.callbacks import EarlyStopping

# set gpu
physical_devices = tf.config.list_physical_devices('GPU')
tf.config.experimental.set_memory_growth(physical_devices[0], True)

start_time = time.time()
error_log = []
LSTM_Forecasts = []

def smape_loss(y_true, y_pred):
    horizon = y_pred.shape[1]
    numer = tf.abs(y_pred - y_true)
    denom = tf.abs(y_pred) + tf.abs(y_true) + tf.keras.backend.epsilon()
    return (200 / horizon) * tf.reduce_sum(numer / denom)

def run_LSTM(ts, horizon, n_steps, cells, learning_rate, epochs, patience, min_delta, dropout_rate):
    # Differencing the time series data
    #diff_ts = difference(ts)
   # diff_ts = np.array(diff_ts)
    n = len(ts)
    n_steps = n_steps
    horizon = horizon
    array_size = n - n_steps - horizon

    x_train = np.zeros((array_size, n_steps, 1))
    y_train = np.zeros((array_size, horizon))
    x_test = np.zeros((1, n_steps, 1))
    y_test = np.zeros((1, horizon))

    for i in range(array_size):
        x_train[i, :, :] = ts[i:(i+n_steps)].reshape(-1, 1)
        y_train[i, :] = ts[(i+n_steps):(i+n_steps+horizon)]

    y_test[0, :] = ts[(n-horizon):n]
    x_test[0, :, :] = ts[(array_size):(n-horizon)].reshape(-1, 1)

    model = Sequential()
    model.add(LSTM(cells, input_shape=(n_steps, 1), unroll=False))
    # model.add(Dropout(dropout_rate))
    # model.add(LSTM(cells, return_sequences=True))
    # model.add(Dropout(dropout_rate))
    # model.add(LSTM(cells, return_sequences=True))
    # model.add(Dropout(dropout_rate))
    # model.add(LSTM(cells))
    model.add(Dense(horizon))

    model.compile(loss=smape_loss, optimizer=Adam(learning_rate=learning_rate))

    model.fit(x_train, y_train, epochs=epochs)#, verbose=0, callbacks=[EarlyStopping(monitor='loss', patience=patience, min_delta=min_delta)])

    preds= model.predict(x_test)

    # De-differencing the forecasts
    #preds = inverse_difference(ts[-n_steps:], preds_diff[0])

    return preds

##PARAMS

horizon = 3
n_steps = 25
cells = 512
#cells_2=512 #if you want this want, you have to add return_sequences=True to the first lstm layer and uncomment the second lstm layer
#cells_3=512
#cells_4=512
learning_rate = 0.35
epochs = 1000
patience = 10
min_delta = 0.01
dropout_rate=0.071
batch_size=32

#
which_series=range(0,1428) #change which series, via range

###runs the lstm

all_forecasts_1 = []

for i in which_series:
    ts = np.array(json_data[i]['target'])
    series_forecasts = []
    print("i am at "+ str(i))
    #for _ in range(3):
    with tf.device('/GPU:0'):
        print(horizon)
        forecasts = run_LSTM(ts, horizon, n_steps, cells, learning_rate, epochs, patience, min_delta, dropout_rate)
        series_forecasts.append(forecasts)
            
    series_forecasts = np.array(series_forecasts)
    median_forecasts = np.median(series_forecasts, axis=0)
    all_forecasts_1.append(median_forecasts)

all_forecasts_1 = np.array(all_forecasts_1)
print(all_forecasts_1)
print("My program took", time.time() - start_time, "to run")

##This prints sMAPES for 1 horizon

# smape_horizon=18 #Change this for w/e horizon you are running in the lstm
# smapes_1=[]
# for i in range(0,all_forecasts_1.shape[0]):
#     temp = np.array(json_data[which_series[i]]['target'])
#     y_pred=all_forecasts_1[0].flatten()
#     y_true=temp[-smape_horizon:]
#     horizon = y_true.shape[0]
#     y_pred = tf.cast(y_pred, dtype=tf.float32)
#     y_true = tf.cast(y_true, dtype=tf.float32)
#     numer =  tf.abs(y_pred - y_true)
#     denom = tf.abs(y_pred) + tf.abs(y_true) + tf.keras.backend.epsilon()
#     smapes_1.append((200 / horizon) * (numer/denom).numpy().sum())
# smapes_1