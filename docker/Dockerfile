FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
RUN apt -y update
RUN apt-get install -y apt-transport-https

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN  apt install -y \
    python3-pip \
    sudo \
    wget \
    git \
    vim  \
    curl \
    ca-certificates \
    bzip2 \
    libx11-6 \
    build-essential \
    screen \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-venv \
    python3-pip \
    graphviz \
    libopenmpi-dev \
    tmux \
    liblzma-dev \
    libbz2-dev




ARG USER=gs
ARG PASSWD=gs
RUN useradd -m $USER && \
    echo "$USER:$PASSWD" | chpasswd && \
    echo "$USER ALL=(ALL) ALL" >> /etc/sudoers && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /run/sshd
RUN mkdir /home/$USER/.ssh/
RUN echo 'gs:gs' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config


RUN apt install -y libreadline-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev zlib1g-dev liblzma-dev  libreadline-dev libsqlite3-dev libopencv-dev ffmpeg

RUN apt install -y libglew-dev libassimp-dev libboost-all-dev libgtk-3-dev libglfw3-dev  \
    libavdevice-dev libavcodec-dev libeigen3-dev libxxf86vm-dev libembree-dev ninja-build 

#Colmap
RUN apt-get install -y \
    cmake \
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev


RUN apt-get -y install gcc-10 g++-10
# ENV CC=/usr/bin/gcc-10
# ENV CXX=/usr/bin/g++-10
# ENV CUDAHOSTCXX=/usr/bin/g++-10
# ENV CUDA_HOME=/usr/local/cuda-11.8
# ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11-8/lib64
# ENV PATH=$PATH:$CUDA_HOME/bin
RUN git clone https://github.com/colmap/colmap.git
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER $USER
RUN echo  "export CC=/usr/bin/gcc-10" >> ~/.bashrc
RUN echo  "export CXX=/usr/bin/g++-10" >> ~/.bashrc
RUN echo  "export CUDAHOSTCXX=/usr/bin/g++-10" >> ~/.bashrc
# RUN echo  "export CUDACXX=/usr/bin/g++-10" >> ~/.bashrc
RUN echo  "export  CUDACXX=/usr/local/cuda-11.8/bin/nvcc" >> ~/.bashrc
RUN echo  "export CUDA_HOME=/usr/local/cuda-11.8" >> ~/.bashrc
RUN echo  "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11-8/lib64" >> ~/.bashrc
RUN echo  "export PATH=$PATH:$CUDA_HOME/bin"  >> ~/.bashrc
USER root
# TODO change GNINJA
ARG CUDA_ARCHITECTURES=89
RUN cd /colmap && mkdir -p /colmap/build && cd /colmap/build &&  cmake /colmap -GNinja -DCMAKE_CUDA_ARCHITECTURES=$CUDA_ARCHITECTURES && ninja && ninja install


USER root
#############################################

# WORKDIR /colmapdir
# RUN mkdir build && cmake .. -GNinja && ninja && ninja install && colmap -h


# Change mov to mp4
# ffmpeg -i Bonsai01.mov -q:v 0 Bonsai01.mp4

# change movie to images
# mkdir input
# ffmpeg -i Bonsai01.mov -r 4 input/image_%05d.jpg

# git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
# git submodule update --init

# python3 -m venv /env_gs/ 
# sudo chown -R gs:gs /env_gs/
# pip install https://download.pytorch.org/whl/cu118/torch-2.0.0%2Bcu118-cp310-cp310-linux_x86_64.whl#sha256=4b690e2b77f21073500c65d8bb9ea9656b8cb4e969f357370bbc992a3b074764
# pip install submodules/diff-gaussian-rasterization/
# pip install submodules/simple-knn/

# git clone https://github.com/VITA-Group/LightGaussian.git


