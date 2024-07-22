cmake_minimum_required(VERSION 3.16)
set(CMAKE_CXX_STANDARD 17)
option(PRODUCTION_BUILD "Make this a production build" OFF)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Release>:Release>")
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE) # link time optimization

if(MSVC) 
	add_compile_options(/arch:AVX2)
endif()

project(Game)

set(SDL_STATIC ON)

add_subdirectory(thirdparty/SDL-release-2.30.5)		# window opener
add_subdirectory(thirdparty/glad)			        # opengl loader
add_subdirectory(thirdparty/stb_image)			    # loading images
add_subdirectory(thirdparty/stb_truetype)		    # loading ttf files
#add_subdirectory(thirdparty/enet-1.3.17)		    # networking
add_subdirectory(thirdparty/glm)			        # math
add_subdirectory(thirdparty/imgui-docking)		    # ui
add_subdirectory(thirdparty/gl2d)			        # rendering

file(GLOB_RECURSE MY_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/sources/*.cpp")

add_executable("${CMAKE_PROJECT_NAME}")

set_property(TARGET "${CMAKE_PROJECT_NAME}" PROPERTY CXX_STANDARD 17)

target_compile_definitions("${CMAKE_PROJECT_NAME}" PUBLIC GLFW_INCLUDE_NONE=1) 

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
target_link_libraries("${CMAKE_PROJECT_NAME}" PRIVATE 
	glm 
	glad 
	stb_image 
	stb_truetype 
	gl2d 
	imgui 
	SDL2-static
)
