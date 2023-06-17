import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans

# Define the data set
X = np.array([[2, 1], [2, 4], [3, 2], [5, 6], [6, 5], [7, 4], [8, 5], [10, 10]])

# Define the number of clusters and threshold value
k = 2
t = 3

# Apply the K-Means algorithm to the data set
kmeans = KMeans(n_clusters=k, random_state=0).fit(X)

# Get the centroids and labels
centroids = kmeans.cluster_centers_
labels = kmeans.labels_

# Get the distances of each data object to its closest centroid
distances = []
for i in range(len(X)):
    centroid = centroids[labels[i]]
    distance = np.linalg.norm(X[i]-centroid)
    distances.append(distance)

# Calculate the standard deviation of the distances
std_dev = np.std(distances)

# Calculate the anomaly scores for each data object
anomaly_scores = []
for i in range(len(X)):
    distance = distances[i]
    anomaly_score = distance/std_dev
    anomaly_scores.append(anomaly_score)

# Identify the anomalies based on their anomaly scores
anomalies = []
for i in range(len(X)):
    if anomaly_scores[i] > t:
        anomalies.append(X[i])

# Plot the data set with the centroids and anomalies
plt.scatter(X[:,0], X[:,1], c='blue')
plt.scatter(centroids[:,0], centroids[:,1], marker='x', s=200, linewidths=3, color='red')
plt.scatter(np.array(anomalies)[:,0], np.array(anomalies)[:,1], marker='o', s=200, color='yellow', edgecolors='black', linewidths=2)
plt.show()
