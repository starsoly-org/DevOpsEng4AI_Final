import numpy as np
from sklearn.linear_model import LogisticRegression
import pickle

X = np.array([[1], [2], [3], [4], [5]])
y = [0, 0, 1, 1, 1]

model = LogisticRegression()
model.fit(X, y)

with open("model.pkl", "wb") as f:
    pickle.dump(model, f)