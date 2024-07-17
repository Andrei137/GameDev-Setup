cd ..
if [ -d "build" ]; then
    rm -rf build
fi
if [ ! -d "bin" ]; then
    mkdir bin
fi
cmake -G "Ninja" -B "build" -S src -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=../bin

if [ $? -ne 0 ]; then
    echo "CMake failed"
    cd scripts
    exit $?
fi

cd build
ninja

if [ $? -ne 0 ]; then
    echo "Ninja build failed"
    cd ../scripts
    exit $?
fi

cd ..
rm -rf build
cd scripts