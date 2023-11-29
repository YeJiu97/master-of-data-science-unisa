import matplotlib.pyplot as plt
import numpy as np
from sklearn.neural_network import MLPClassifier

# data
A = [0, 0, 1, 1]
B = [0, 1, 0, 1]
XOR = [0, 1, 1, 0]

# Extract data points whose XOR is 0 and 1 respectively
x0, y0, x1, y1 = [], [], [], []
for i in range(len(XOR)):
     if XOR[i] == 0:
         x0.append(A[i])
         y0.append(B[i])
     else:
         x1.append(A[i])
         y1.append(B[i])

#Set canvas size and range
plt.figure(figsize=(6, 4))
plt.xlim(-0.5, 1.5)
plt.ylim(-0.5, 1.5)

# Draw visualization of XOR data
plt.scatter(x0, y0, c='red', label='XOR=0', marker='o', s=100)
plt.scatter(x1, y1, c='blue', label='XOR=1', marker='x', s=100)
plt.xlabel('A')
plt.ylabel('B')
plt.title('XOR Data Visualization')
plt.legend(loc='upper right')
plt.show()

# Draw a visualization of a traditional perceptron
plt.figure(figsize=(6, 4))
plt.xlim(-0.5, 1.5)
plt.ylim(-0.5, 1.5)
x_boundary = np.linspace(-0.5, 1.5, 100)
y_boundary = -x_boundary + 0.5 # Linear decision boundary of the perceptron
plt.plot(x_boundary, y_boundary, linestyle='--', color='green', label='Perceptron Decision Boundary')
plt.scatter(x0, y0, c='red', label='XOR=0', marker='o', s=100)
plt.scatter(x1, y1, c='blue', label='XOR=1', marker='x', s=100)
plt.xlabel('A')
plt.ylabel('B')
plt.title('Perceptron Decision Boundary')
plt.legend(loc='upper right')
plt.show()

# Draw a visualization of the backpropagation neural network
X = np.array([[0, 0], [0, 1], [1, 0], [1, 1]])
y = np.array([0, 1, 1, 0])
model = MLPClassifier(hidden_layer_sizes=(4,), activation='relu', solver='lbfgs', random_state=1)
model.fit(X, y)
x_min, x_max = -0.5, 1.5
y_min, y_max = -0.5, 1.5
h = 0.01
xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))
Z = model.predict(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)
plt.figure(figsize=(6, 4))
plt.xlim(-0.5, 1.5)
plt.ylim(-0.5, 1.5)
plt.contourf(xx, yy, Z, cmap=plt.cm.RdYlBu, alpha=0.8)
plt.scatter(X[y == 0][:, 0], X[y == 0][:, 1], c='red', label='XOR=0', marker='o', s=100)
plt.scatter(X[y == 1][:, 0], X[y == 1][:, 1], c='blue', label='XOR=1', marker='x', s=100)
plt.xlabel('A')
plt.ylabel('B')
plt.title('Backpropagation Neural Network')
plt.legend(loc='upper right')
plt.show()