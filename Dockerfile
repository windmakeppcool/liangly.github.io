# image tag    | public_dev/ubuntu18.04-cuda10.0-cudnn7:python3.6.5-tensorflow1.14-mxnet1.5-pytorch1.2-opencv3.4.4
# usage        | dev
# os           | ubuntu 18.04
# nvidia       | cuda 10.0 + cudnn 7 + nccl 2.4.8
# anaconda     | python 3.6.5
# DNN frame    | tensorflow 1.14 + tensorpack 0.9.5 + mxnet 1.5.0 + torch 1.2 + torchversion 0.4
# openmpi      | 4.0.0
# pip packages | opencv 3.4.4, tqdm, h5py, Pillow, keras ...

From nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

MAINTAINER vivo-ai-basic/cv/liuzhiwen

SHELL ["/bin/bash", "-cu"]
RUN apt update ; apt install -y cmake make git wget sudo bzip2 lrzsz

# install opencv-dependences
RUN apt install -y libsm-dev libxrender-dev ffmpeg libpng-dev libjpeg-dev libtiff5-dev libwebp-dev

# install gcc-4.9
RUN mkdir /tmp/gcc-4.9-deb && cd /tmp/gcc-4.9-deb && \
	wget http://launchpadlibrarian.net/247707088/libmpfr4_3.1.4-1_amd64.deb && \
	wget http://launchpadlibrarian.net/253728424/libasan1_4.9.3-13ubuntu2_amd64.deb && \
	wget http://launchpadlibrarian.net/253728426/libgcc-4.9-dev_4.9.3-13ubuntu2_amd64.deb && \
	wget http://launchpadlibrarian.net/253728314/gcc-4.9-base_4.9.3-13ubuntu2_amd64.deb && \
	wget http://launchpadlibrarian.net/253728399/cpp-4.9_4.9.3-13ubuntu2_amd64.deb && \
	wget http://launchpadlibrarian.net/253728404/gcc-4.9_4.9.3-13ubuntu2_amd64.deb && \
	wget http://launchpadlibrarian.net/253728432/libstdc++-4.9-dev_4.9.3-13ubuntu2_amd64.deb && \
	wget http://launchpadlibrarian.net/253728401/g++-4.9_4.9.3-13ubuntu2_amd64.deb 
RUN cd /tmp/gcc-4.9-deb && dpkg -i gcc-4.9-base_4.9.3-13ubuntu2_amd64.deb && \
	dpkg -i libmpfr4_3.1.4-1_amd64.deb && \
	dpkg -i libasan1_4.9.3-13ubuntu2_amd64.deb && \
	dpkg -i libgcc-4.9-dev_4.9.3-13ubuntu2_amd64.deb && \
	dpkg -i cpp-4.9_4.9.3-13ubuntu2_amd64.deb && \
	dpkg -i gcc-4.9_4.9.3-13ubuntu2_amd64.deb && \
	dpkg -i libstdc++-4.9-dev_4.9.3-13ubuntu2_amd64.deb && \
	dpkg -i g++-4.9_4.9.3-13ubuntu2_amd64.deb
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

# install nccl
COPY ./packages/nccl-repo-ubuntu1804-2.4.8-ga-cuda10.0_1-1_amd64.deb /tmp/nccl2.deb
RUN dpkg -i /tmp/nccl2.deb && apt update ; \
	apt install -y --allow-change-held-packages libnccl2=2.4.8-1+cuda10.0 libnccl-dev=2.4.8-1+cuda10.0

# install mpi
COPY ./packages/openmpi-4.0.0.tar.gz   /tmp/openmpi-4.0.0.tar.gz
RUN cd /tmp && \
	tar zxf openmpi-4.0.0.tar.gz && \
	cd openmpi-4.0.0 && \
        ./configure --enable-orterun-prefix-by-default && \
    	make -j8 all && \
    	make  install && \
    	ldconfig && \
	rm -rf /tmp/openmpi-4.0.0

# install openssh
RUN apt install -y openssh-client openssh-server && mkdir -p /var/run/sshd
COPY ./packages/ssh_vtraining.tar /tmp/ssh_vtraining.tar
RUN tar xf /tmp/ssh_vtraining.tar -C /tmp && \
    mv /etc/ssh /etc/ssh_bak && \
    cp -r /tmp/ssh_vtraining/ssh /etc/ && \
    cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config
