curl -O https://storage.googleapis.com/nvidia-drivers-us-public/GRID/NVIDIA-Linux-x86_64-384.111-grid.run
sudo apt-get update
sudo apt-get install -y gcc make xorg x11-xserver-utils fluxbox xinit xterm
sudo bash NVIDIA-Linux-x86_64-384.111-grid.run
sudo nvidia-smi --persistence-mode=1
nvidia-smi