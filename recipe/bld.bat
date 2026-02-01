setlocal EnableDelayedExpansion

set "CMAKE_SYSTEM_NAME="
set "CMAKE_SYSTEM_PROCESSOR="
set "CMAKE_C_COMPILER_TARGET="
set "CMAKE_CXX_COMPILER_TARGET="

@rem Cross-compilation flags
if /I "%target_platform%"=="win-arm64" if /I "%build_platform%"=="win-64" (
    set "CMAKE_SYSTEM_NAME=-D CMAKE_SYSTEM_NAME=Windows"
    set "CMAKE_SYSTEM_PROCESSOR=-D CMAKE_SYSTEM_PROCESSOR=ARM64"
    set "CMAKE_C_COMPILER_TARGET=-D CMAKE_C_COMPILER_TARGET=aarch64-pc-windows-msvc"
    set "CMAKE_CXX_COMPILER_TARGET=-D CMAKE_CXX_COMPILER_TARGET=aarch64-pc-windows-msvc"
)

cmake %CMAKE_ARGS% ^
    -G Ninja ^
    -B build ^
    -D BUILD_SHARED_LIBS=YES ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D CMAKE_C_COMPILER=clang-cl ^
    -D CMAKE_CXX_COMPILER=clang-cl ^
    -D CMAKE_MT=mt ^
    %CMAKE_SYSTEM_NAME% ^
    %CMAKE_SYSTEM_PROCESSOR% ^
    %CMAKE_C_COMPILER_TARGET% ^
    %CMAKE_CXX_COMPILER_TARGET% ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -D BUILD_TESTING=NO ^
    -S %SRC_DIR%

IF %ERRORLEVEL% NEQ 0 exit 1

cmake --build build -j %CPU_COUNT% --target install

IF %ERRORLEVEL% NEQ 0 exit 1