RUN cp -r /tmp/ssh_vtraining/.ssh /root/ && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/authorized_keys && \
    chmod 600 /etc/ssh/*

# install anaconda 
COPY ./packages/Anaconda3-5.2.0-Linux-x86_64.sh /tmp/anaconda.sh
RUN chmod +x /tmp/anaconda.sh && bash /tmp/anaconda.sh -b -p /opt/anaconda3 && rm /tmp/anaconda.sh
ENV PATH /opt/anaconda3/bin:$PATH
 
RUN pip install --upgrade pip && pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
	addict==2.2.1 \
	chardet==3.0.4 \
	cvbase==0.5.5 \
	numpy==1.16.4 
RUN pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
	opencv-python==3.4.4.19 \
	Pillow==6.0.0 \
	scikit-image==0.14.2 \
	protobuf==3.8.0 
RUN pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
	scipy==1.2.1 \
	tensorboardX==1.8 \
	mmcv==0.2.10 \
	tqdm==4.32.1 \
	terminaltables==3.1.0 
RUN pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
	torch==1.2.0 \
	torchvision==0.4.0 
RUN conda remove wrapt
RUN pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
	setuptools==41.0.0 \
	tensorflow-gpu==1.14.0 \
	tensorpack==0.9.5 
RUN pip install -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
	mxnet-cu100==1.5.0
	 
# install horovord
RUN ldconfig /usr/local/cuda/targets/x86_64-linux/lib/stubs && \
    	HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_PYTORCH=1 HOROVOD_WITH_TENSORFLOW=1 HOROVOD_WITH_MXNET=1 \
        pip install --no-cache-dir horovod && \
    	ldconfig

# change timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install tzdata && mv /etc/localtime /etc/localtime.bak && \
	ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
# change PS1 -[0.0.3]
RUN echo "PS1=\"\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\h\e[m:\e[m\\\$PWD\e[m\e[1;37m]\e[m\e[1;36m\e[m\n\$ \"" >> /root/.bashrc && \
	echo "PS1=\"\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\h\e[m:\e[m\\\$PWD\e[m\e[1;37m]\e[m\e[1;36m\e[m\n\$ \"" >> /etc/bash.bashrc

# install vim8
RUN apt install -y python3.6-dev libncurses5-dev libncursesw5-dev
COPY ./packages/vim_packages.tar /tmp/vim_packages.tar
RUN cd /tmp && tar xf vim_packages.tar && cd vim_packages && tar xf vim.tar && \
	cd /tmp/vim_packages/vim && ./configure --with-features=huge \
	--enable-multibyte \
        --enable-python3interp \
        --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
        --enable-cscope \
	--prefix=/usr && \
	make VIMRUNTIMEDIR=/usr/share/vim/vim81 && make install && rm -rf /tmp/vim_packages/vim

# install plugin in vim8
ENV VIM=/etc/vim
RUN mkdir /etc/vim && mkdir /etc/vim/bundle && \
	cp /tmp/vim_packages/vimrc /etc/vim/vimrc && \
	cp /tmp/vim_packages/ycm_extra_conf.py /etc/vim/ycm_extra_conf.py && \
	cp -r /tmp/vim_packages/Vundle.vim /etc/vim/bundle/Vundle.vim && \
	echo | echo | vim +PluginInstall +qall &>/dev/null && \
	rm -rf /tmp/vim_packages && rm /tmp/vim_packages.tar
RUN cd /etc/vim/bundle/YouCompleteMe && python install.py --clang-completer 

# install python-prctl
RUN apt install -y libcap-dev && pip install python-prctl

# install libzmq
RUN apt install -y libzmq3-dev

# change default sh to bash - [0.0.2]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# repair chinese show problem - [0.0.5]
RUN apt install -y locales && locale-gen en_US.UTF-8 && echo "export LC_ALL=en_US.UTF-8" >> /etc/bash.bashrc

# repair other user's env - [0.0.6
RUN echo "export VIM=/etc/vim" >> /etc/bash.bashrc && echo "export PATH=/opt/anaconda3/bin:\$PATH" >> /etc/bash.bashrc
