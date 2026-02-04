FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libvulkan-dev \
    vulkan-tools \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone vkpeak repository
RUN git clone https://github.com/nihui/vkpeak.git /app/vkpeak

# Initialize submodules
WORKDIR /app/vkpeak
RUN git submodule update --init --recursive

# Build vkpeak with CMake
RUN mkdir build && cd build && \
    cmake .. && \
    cmake --build . -j 4

# Set the entrypoint to the built binary
WORKDIR /app/vkpeak/build
ENTRYPOINT ["./vkpeak"]
