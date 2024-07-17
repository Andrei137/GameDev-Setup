cmake_minimum_required(VERSION 3.16)
set(CMAKE_CXX_STANDARD 17)
option(PRODUCTION_BUILD "Make this a production build" OFF)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Release>:Release>")
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE) # link time optimization

# Ensure SFML is built as static libraries
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build SFML as static libraries" FORCE)

# For imgui-sfml
set(IMGUI_DIR "${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/imgui-docking/imgui")

if(MSVC)
	add_compile_options(/arch:AVX2) # make sure SIMD optimizations take place
elseif(UNIX)
	set(OPENAL_INCLUDE_DIR "/usr/include/AL/")
	set(OPENAL_LIBRARY "/usr/lib/x86_64-linux-gnu/libopenal.so")

    set(VORBIS_INCLUDE_DIR "/usr/include")
    set(VORBIS_LIBRARIES "/usr/lib/x86_64-linux-gnu/libvorbis.so")

    set(FLAC_INCLUDE_DIR "/usr/include")
    set(FLAC_LIBRARIES "/usr/lib/x86_64-linux-gnu/libFLAC.so")
else()
	# Set OpenAL paths
	set(OPENAL_INCLUDE_DIR "C:/Program Files (x86)/OpenAL/include")
	set(OPENAL_LIBRARY "C:/Program Files (x86)/OpenAL/libs/Win64/OpenAL32.lib")

	# Set Vorbis paths
	set(VORBIS_INCLUDE_DIR "C:/Program Files (x86)/vorbis/include")
	set(VORBIS_LIBRARY "C:/Program Files (x86)/vorbis/lib/libvorbis.a")
	set(VORBISENC_LIBRARY "C:/Program Files (x86)/vorbis/lib/libvorbisenc.a")
	set(VORBISFILE_LIBRARY "C:/Program Files (x86)/vorbis/lib/libvorbisfile.a")

	# Set Ogg paths
	set(OGG_INCLUDE_DIR "C:/Program Files (x86)/libogg/include")
	set(OGG_LIBRARY "C:/Program Files (x86)/libogg/lib/libogg.a")

	# Set FLAC paths
	set(FLAC_INCLUDE_DIR "C:/Program Files (x86)/FLAC/include")
	set(FLAC_LIBRARY "C:/Program Files (x86)/FLAC/lib/libFLAC.a")
	set(FLACPP_LIBRARY "C:/Program Files (x86)/FLAC/lib/libFLAC++.a")
endif()

project(Game)

# Add SFML
add_subdirectory(thirdparty/SFML-2.6.1)
add_subdirectory(thirdparty/imgui-docking)
add_subdirectory(thirdparty/imgui-sfml-2.6.x)

# MY_SOURCES is defined to be a list of all the source files for my game 
file(GLOB_RECURSE MY_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/sources/*.cpp")

add_executable("${CMAKE_PROJECT_NAME}")

set_property(TARGET "${CMAKE_PROJECT_NAME}" PROPERTY CXX_STANDARD 17)

if(PRODUCTION_BUILD)
	target_compile_definitions("${CMAKE_PROJECT_NAME}" PUBLIC RESOURCES_PATH="./resources/") 
	target_compile_definitions("${CMAKE_PROJECT_NAME}" PUBLIC PRODUCTION_BUILD=1) 
else()
	target_compile_definitions("${CMAKE_PROJECT_NAME}" PUBLIC RESOURCES_PATH="${CMAKE_CURRENT_SOURCE_DIR}/../resources/")
	target_compile_definitions("${CMAKE_PROJECT_NAME}" PUBLIC PRODUCTION_BUILD=0) 
endif()

target_sources("${CMAKE_PROJECT_NAME}" PRIVATE ${MY_SOURCES} main.cpp)

if(MSVC)
	target_compile_definitions("${CMAKE_PROJECT_NAME}" PUBLIC _CRT_SECURE_NO_WARNINGS)

	if (PRODUCTION_BUILD)
		set_target_properties("${CMAKE_PROJECT_NAME}" PROPERTIES LINK_FLAGS "/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup")
	endif()
endif()

target_include_directories("${CMAKE_PROJECT_NAME}" PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/includes/")
target_include_directories("${CMAKE_PROJECT_NAME}" PUBLIC "${OPENAL_INCLUDE_DIR}")
target_include_directories("${CMAKE_PROJECT_NAME}" PUBLIC "${VORBIS_INCLUDE_DIR}")
target_include_directories("${CMAKE_PROJECT_NAME}" PUBLIC "${OGG_INCLUDE_DIR}")
target_include_directories("${CMAKE_PROJECT_NAME}" PUBLIC "${FLAC_INCLUDE_DIR}")

# Link SFML libraries statically
target_link_libraries("${CMAKE_PROJECT_NAME}" 
	sfml-graphics 
	sfml-window 
	sfml-system 
	sfml-audio 
	sfml-network
	imgui
	ImGui-SFML
	${OPENAL_LIBRARY}
    ${VORBIS_LIBRARY}
    ${VORBISENC_LIBRARY}
    ${VORBISFILE_LIBRARY}
    ${OGG_LIBRARY}
    ${FLAC_LIBRARY}
    ${FLACPP_LIBRARY}
)

install(TARGETS ${CMAKE_PROJECT_NAME} DESTINATION bin)
