#!/bin/bash

# DEPENDECIES
GAZEBO_BASE_DEPENDENCIES="libogre-1.9-dev                  \\
                          libbullet-dev                    \\
                          python-protobuf                  \\
                          libprotoc-dev                    \\
                          libprotobuf-dev                  \\
                          libfreeimage-dev                 \\
                          protobuf-compiler                \\
                          libboost-thread-dev              \\
                          libboost-signals-dev             \\
                          libboost-system-dev              \\
                          libboost-filesystem-dev          \\
                          libboost-program-options-dev     \\
                          libboost-regex-dev               \\
                          libboost-iostreams-dev           \\
                          freeglut3-dev                    \\
                          libqt4-dev                       \\
                          libcurl4-openssl-dev             \\
                          libtar-dev                       \\
                          libtbb-dev                       \\
                          libgts-dev                       \\
                          uuid-dev                         \\
                          libswscale-dev                   \\
                          libavformat-dev                  \\
                          libavcodec-dev                   \\
                          libgraphviz-dev                  \\
                          libhdf5-dev                      \\
                          libopenal-dev                    \\
                          pkg-config"
GAZEBO_BASE_DEPENDENCIES=$(sed 's:\\ ::g' <<< $GAZEBO_BASE_DEPENDENCIES)

apt-get -y install ${GAZEBO_BASE_DEPENDENCIES}

# DOWNLOAD GAZEBO
mkdir /revolve
cd /revolve

hg clone https://bitbucket.org/ElteHupkes/gazebo
cd gazebo
hg up gazebo6-revolve

# BUILD GAZEBO
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE="Release" \
         -DCMAKE_INSTALL_PREFIX=/usr \
         -DENABLE_SSE4=True \
         -DENABLE_TESTS_COMPILATION:BOOL=False
make -j4

# INSTALL GAZEBO
make install

rm -r gazebo
