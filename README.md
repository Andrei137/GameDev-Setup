## Options
  - GLFW + OpenGL
  - Raylib
  - SFML

## Structure
  - ```bin``` is the folder which will contain the executable after building the project
  - ```resources``` is the folder where all resources are stored
  - ```scripts``` is the folder where all the scripts are stored
  - ```src``` is the folder with all C++ files and with CMakeLists.txt
    - For GLFW, <kbd>sources/game_layer.cpp</kbd> has the main game loop
    - For SFML/Raylib, <kbd>main.cpp</kbd> has the main game loop
    - <kbd>.cpp</kbd> files go into ```sources```, and <kbd>.h/.hpp</kbd> files go into ```includes```
    - There is no need to edit <kbd>CMakeLists.txt</kbd> when adding new files

## Adding third party libraries
  - Add the whole library inside ```src/thirdparty``` (make sure it has a <kbd>CMakeLists.txt</kbd>)
  - Open <kbd>src/CMakeLists.txt</kbd>
  - Add <kbd>add_subdirectory(thirdparty/&lt;library_name&gt;)</kbd> under the others
  - Add <kbd>&lt;library_name&gt;</kbd> in <kbd>target_link_libraries("${CMAKE_PROJECT_NAME}"</kbd> under the others
  - Keep in mind to replace <kbd>&lt;library_name&gt;</kbd> with the actual library name


## Dependencies

#### Windows
  - [MSVC](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&channel=Release&version=VS2022&source=VSLandingPage&cid=2030&passive=false)
  - [MinGW](https://github.com/niXman/mingw-builds-binaries/releases/download/13.2.0-rt_v11-rev1/x86_64-13.2.0-release-posix-seh-ucrt-rt_v11-rev1.7z) (in case the SFML build fails)
  - [Make](https://deac-riga.dl.sourceforge.net/project/gnuwin32/make/3.81/make-3.81.exe?viasf=1) (in case the SFML build fails)

#### Environment Variables for Windows
  - Search ```Edit the system environment variables``` and open it
  - Select ```Environment variables```
  - Under ```System variables```, double click ```Path```
  - Select new and add the following:
      - **MSVC:** `<path_to_msvc>/VC/Tools/MSVC/<version>/bin` and `<path_to_msvc>/VC/Tools/MSVC/<version>/include`
      - **CMake:** `<path_to_msvc>/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin`
      - **MinGW:** `<path_to_mingw>/bin`
      - **Make:** `<path_to_make>/bin`

#### Linux
  - WIP

### In case the SFML build fails
  - You need to install the following
##### OpenAL
  - Download [OpenAL](https://www.openal.org/downloads/OpenAL11CoreSDK.zip), extract it and run the exe
  - Make sure ```C:/Program Files (x86)/OpenAL``` exists
  - If it gets downloaded in another location, make sure to change the path in <kbd>src/CMakeLists.txt</kbd>

##### Ogg
  - Download [Ogg](https://downloads.xiph.org/releases/ogg/libogg-1.3.5.zip) and extract it
  - Open CMD with admin privileges and move to the extracted directory
  - Run `cmake -G "MinGW Makefiles" .`
  - Run `make install` (you need admin privileges)
  - Make sure ```C:/Program Files (x86)/libogg``` exists
  - If it gets downloaded in another location, make sure to change the path in <kbd>src/CMakeLists.txt</kbd>

##### Vorbis
  - Download [Vorbis](https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.zip) and extract it
  - Open <kbd>CMakeLists.txt</kbd> from the extracted directory
  - Add <kbd>set(OGG_INCLUDE_DIR "C:/Program Files (x86)/libogg/include")</kbd> and <kbd>set(OGG_LIBRARY "C:/Program Files (x86)/libogg/lib/libogg.a")</kbd> under <kbd>project(vorbis)</kbd>
  - If you downloaded OGG in another location, modify the path accordingly
  - Open CMD with admin privileges and move to the extracted directory
  - Run `cmake -G "MinGW Makefiles" .`
  - Run `make install` (you need admin privileges)
  - Make sure ```C:/Program Files (x86)/vorbis``` exists
  - If it gets downloaded in another location, make sure to change the path in <kbd>src/CMakeLists.txt</kbd>

##### FLAC
  - Download [FLAC](https://codeload.github.com/xiph/flac/zip/refs/heads/master) and extract it
  - Open <kbd>CMakeLists.txt</kbd> from the extracted directory
  - Add <kbd>set(OGG_INCLUDE_DIR "C:/Program Files (x86)/libogg/include")</kbd> and <kbd>set(OGG_LIBRARY "C:/Program Files (x86)/libogg/lib/libogg.a")</kbd> under <kbd>project(FLAC VERSION 1.4.3)</kbd>
  - If you downloaded OGG in another location, modify the path accordingly
  - Edit <kbd>option(INSTALL_MANPAGES "Install MAN pages" ON)</kbd> to <kbd>option(INSTALL_MANPAGES "Install MAN pages" OFF)</kbd>
  - Open CMD with admin privileges and move to the extracted directory
  - Run `cmake -G "MinGW Makefiles" .`
  - Run `make install` (you need admin privileges)
  - Make sure ```C:/Program Files (x86)/FLAC``` exists
  - If it gets downloaded in another location, make sure to change the path in <kbd>src/CMakeLists.txt</kbd>


## Building the game
#### Windows
  - Make sure to edit the MSVC path and version to <kbd>scripts/build.bat</kbd>
  - Run <kbd>scripts/build.bat</kbd>
  
#### Linux
  - WIP


## Running the game
#### Windows
  - Run <kbd>scripts/run.bat</kbd>

#### Linux
  - WIP


## Shipping the game
  - In <kbd>src/CMakeLists.txt</kbd>, set the PRODUCTION_BUILD flag to ON to build a shippable version of your game. This will change the file paths to be relative to your exe (RESOURCES_PATH macro), will remove the console, and also will change the aserts to not allow people to debug them
  - No need for extra <kbd>.dll</kbd> files, everything is packed in the exe
  - Make sure to copy the resources folder wherever you place your exe


## Backup links
  - [MSVC](https://visualstudio.microsoft.com/vs/features/cplusplus/)
  - [MinGW](https://www.mingw-w64.org/downloads/)
  - [CMake](https://cmake.org/download/)
  - [Make](http://gnuwin32.sourceforge.net/packages/make.htm)
  - [OpenAL]()
  - [Ogg (libogg) and Vorbis (libvorbis)](https://xiph.org/downloads/)
  - [FLAC](https://xiph.org/flac/download.html)
  - [FLAC Github](https://github.com/xiph/flac)


## Credits
  - [GLFW + OpenGL](https://github.com/meemknight/cmakeSetup)
  - [Raylib](https://github.com/meemknight/raylibCmakeSetup)
  - [SFML](https://github.com/meemknight/SFMLCmakeSetup)

### Note
  - This is meant to be used with the build and run scripts, Visual Studio's CMakeLists build is not yet supported. If you want to use it, you might be better off using the original config linked above