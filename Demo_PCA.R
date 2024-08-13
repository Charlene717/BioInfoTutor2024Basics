

Set_Demo <- "Demo1"

if(Set_Demo == "Demo1"){
  # 產生接近平面的三維資料
  set.seed(123)
  n <- 100
  X <- rnorm(n)
  Y <- 2 * X + rnorm(n, sd = 0.1)  # Y 和 X 緊密相關
  Z <- 0.5 * X + 0.5 * Y + rnorm(n, sd = 0.1)  # Z 也基本位於平面內

  data <- data.frame(X = X, Y = Y, Z = Z)
}else if(Set_Demo == "Demo2"){
  # 產生一些範例的三維資料
  set.seed(123)
  data <- data.frame(
    X = rnorm(100),
    Y = rnorm(100, mean = 5, sd = 2),
    Z = rnorm(100, mean = -3, sd = 1)
  )
}



# 執行PCA分析
pca_result <- prcomp(data, scale. = TRUE)


# 查看每個主成分的資訊量（解釋的變異比例）
explained_variance <- summary(pca_result)$importance[2,]
explained_variance


# 查看PCA結果的摘要
summary(pca_result)



# 使用plotly繪製3D散佈圖

# 檢查並安裝所需套件
if(!require('plotly')) {install.packages('plotly'); library(plotly)}

# 提取主成分
pca_data <- data.frame(pca_result$x)

# 定義PC1和PC2的平面
x_range <- seq(min(pca_data$PC1), max(pca_data$PC1), length.out = 100)
y_range <- seq(min(pca_data$PC2), max(pca_data$PC2), length.out = 100)

# 生成與 x_range 和 y_range 尺寸匹配的 z_plane 矩陣
z_plane <- matrix(0, nrow = length(x_range), ncol = length(y_range))

# 使用plotly繪製3D散佈圖，並添加PC1和PC2的透明平面和主成分解釋變異比例
fig <- plot_ly() %>%
  add_markers(data = pca_data, x = ~PC1, y = ~PC2, z = ~PC3, marker = list(color = 'blue')) %>%
  add_surface(x = ~x_range, y = ~y_range, z = ~z_plane, opacity = 0.2, showscale = FALSE) %>%
  layout(
    scene = list(
      xaxis = list(title = paste0('PC1 (', round(explained_variance[1] * 100, 2), '%)')),
      yaxis = list(title = paste0('PC2 (', round(explained_variance[2] * 100, 2), '%)')),
      zaxis = list(title = paste0('PC3 (', round(explained_variance[3] * 100, 2), '%)')),
      camera = list(
        eye = list(x = 1.25, y = 1.25, z = 1.25)
      )
    )
  )

# 顯示3D圖形
fig



# 繪製PCA結果的二維圖形
# 提取前兩個主成分
pca_data <- data.frame(pca_result$x[, 1:2])

# 檢查並安裝所需套件
if(!require('ggplot2')) {install.packages('ggplot2'); library(ggplot2)}
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point(color = "blue") +
  labs(title = "PCA 二維投影", x = "主成分1 (PC1)", y = "主成分2 (PC2)") +
  theme_minimal()


