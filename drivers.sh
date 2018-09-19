#!/bin/sh

# Get your current host nvidia driver version, e.g. 340.24
nvidia_version="384.111"

# We must use the same driver in the image as on the host
nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
wget -O nvidia-driver.run $nvidia_driver_uri