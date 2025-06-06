set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)
set(VCPKG_OSX_ARCHITECTURES x86_64)
set(VCPKG_BUILD_TYPE release)
set(VCPKG_FIXUP_MACHO_RPATH OFF)

set ( VCPKG_CHAINLOAD_TOOLCHAIN_FILE "$ENV{MANTICORE_SOURCE_DIR}/dist/build_dockers/cross/osx.cmake" )

if (CMAKE_TOOLCHAIN_FILE)
	set ( VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_TOOLCHAIN_FILE}" )
elseif (DEFINED ENV{CMAKE_TOOLCHAIN_FILE})
	if (NOT $ENV{CMAKE_TOOLCHAIN_FILE} STREQUAL /sysroot/root/toolchain.cmake)
		set ( VCPKG_CHAINLOAD_TOOLCHAIN_FILE "$ENV{CMAKE_TOOLCHAIN_FILE}" )
	endif ()
endif ()