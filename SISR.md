# 近年单帧图像超分算法简单汇总
|算法|全称|链接|内容|
|:-|:-|:-|:-|
|SRCNN| Image Super-Resolution Using Deep Convolutional Networks|[ECCV14](https://arxiv.org/pdf/1501.00092.pdf)|1. 开山之作<br>2. 三层卷积：图像块的提取和特征表示；特征非线性映射；最终的重建<br>3. 原图双三次插值(bicubic)<br>4. MSE损失函数有利于获得较高的PSNR|
|**FSRCNN**|Accelerating the Super-Resolution Convolutional Neural Network|[ECVV2016](https://arxiv.org/abs/1608.00367)|1. SRCNN改进<br>取消bicubic，输出使用反卷积放大<br>2. 更小的卷积维数和卷积核，更多的映射层,共享映射层<br>3. 五部分：特征提取；收缩；非线性映射；扩张；反卷积层<br>4. PReLu|
|ESPCN|Real-Time Single Image and Video Super-Resolution Using an Efficient Sub-Pixel Convolutional Neural Network|[CVPR2016](https://arxiv.org/abs/1609.05158)|1. 亚像素卷积层(sub-pixel convolutional layer)<br>2. tahn |
|**VDSR**|Accurate Image Super-Resolution Using Very Deep Convolutional Networks|[CVPR2016](https://arxiv.org/abs/1511.04587)|1. 20层网络，增加感受野<br>2. 引入残差学习和自适应梯度建材，收敛速度快<br>3. 卷积补0，保证特征图和输出图尺寸一致<br>4. 不同倍数混合训练|
|DRCB|Deeply-Recursive Convolutional Network for Image Super-Resolution|[CVPR2016](https://arxiv.org/abs/1511.04491)|1. 结果于VDSR接近<br>2. 递归神经网络<br>|
|RED|Image Restoration Using Convolutional Auto-encoders with Symmetric Skip Connections|[NIPS2016](https://arxiv.org/abs/1606.08921)|1. 对称卷积层-反卷积层网络结构<br>2. 30层，MSE|
|DRRN|Image Super-Resolution via Deep Recursive Residual Network|[CVPR2017](http://openaccess.thecvf.com/content_cvpr_2017/papers/Tai_Image_Super-Resolution_via_CVPR_2017_paper.pdf)|1.局部残差+全局残差+多权重递归学习<br>2. 52层|
|LapSRN|Deep Laplacian Pyramid Networks for Fast and Accurate Super-Resolution|[CVPR2017](https://arxiv.org/abs/1704.03915)|1. 针对之前的bicubic、反卷积和损失函数带来的问题<br>2.多级结构，每级完成2倍上采样<br>3.设计损失函数|
|**SRDenseNet**|Image Super-Resolution Using Dense Skip Connections|[CVPR2017](http://openaccess.thecvf.com/content_ICCV_2017/papers/Tong_Image_Super-Resolution_Using_ICCV_2017_paper.pdf)|1. CVPR2017 best paper<br>2. 引入稠密块(Dense Block)，特征串联(concatenate)<br>3.四部分：卷积层学习特征；稠密块映射特征；反卷积层学习上采样；卷积层生成图像|
|**SRGAN**|Photo-Realistic Single Image Super-Resolution Using a Generative Adversarial Network|[CVPR2017](https://arxiv.org/abs/1609.04802)|1.第一次引入GAN解决超分问题<br>2. 生成器SRResNet具有很好的结果<br>3. PSNR值一般，视觉效果很好|
|**EDSR**|Enhanced Deep Residual Networks for Single Image Super-Resolution|[CVPRW2017](https://arxiv.org/abs/1707.02921)|1. NTIRE2017冠军<br>2.在SRResNet上优化，去掉BN层后增加更多的网络层<br>3. 采用residual scaling方法<br>4. MDSR|
|RDN|Residual Dense Network for Image Super-Resolution|[CVPR2018](https://arxiv.org/abs/1802.08797)|1. 四层结构：SFENet；RDBS；DFF；UDNet:<br>2. Dense Block + Residual Block，针对残差块和稠密块做了修改|
|DBPN|Deep Back-Projection Networks For Super-Resolution|[CVPR2018](https://arxiv.org/abs/1803.02735)|1. 提出了Up-Projection Unit和Down-Projection Unit<br>2.引入稠密连接思想|
|**WDSR**|Wide Activation for Efficient and Accurate Image Super-Resolution|[CVPR2018](https://arxiv.org/abs/1808.08718)|1. NTIRE 2018冠军<br>2.推测Relu函数阻碍了信息从低层流入高层，因而工作重点增加特征输入<br>3. WDSR-A：增加Relu前的特征输入<br>4. WDSR-B：在A的基础上大卷积拆分2个小卷积<br>5.使用Weight Normalization代替BN|
|**CARN**|Fast, Accurate, and Lightweight Super-Resolution with Cascading Residual Network|[ECCV18](https://arxiv.org/abs/1803.08664)|1.轻量<br>2.残差结构级联 + 递归<br>3.引入稠密块思想，每个输出后用1x1卷积进行降维<br>4.组卷积代替卷积|
|EPSR|Analyzing Perception-Distortion Tradeoff using Enhanced Perceptual Super-resolution Network|[ECCV18](http://openaccess.thecvf.com/content_ECCVW_2018/papers/11133/Vasu_Analyzing_Perception-Distortion_Tradeoff_using_Enhanced_Perceptual_Super-resolution_Network_ECCVW_2018_paper.pdf)|1. GAN，基于EDSR和SRGAN改进<br>2.重构了损失函数|
