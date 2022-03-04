clone_dtkcore(){
    if test ! -d ./dtkcore
    then
        git clone -b 5.4.26 --depth=1 https://github.com/linuxdeepin/dtkcore.git
    fi
}

clone_dtkcore
mkdir -p build
cd build
qmake ../dtkcore "CONFIG+=staticlib"
make CC=xfuzz-cc CXX=xfuzz-c++ LINK=xfuzz-c++ V=1 -j
make install INSTALL_ROOT=$PWD/install

xfuzz-c++ ../target.cpp -o dtkcore-target -I./install/usr/include/libdtk-5.0.0/DCore  ./install/usr/lib/libdtkcore.a -isystem /usr/include/x86_64-linux-gnu/qt5 -isystem /usr/include/x86_64-linux-gnu/qt5/QtTest -isystem /usr/include/x86_64-linux-gnu/qt5/QtDBus -isystem /usr/include/x86_64-linux-gnu/qt5/QtCore -fPIC -lgsettings-qt /usr/lib/x86_64-linux-gnu/libQt5Xml.so /usr/lib/x86_64-linux-gnu/libQt5Test.so /usr/lib/x86_64-linux-gnu/libQt5DBus.so /usr/lib/x86_64-linux-gnu/libQt5Core.so -lpthread
