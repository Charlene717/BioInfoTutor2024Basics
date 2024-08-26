import numpy as np
import matplotlib.pyplot as plt 
from sklearn.decomposition import PCA
from sklearn.datasets import load_iris

# 加載數據集（這裡使用的是Iris數據集）
iris = load_iris()
X = iris.data
y = iris.target

# 使用PCA將數據降至2維
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X)

# 創建一個散點圖來可視化PCA結果
plt.figure(figsize=(8, 6))
scatter = plt.scatter(X_pca[:, 0], X_pca[:, 1], c=y, cmap='viridis')

# 添加圖例
legend1 = plt.legend(*scatter.legend_elements(), title="Classes")
plt.gca().add_artist(legend1)

# 添加標題和標籤
plt.title('PCA of Iris Dataset')
plt.xlabel('First Principal Component')
plt.ylabel('Second Principal Component')

# 顯示圖表
plt.show()
