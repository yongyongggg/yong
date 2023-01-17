import numpy as np
w = np.array([2, 1, 5, 3])
x = np.array([2, 8, 3, 7, 1, 2, 0, 4, 5])
w_r = np.flip(w)
print(w_r)
w[0:4:2]
for i in range(6):
    print(np.dot(x[i:i+4], w_r))

from scipy.signal import convolve
convolve(x, w, mode='valid')
from scipy.signal import correlate
correlate(x, w, mode='valid')
correlate(x, w, mode='full')
correlate(x, w, mode='same')

x = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])
w = np.array([[2, 0], [0, 0]])

from scipy.signal import correlate2d
correlate2d(x, w, mode='valid')
np.flip(w)
from scipy.signal import convolve2d
convolve2d(x, w, mode='valid')
correlate2d(x, w, mode='same')

import tensorflow as tf
x_4d = x.astype(np.float).reshape(1, 3, 3, 1)
w_4d = w.reshape(2, 2, 1, 1)
c_out = tf.nn.conv2d(x_4d, w_4d, strides=1, padding='SAME')
c_out.numpy().reshape(3, 3)






