# Beyond a Gaussian Denoiser: Residual Learning of Deep CNN for Image Denoising

## Abstract-DnCnn

- 首次使用残差学习降噪
- 残差 + BN 大幅度提高速度降噪模型的训练速度
- 可以扩展到一般降噪任务：盲高斯去躁、单图超分和JPEG去块任务。

------

## The proposed denoise CNN model

- 设计好的网络结构以及从训练数据中学习
- 修改自VGG，添加残差往和BN层提高模型训练速度和去躁表现

### Network Depth

- 设置正确的网络深度可以在表现和性能中取得好的平衡
- 除去池化层可以增大图片感受野
- 去躁感受野的大小与去躁斑块大小有关
- 通过将噪声水平设置在25，对于高斯噪声，设置深度为17，感受野为35x35大小；对于普通的去躁任务，深度设为20

### Network Architecture

​	网络输出之间改为残差图像，DnCNN优化目标为真实残差图片与网络输出之间的MSE（loss）

- Deep Architecture： 3 部分
  - Conv + Relu： 仅一层，3 x 3 x c x 64 c表示通道数， c=1 指灰度图，c=3指彩图； Relu激活函数；
  - Conv + BN + Relu : 2~ （D-1)层，Conv（3 * 3 * 64 * 64）+BN(batch normalization)+ReLu
  - Conv: 最后一层，3x3x64xc 表示通道数
- Reducing Boundary Artifacts: 减小边界伪影
  - 不考虑padding，忽略边缘影响，保持中间层输出与输入一致

### Integration of Residual Learning and Batch Normalization for Image Denoising

- 在超分领域，低分辨率图片就是高分辨率图片的双三次上采样操作形成的，故超分领域的残差图片和去高斯噪声领域的残差图片是等价的，同理还有JPEG解锁领域的残差图片。

- RL 和 BN 可以增加训练速度和效果

  ![1567674897164](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1567674897164.png)

  

  
