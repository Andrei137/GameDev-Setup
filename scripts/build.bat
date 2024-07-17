@echo off
setlocal

rem Edit those
set MSVCVersion=14.39.33519
set MSVCPath=D:/Important Stuff/Visual Studio Web

rem Don't edit those
set Compiler="%MSVCPath%/VC/Tools/MSVC/%MSVCVersion%/bin/Hostx64/x64/cl.exe"
set Cmake="%MSVCPath%/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe"
set Ninja="%MSVCPath%/Common7/IDE/CommonExtensions/Microsoft/CMake/Ninja/ninja.exe"

cd ..
if exist build (
    rmdir /s /q build
)
if not exist bin (
    mkdir bin
)

call "%MSVCPath%/VC/Auxiliary/Build/vcvars64.bat"

%Cmake% -G "Ninja" ^
        -B build ^
        -S src ^
        -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=../bin ^
        -DCMAKE_C_COMPILER:FILEPATH=%Compiler% ^
        -DCMAKE_CXX_COMPILER:FILEPATH=%Compiler% ^
        -DCMAKE_MAKE_PROGRAM=%Ninja%

if %errorlevel% neq 0 (
    echo "CMake failed"
    cd scripts
    exit /b %errorlevel%
)

cd build
ninja
if %errorlevel% neq 0 (
    echo "Ninja build failed"
    cd ../scripts
    exit /b %errorlevel%
)
cd ..
rmdir /s /q build
cd scripts

endlocal
exit /b 0
