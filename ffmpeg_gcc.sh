##FFMPEG Build - Ubuntu 22.04
##Apr-03-2024

SRCDIR="/opt/ffmpeg/src"
BUILDIR="/opt/ffmpeg/build"
PATH="${BUILDIR}/bin:$PATH"

mkdir -p ${SRCDIR}
mkdir -p ${BUILDIR}

apt-get update

##libx264, dependency nasm, requires --emable-gpl --enable-libx264
apt-get -y install nasm build-essential
cd ${SRCDIR} && \
git clone --depth 1 https://code.videolan.org/videolan/x264.git && \
cd x264 && \
./configure --prefix="${BUILDIR}" --bindir="${BUILDIR}/bin" --enable-static --enable-pic && \
make && \
make install

##libx265, dependency cmake, requires --enable-gpl --enable-libx265
apt-get -y install cmake
cd ${SRCDIR} && \
git clone --depth 1 https://bitbucket.org/multicoreware/x265_git.git && \
cd x265_git/build/linux && \
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${BUILDIR}" -DENABLE_SHARED=off ../../source && \
make && \
make install
