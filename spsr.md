# Structure-Preserving Super Resolution with Gradient Guidance

## 简介

 	作者为了解决GAN方法在SISR任务中存在结构扭曲的问题，提出了一种结构保持的超分方法。\
  具体来说在两方面采用梯度图：1）通过一个梯度分支来恢复HR的梯度图，为SR提供先验信息；\
  2）提出了一个梯度损失，为图像施加二阶先验限制；作者认为梯度信息更能保持图像几何结构，且该方法是无关模型结构的；该文章达到了较好的PI值和LPIPS值同时具有较好的PSNR值和SSIM值，并且生成了不错的结果；

## 模型结构

![28953e2d-9b1d-4a41-a576-0b0e409e664d](D:\我的文档\11103931\Desktop\28953e2d-9b1d-4a41-a576-0b0e409e664d.png)

模型整体结构分为两个分支：SR分支和梯度分支；

### 1.梯度分支

![23b15628-ff83-4706-8e8c-51b0f6bee759](D:\我的文档\11103931\Desktop\23b15628-ff83-4706-8e8c-51b0f6bee759.png)

​	作者在此处并未考虑图像梯度的方向，仅仅将**梯度强度**信息作为梯度图来参与生成SR的过程。因为作者认为梯度强度信息足以说明图像局部区域的边缘锐度。

​	作者通过SR分支的中间层信息作为先验从而提高梯度分支的性能；SR分支两个SR模块后和SR分支的梯度块进行concat后送入下一层梯度块；

### 2. 结构保持分支

​	常规的超分分支可以是任意网络，这里作者选择的是Residual in Residual Densse Block(RRDB)残差块，即ESRGAN的主要分支；作者采用了23个RRDB块，并且提取了第5层，10层，15层以及20层的特征与梯度分支融合；

​	结构保持分支的第二部分是通过一个fusion Block 将梯度部分融合，具体来说就是把两个特征concat合并并且使用一个RRDB 和一个conv重建最后的特征

### 3. 目标函数

#### Conventional Loss:

Pixelwise loss: L1 loss

Perceptual loss: 使用预训练的VGG网络然后用欧式距离计算HR和SR之间差值

Gan loss: RaGan: relativistic average Gan (即求平均)

#### Gradient Loss:

![a6c35410-6a69-4ae0-847b-787fc4e49f1a](D:\我的文档\11103931\Desktop\a6c35410-6a69-4ae0-847b-787fc4e49f1a.png)

​	作者对梯度保持结构信息的思想可以用上图解释，作者认为Sharp SR的梯度与HR较Blurry SR的梯度更加接近，因此采用一个二阶约束对形成锐利边缘更加有利。

​	梯度loss设计也比较简单，conventional loss一致

#### Overall Objective

![62691286-3090-4980-b7f6-a5231cca2346](D:\我的文档\11103931\Desktop\62691286-3090-4980-b7f6-a5231cca2346.png)

## 实验![bb8758a8-f844-45e0-8f8b-53d62b045adb](D:\我的文档\11103931\Desktop\bb8758a8-f844-45e0-8f8b-53d62b045adb.png)



<img src="D:\我的文档\11103931\Desktop\2e24adc8-6f9b-4424-85b1-36dbef473af7.png" alt="2e24adc8-6f9b-4424-85b1-36dbef473af7" style="zoom:150%;" />
