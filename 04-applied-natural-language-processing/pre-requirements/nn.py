# -*- coding: utf-8 -*-
"""
Created on Mon Aug  2 14:56:21 2021

@author: alfred
"""
from sklearn.model_selection import train_test_split
from sklearn.metrics import precision_recall_fscore_support, accuracy_score,classification_report
import pandas as pd
import seaborn as sns
import numpy as np
from sklearn.naive_bayes import BernoulliNB
from sklearn import tree
from sklearn.tree import plot_tree
from sklearn.neighbors import KNeighborsClassifier

# Prepare the data
Data=pd.read_csv('titanic.csv')
Data1 = Data[["Pclass", "Sex", "Age", "SibSp", "Parch","Survived"]]
if Data1.Age is None: Data1["Age"] = Data1.Age.mean()
Data1 = Data1.dropna()
Data2 = Data1.copy()
Data2['Sex']=Data1['Sex'].replace(['male','female'],[0,1])
Y=Data2.Survived
X=Data2
X.drop(['Survived'],axis=1,inplace=True)
X_train, X_test, Y_train, Y_test= train_test_split(X,Y,test_size=0.2, random_state=3)

# Test Nauve Bayes
classifier=BernoulliNB(fit_prior=True, alpha=1.0)
classifier.fit(X_train, Y_train)
predicted_y=classifier.predict(X_test)
print("BernoulliNB\n", classification_report(Y_test, predicted_y,zero_division=0))

# Test Decision Tree
classifier = tree.DecisionTreeClassifier(min_samples_leaf=1, 
    min_samples_split=2, max_depth=None,criterion='entropy',random_state=0)
model = classifier.fit(X_train, Y_train)
predicted_y=classifier.predict(X_test)
print("DecisionTreeClassifier \n", classification_report(Y_test, predicted_y,zero_division=0))


""" sklearn NN """

# p is the parameter for Minkowski distance
# weights can be also 'distance'
classifier = KNeighborsClassifier(n_neighbors=5, p=2, weights='uniform')
classifier.fit(X_train, Y_train)
predicted_y=classifier.predict(X_test)
print("KNeighborsClassifier\n", classification_report(Y_test, predicted_y,zero_division=0))


from sklearn.neural_network import MLPClassifier
classifier = MLPClassifier(solver='lbfgs', alpha=1e-5, max_iter=300,
                    hidden_layer_sizes=(5, 2), random_state=1,
                    validation_fraction=0.2)
classifier.fit(X_train, Y_train)
predicted_y=classifier.predict(X_test)
print("MLPClassifier\n", classification_report(Y_test, predicted_y,zero_division=0))


""" keras NN """
import keras
from keras.models import Sequential
from keras.layers import Dense
# keras.layers.Dense(units, activation=None, use_bias=True, 
# kernel_initializer='glorot_uniform', 
# bias_initializer='zeros', kernel_regularizer=None, 
# bias_regularizer=None, activity_regularizer=None, 
# kernel_constraint=None, bias_constraint=None)

classifier = Sequential()
# Input layer with 5 inputs neurons
classifier.add(Dense(3, activation = 'relu', input_dim = 5))
#Hidden layer
classifier.add(Dense(2, activation = 'relu'))
#output layer with 1 output neuron which will predict 1 or 0
# this is why we use sigmoid
classifier.add(Dense(1, activation = 'sigmoid'))
classifier.compile(optimizer = 'adam', \
    loss = 'binary_crossentropy', metrics = ['accuracy'])
classifier.fit(X_train, Y_train, batch_size = 10, epochs = 300)

#getting predictions of test data
predicted_y_cont = classifier.predict(X_test).tolist()
predicted_y = [round(x[0]) for x in predicted_y_cont]
# print(predicted_y)
print("Keras classifier \n", classification_report(Y_test, predicted_y,zero_division=0))


