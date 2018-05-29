#!/bin/bash
# Install nvidia driver on Ubuntu

# TODO nvidia-driver -A
# Add terminal install

nvidia::driver::install(){

  version="390.59"
  os_arch="x86_64"
  
  # Download nvidia
  run_file="NVIDIA-Linux-${os_arch}-${version}.run"
  wget http://us.download.nvidia.com/XFree86/Linux-x86_64/${version}/${run_file}
  
  # Allow x86_32 architecture
  sudo dpkg --add-architecture i386
  sudo apt-get update 
  sudo apt-get install libc6:i386

  # Install dependent packages
  sudo apt-get install gcc make
  
  sudo sh ${run_file}

}

