#!/bin/sh

echo "OpenCV installation by learnOpenCV.com"

echo "Installing OpenCV - 3.4.3"
 
#Specify OpenCV version
cvVersion="3.4.3"

# Clean build directories
rm -rf opencv
rm -rf opencv_contrib

# Save current working directory
cwd=$(pwd)
#sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install epel-release
sudo yum -y install git gcc gcc-c++ cmake3
sudo yum -y install qt5-qtbase-devel
sudo yum install -y python34 python34-devel python34-pip
sudo yum install -y python python-devel python-pip

sudo yum -y install python-devel numpy python34-numpy
sudo yum -y install gtk2-devel

sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum install -y ffmpeg #2.6.8
sudo yum install -y ffmpeg-devel

sudo yum install -y libpng-devel
sudo yum install -y jasper-devel
sudo yum install -y openexr-devel
sudo yum install -y libwebp-devel
sudo yum -y install libjpeg-turbo-devel 
sudo yum install -y freeglut-devel mesa-libGL mesa-libGL-devel
sudo yum -y install libtiff-devel 
sudo yum -y install libdc1394-devel
sudo yum -y install tbb-devel eigen3-devel
sudo yum -y install boost boost-thread boost-devel
sudo yum -y install libv4l-devel
sudo yum -y install gstreamer-plugins-base-devel

sudo pip3 install virtualenv virtualenvwrapper
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/bin/virtualenvwrapper.sh" >> ~/.bashrc
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh

############ For Python 3 ############
# create virtual environment
#python3.6 -m venv OpenCV-"$cvVersion"-py3
#echo "# Virtual Environment Wrapper" >> ~/.bashrc
#echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bashrc
#source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate
mkvirtualenv OpenCV-"$cvVersion"-py3 -p python3
workon OpenCV-"$cvVersion"-py3
pip install cmake 
pip install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
# quit virtual environment
deactivate
mkvirtualenv OpenCV-"$cvVersion"-py2 -p python2
workon OpenCV-"$cvVersion"-py2
pip install cmake
pip install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
# quit virtual environment
deactivate
######################################

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout tags/3.4.3
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout tags/3.4.3
cd ..

cd opencv
#echo 'set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")' >> opencv/CMakeLists.txt
#echo "find_package(OpenGL REQUIRED)" >>./samples/cpp/CMakeLists.txt
#echo "find_package(GLUT REQUIRED)" >> ./samples/cpp/CMakeLists.txt
#sed -i '38s/.*/  ocv_target_link_libraries(${tgt} ${OPENCV_LINKER_LIBS} ${OPENCV_CPP_SAMPLES_REQUIRED_DEPS} ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})/' ./samples/cpp/CMakeLists.txt
mkdir build
cd build
            
cmake3 -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_SKIP_PYTHON_LOADER=ON \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=$HOME/.virtualenvs/OpenCV-$cvVersion-py3/lib/python3.4/site-packages \
            -D OPENCV_PYTHON2_INSTALL_PATH=$HOME/.virtualenvs/OpenCV-$cvVersion-py2/lib/python2.7/site-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D ENABLE_CXX11=ON \
        -D BUILD_EXAMPLES=ON ..

make -j$(nproc)
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
cd $cwd

#=========================================================================
rm -rf opencv
rm -rf opencv_contrib
echo "Installing OpenCV - 3.4.4"
 
#Specify OpenCV version
cvVersion="3.4.4"

# Create directory for installation
mkdir installation
mkdir installation/OpenCV-"$cvVersion"

############ For Python 3 ############
# create virtual environment
#python3.6 -m venv OpenCV-"$cvVersion"-py3
#echo "# Virtual Environment Wrapper" >> ~/.bashrc
#echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bashrc
#source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate
mkvirtualenv OpenCV-"$cvVersion"-py3 -p python3
workon OpenCV-"$cvVersion"-py3
pip install cmake 
pip install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
# quit virtual environment
deactivate
mkvirtualenv OpenCV-"$cvVersion"-py2 -p python2
workon OpenCV-"$cvVersion"-py2
pip install cmake
pip install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
# quit virtual environment
deactivate
######################################

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 3.4
cd ..
 
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 3.4
cd ..

cd opencv
#echo "find_package(OpenGL REQUIRED)" >>./samples/cpp/CMakeLists.txt
#echo "find_package(GLUT REQUIRED)" >> ./samples/cpp/CMakeLists.txt
#sed -i '38s/.*/  ocv_target_link_libraries(${tgt} ${OPENCV_LINKER_LIBS} ${OPENCV_CPP_SAMPLES_REQUIRED_DEPS} ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})/' ./samples/cpp/CMakeLists.txt
mkdir build
cd build


cmake3 -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_SKIP_PYTHON_LOADER=ON \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=$HOME/.virtualenvs/OpenCV-$cvVersion-py3/lib/python3.4/site-packages \
            -D OPENCV_PYTHON2_INSTALL_PATH=$HOME/.virtualenvs/OpenCV-$cvVersion-py2/lib/python2.7/site-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D ENABLE_CXX11=ON \
        -D BUILD_EXAMPLES=ON ..
        
make -j$(nproc)
make install

cd $cwd

#=========================================================================
rm -rf opencv
rm -rf opencv_contrib
echo "Installing OpenCV - 4.0.0"
 
#Specify OpenCV version
cvVersion="master"

# Create directory for installation
mkdir installation
mkdir installation/OpenCV-"$cvVersion"

############ For Python 3 ############
# create virtual environment
#python3.6 -m venv OpenCV-"$cvVersion"-py3
#echo "# Virtual Environment Wrapper" >> ~/.bashrc
#echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bashrc
#source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate
mkvirtualenv OpenCV-"$cvVersion"-py3 -p python3
workon OpenCV-"$cvVersion"-py3
pip install cmake 
pip install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
# quit virtual environment
deactivate
mkvirtualenv OpenCV-"$cvVersion"-py2 -p python2
workon OpenCV-"$cvVersion"-py2
pip install cmake
pip install numpy scipy matplotlib scikit-image scikit-learn ipython dlib
# quit virtual environment
deactivate
######################################

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout master
cd ..
 
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout master
cd ..

cd opencv

echo "find_package(OpenGL REQUIRED)" >>./samples/cpp/CMakeLists.txt
echo "find_package(GLUT REQUIRED)" >> ./samples/cpp/CMakeLists.txt
sed -i '38s/.*/  ocv_target_link_libraries(${tgt} ${OPENCV_LINKER_LIBS} ${OPENCV_CPP_SAMPLES_REQUIRED_DEPS} ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})/' ./samples/cpp/CMakeLists.txt
mkdir build
cd build

cmake3 -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_SKIP_PYTHON_LOADER=ON \
            -D OPENCV_GENERATE_PKGCONFIG=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=$HOME/.virtualenvs/OpenCV-$cvVersion-py3/lib/python3.4/site-packages \
            -D OPENCV_PYTHON2_INSTALL_PATH=$HOME/.virtualenvs/OpenCV-$cvVersion-py2/lib/python2.7/site-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D ENABLE_CXX11=ON \
        -D BUILD_EXAMPLES=ON ..
        
make -j$(nproc)
make install

cd $cwd

rm -rf opencv
rm -rf opencv_contrib
