# vkpeak-docker

Dockerized version of [vkpeak](https://github.com/nihui/vkpeak) - a Vulkan compute shader peak performance measuring tool.

## Features

- Pre-built Docker image with all dependencies
- Vulkan GPU passthrough support
- Easy deployment with Docker Compose

## Prerequisites

- Docker and Docker Compose installed
- Vulkan-compatible GPU
- Vulkan drivers installed on the host system
- GPU device access (`/dev/dri`)

## Usage

### Using Docker Compose (Recommended)

Build and run vkpeak with GPU passthrough:

```bash
docker compose up --build
```

Or if using older docker-compose command:

```bash
docker-compose up --build
```

Run without rebuilding:

```bash
docker compose up
```

To run in detached mode and view logs:

```bash
docker compose up -d
docker compose logs -f
```

### Using Docker directly

Build the image:

```bash
docker build -t vkpeak:latest .
```

Run with GPU passthrough:

```bash
docker run --rm \
  --device=/dev/dri:/dev/dri \
  -v /etc/vulkan:/etc/vulkan:ro \
  -v /usr/share/vulkan:/usr/share/vulkan:ro \
  vkpeak:latest
```

## GPU Support

### NVIDIA GPUs

For NVIDIA GPUs, ensure you have:
- NVIDIA drivers installed on the host
- `nvidia-docker2` runtime (optional but recommended)

You can modify `docker-compose.yml` to use NVIDIA runtime:

```yaml
services:
  vkpeak:
    runtime: nvidia
    # ... rest of configuration
```

### AMD/Intel GPUs

The default configuration should work with AMD and Intel GPUs using the `/dev/dri` device passthrough.

## Troubleshooting

### No Vulkan devices found

If you get an error about no Vulkan devices:

1. Verify Vulkan works on your host:
   ```bash
   vulkaninfo
   ```

2. Check that your GPU is accessible:
   ```bash
   ls -la /dev/dri
   ```

3. Ensure proper permissions for `/dev/dri` devices

### Permission denied on /dev/dri

Add your user to the `video` and/or `render` groups:

```bash
sudo usermod -a -G video,render $USER
```

Then log out and back in.

## Building from Source

The Dockerfile performs the following steps:
1. Clones the vkpeak repository
2. Initializes git submodules
3. Builds with CMake
4. Sets up the entrypoint

## License

This dockerization is provided under the MIT License. See [LICENSE](LICENSE) for details.

The vkpeak tool itself is licensed under its own terms. See the [original repository](https://github.com/nihui/vkpeak) for details.