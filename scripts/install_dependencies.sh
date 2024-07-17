is_installed() {
    package="$1"
    dpkg -s "$package" &> /dev/null
    return $?
}

packages=(
    "cmake"
    "ninja-build"
    "libxcursor-dev"
    "libxi-dev"
    "libxrandr-dev"
    "libfreetype6-dev"
    "libgl1-mesa-dev"
    "libudev-dev"
    "libopenal-dev"
    "libsfml-dev"
    "libvorbis-dev"
    "libflac-dev"
)

for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
        echo "$pkg is not installed. Installing..."
        sudo apt-get install -y "$pkg"
    fi
done

# For some reason, it gets detected as installed even when it's not
sudo apt-get install -y "libxinerama-dev"