#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing dependencies for SDRAngel..."

sudo apt update

# Install general prerequisites for SDRAngel
sudo apt-get install -y libopencv-dev libxml2-dev libavcodec-dev libavformat-dev \
                        graphviz bison flex ffmpeg libopus-dev libfaad-dev \
                        libqt5webengine5 qtwebengine5-dev qtbase5-private-dev \
                        libhidapi-dev libsamplerate0-dev libqt5gamepad5-dev \
                        libxtrx-dev libqt5websockets5-dev

# Text to speech (optional)
sudo apt install -y espeak libespeak1 speech-dispatcher-espeak libqt5texttospeech5 \
                    libqt5texttospeech5-dev qtbase5-dev qtdeclarative5-dev \
                    qtspeech5-speechd-plugin

# Make the installation directories and assign ownership
sudo mkdir -p /opt/build
sudo chown dietpi:dietpi /opt/build
sudo mkdir -p /opt/install
sudo chown dietpi:dietpi /opt/install

# Set up workspace for SDRAngel dependencies
mkdir -p ~/SDRangel
cd ~/SDRangel

# Install APTdec
git clone https://github.com/srcejon/aptdec.git
cd aptdec
git checkout libaptdec
git submodule update --init --recursive
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/aptdec ..
make -j$(nproc) install

# Install CM265cc
cd ~/SDRangel
git clone https://github.com/f4exb/cm256cc.git
cd cm256cc
git reset --hard c0e92b92aca3d1d36c990b642b937c64d363c559
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/cm256cc ..
make -j$(nproc) install

# Install LibDAB
cd ~/SDRangel
git clone https://github.com/srcejon/dab-cmdline.git
cd dab-cmdline/library
git checkout msvc
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/libdab ..
make -j$(nproc) install

# Install MBElib
cd ~/
git clone https://github.com/szechyjs/mbelib.git
cd mbelib
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Install SerialDV
cd ~/SDRangel
git clone https://github.com/f4exb/serialDV.git
cd serialDV
git reset --hard "v1.1.4"
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/serialdv ..
make -j$(nproc) install

# Install DSDcc
cd ~/SDRangel
git clone https://github.com/f4exb/dsdcc.git
cd dsdcc
git reset --hard "v1.9.4"
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/dsdcc -DUSE_MBELIB=ON \
-DLIBSERIALDV_INCLUDE_DIR=/opt/install/serialdv/include/serialdv \
-DLIBSERIALDV_LIBRARY=/opt/install/serialdv/lib/libserialdv.so ..
make -j$(nproc) install

# Install Codec2/FreeDV
cd ~/
git clone https://github.com/drowe67/codec2.git
cd codec2
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
sudo install -m 0755 src/freedv_rx /usr/local/bin
sudo install -m 0755 src/freedv_tx /usr/local/bin
cd ../..
sudo ldconfig

# Install SGP4
cd ~/SDRangel
git clone https://github.com/dnwrnr/sgp4.git
cd sgp4
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/sgp4 ..
make -j$(nproc) install

# Install LibSigMF
cd ~/SDRangel
git clone https://github.com/f4exb/libsigmf.git
cd libsigmf
git checkout "new-namespaces"
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/opt/install/libsigmf ..
make -j$(nproc) install

sudo ldconfig

# Install SDRangel
cd ~/SDRangel
git clone https://github.com/f4exb/sdrangel.git
cd sdrangel
mkdir build
cd build
cmake -Wno-dev -DDEBUG_OUTPUT=ON -DRX_SAMPLE_24BIT=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DHACKRF_DIR=/usr/local \
      -DRTLSDR_DIR=/usr/lib/aarch64-linux-gnu \
      -DSOAPYSDR_DIR=/usr/local \
      -DUHD_DIR=/usr/local \
      -DAPT_DIR=/opt/install/aptdec \
      -DCM256CC_DIR=/opt/install/cm256cc \
      -DDSDCC_DIR=/opt/install/dsdcc \
      -DSERIALDV_DIR=/opt/install/serialdv \
      -DSGP4_DIR=/opt/install/sgp4 \
      -DLIBSIGMF_DIR=/opt/install/libsigmf \
      -DDAB_DIR=/opt/install/libdab \
      -DCMAKE_INSTALL_PREFIX=/opt/install/sdrangel ..
make -j$(nproc) install

print_info "Generating FFTW wisdom file..."
cd ~/.config/
mkdir -p f4exb
cd f4exb
fftwf-wisdom -n -o fftw-wisdom 128 256 512 1024 2048 4096 8192 16384 32768

print_info "Installation and setup of SDRangel completed!"

