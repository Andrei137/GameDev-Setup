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
### Windows
  - [MSVC](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&channel=Release&version=VS2022&source=VSLandingPage&cid=2030&passive=false)
  - [Make](http://gnuwin32.sourceforge.net/packages/make.htm) (optional for SFML in case the build fails)

### Environment Variables for Windows
  - Search ```Edit the system environment variables``` and open it
  - Select ```Environment variables```
  - Under ```System variables```, double click ```Path```
  - Select new and add the following:
      - **MSVC:** `<path_to_msvc>/VC/Tools/MSVC/<version>/bin` and `<path_to_msvc>/VC/Tools/MSVC/<version>/include`
      - **CMake:** `<path_to_msvc>/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin`
      - **Make:** `<path_to_make>/bin`

### Linux
  - WIP
      
### In case the SFML build fails
  - WIP

## Building the game
### Windows
  - Make sure to edit the MSVC path and version to <kbd>scripts/build.bat</kbd>
  - Run <kbd>scripts/build.bat</kbd>
  
### Linux
  - WIP

## Running the game
### Windows
  - Run <kbd>scripts/run.bat</kbd>

### Linux
  - WIP

## Shipping the game
  - In <kbd>src/CMakeLists.txt</kbd>, set the PRODUCTION_BUILD flag to ON to build a shippable version of your game. This will change the file paths to be relative to your exe (RESOURCES_PATH macro), will remove the console, and also will change the aserts to not allow people to debug them
  - Make sure to copy the resources folder wherever you place your exe

## Credits
  - [GLFW + OpenGL](https://github.com/meemknight/cmakeSetup)
  - [Raylib](https://github.com/meemknight/raylibCmakeSetup)
  - [SFML](https://github.com/meemknight/SFMLCmakeSetup)

### Note
  - This is meant to be used with the build and run scripts, Visual Studio's CMakeLists build is not yet supported. If you want to use it, you might be better off using the original config linked above