FROM gezp/ubuntu-desktop:20.04-cu11.0
#ENV DEBIAN_FRONTEND=noninteractive
RUN pip install --upgrade pip
COPY ./requirements.txt /data1/game_ai_sdk/
COPY ./requirements_SDKTool.txt /data1/game_ai_sdk/

RUN apt-get install -y cmake protobuf-compiler libprotobuf-dev libprotoc-dev \
    adb libboost-all-dev build-essential python3-opencv libqt5x11extras5 \
    python3-pyqt5 python3-pyqt5.qtwebengine
RUN apt-get autoclean
RUN cd /data1/game_ai_sdk/ && pip install -r requirements.txt && pip install -r requirements_SDKTool.txt

ARG OPENCV_GZ=opencv-3.4.2
COPY tools/docker/${OPENCV_GZ}.tar.gz /data1/${OPENCV_GZ}.tar.gz
RUN cd /data1/ && \
    tar -xvzf ${OPENCV_GZ}.tar.gz && \
    rm ${OPENCV_GZ}.tar.gz && \
    cd ${OPENCV_GZ} && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_EXAMPLES=ON .. && \
    make -j4 && \
    make install && \
    ldconfig
RUN rm -rf /data1/tools/docker/${OPENCV_GZ}.tar.gz && rm -rf /data1/${OPENCV_GZ}

ARG DOCKER_CUDA=GPU
COPY . /data1/game_ai_sdk/
RUN cd /data1/game_ai_sdk/Modules/tbus/libtbus/ && ./make_tbus.sh
RUN cd /data1/game_ai_sdk/Modules/darknetV3/src && ./InstallYoloV3.sh ${DOCKER_CUDA}
RUN cd /data1/game_ai_sdk/Modules/Json/jsoncpp-master && ./build.sh
ENV CPPFLAGS=-I/usr/include/python3.8
RUN cd /data1/game_ai_sdk/build && ./build.sh ${DOCKER_CUDA}

CMD ["/bin/bash"]
