FROM ubuntu:14.04
MAINTAINER Raymond Barbiero <raymond.barbiero.dev@gmail.com>

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

ADD installer /installer

RUN echo "deb-src http://archive.ubuntu.com/ubuntu trusty main" >> /etc/apt/sources.list \
&& sed 's/main$/main universe/' -i /etc/apt/sources.list \
&& apt-get -q -y update \
&& apt-get -q -y upgrade \
&& apt-get -q -y install cmake g++ git-core libboost-python-dev libboost-dev \
    libboost-program-options-dev libboost-iostreams-dev libboost-thread-dev libboost-test-dev \
    libboost-system-dev libltdl-dev libsnappy-dev libboost-regex-dev debhelper \
    python-dev cdbs devscripts python-support libleveldb-dev libcurl4-openssl-dev libxml2-dev \
    python-pip equivs libssl-dev   binutils-dev libarchive-dev libboost-filesystem-dev \
    libboost-filesystem1.54-dev libboost-filesystem1.54.0 libcgroup-dev bash-completion \
    libcgroup1 libev-dev libev4 libmsgpack-dev libmsgpack3 libmsgpackc2 uuid-dev \
    python-msgpack python-tornado python-opster python-pycurl python-mysqldb python-virtualenv \
&& apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*


ENV REFRESHED_AT 2014-09-12


ENV BLACKHOLE_VER v0.2
RUN true \
  && git clone https://github.com/3Hren/blackhole.git -b $BLACKHOLE_VER \
  && cd blackhole  \
    && git submodule init \
    && git submodule update \
    && debuild --no-tgz-check -sa \
  ; cd .. \
  && dpkg -i blackhole-dev_*_amd64.deb


ENV REACT_VER v2.3.1
RUN true \
  && git clone https://github.com/reverbrain/react.git -b $REACT_VER \
  && cd react  \
    && debuild -sa \
  ; cd .. \
  && dpkg -i react_*_amd64.deb react-dev_*_amd64.deb


ENV EBLOB_VER v0.22.6
RUN true \
  && git clone http://github.com/reverbrain/eblob.git -b $EBLOB_VER \
  && cd eblob  \
    && debuild -sa \
  ; cd .. \
  && dpkg -i eblob_*_amd64.deb


ENV COCAINE_VER v0.11
RUN true \
  && git clone http://github.com/cocaine/cocaine-core.git -b $COCAINE_VER \
  && cd cocaine-core  \
    && git submodule init \
    && git submodule update \ 
    && debuild -sa \
  ; cd .. \
  && dpkg -i cocaine-dbg_*_amd64.deb cocaine-runtime_*_amd64.deb libcocaine-core2_*_amd64.deb libcocaine-dev_*_amd64.deb


RUN true \
  && git clone http://github.com/cocaine/cocaine-framework-python.git -b $COCAINE_VER \
  && cd cocaine-framework-python  \
    && debuild -sa \
  ; cd .. \
  && dpkg -i cocaine-framework-python_*_amd64.deb


RUN true \
  && git clone http://github.com/cocaine/cocaine-framework-native.git -b $COCAINE_VER \
  && cd cocaine-framework-native  \
    && debuild -sa \
  ; cd .. \
  && dpkg -i cocaine-framework-native_*_amd64.deb cocaine-framework-native-dbg_*_amd64.deb cocaine-framework-native-dev_*_amd64.deb


RUN true \
  && git clone http://github.com/cocaine/cocaine-tools.git -b $COCAINE_VER \
  && cd cocaine-tools  \
    && debuild -sa \
  ; cd .. \
  && dpkg -i cocaine-tools_*_amd64.deb


ENV ELLIPTICS_VER v2.25
RUN true \
  && git clone http://github.com/reverbrain/elliptics.git -b $ELLIPTICS_VER \
  && cd elliptics  \
    && git submodule init \
    && git submodule update \
    && debuild -sa \
  ; cd .. \
  && dpkg -i elliptics-client_*_amd64.deb elliptics_*_amd64.deb elliptics-dev_*_amd64.deb


#ENV SWARM_VER v0.7.0.8
#RUN true \
#  && git clone http://github.com/reverbrain/swarm.git -b $SWARM_VER \
#  && cd swarm  \
#    && debuild -sa \
#  ; cd .. \
#  && dpkg -i libswarm*_amd64.deb

CMD /installer
