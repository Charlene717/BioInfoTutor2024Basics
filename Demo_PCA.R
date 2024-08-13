
# 產生一些範例的三維資料
set.seed(123)
data <- data.frame(
  X = rnorm(100),
  Y = rnorm(100, mean = 5, sd = 2),
  Z = rnorm(100, mean = -3, sd = 1)
)

# 執行PCA分析
pca_result <- prcomp(data, scale. = TRUE)

# 查看PCA結果的摘要
summary(pca_result)

# 提取前兩個主成分
pca_data <- data.frame(pca_result$x[, 1:2])




# 使用plotly繪製3D散佈圖

# 檢查並安裝所需套件
if(!require('plotly')) {install.packages('plotly'); library(plotly)}

fig <- plot_ly(pca_data, x = ~PC1, y = ~PC2, z = ~PC3, type = 'scatter3d', mode = 'markers') %>%
  layout(
    scene = list(
      xaxis = list(title = 'PC1'),
      yaxis = list(title = 'PC2'),
      zaxis = list(title = 'PC3'),
      camera = list(
        eye = list(x = 1.25, y = 1.25, z = 1.25)
      )
    )
  )

# 顯示3D圖形
fig



# 繪製PCA結果的二維圖形
# 檢查並安裝所需套件
if(!require('ggplot2')) {install.packages('ggplot2'); library(ggplot2)}
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point(color = "blue") +
  labs(title = "PCA 二維投影", x = "主成分1 (PC1)", y = "主成分2 (PC2)") +
  theme_minimal()


