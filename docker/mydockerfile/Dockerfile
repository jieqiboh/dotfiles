# Use the official Ubuntu base image
FROM ubuntu:latest

CMD ["bash"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y install locales # buildkit

RUN locale-gen en_US.UTF-8 # buildkit

ENV LANG=en_US.UTF-8

ENV LANGUAGE=en_US:en

ENV LC_ALL=en_US.UTF-8

RUN mkdir ~/tools # buildkit

# Update package list and install essential tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive # prevents prompts from asking for user input

RUN apt-get -y install locales

RUN apt update && apt -y install vim patchelf netcat socat strace ltrace curl wget git gdb \
                          && apt -y install man sudo inetutils-ping libssl-dev \
                          && apt clean # buildkit

RUN apt update && apt -y install python3-dev python3-pip \
                          && apt clean \
                          && ln -s /usr/bin/python3 /usr/bin/python # buildkit

RUN python3 -m pip install --upgrade pip # buildkit

RUN apt -y install git cmake gcc g++ pkg-config libglib2.0-dev # buildkit

RUN ldconfig # buildkit

RUN CRYPTOGRAPHY_DONT_BUILD_RUST=1 python3 -m pip install pwntools # buildkit

RUN apt update && apt install -y zsh \
                          && apt clean \
                          && chsh -s $(which zsh) # buildkit

RUN pip install tldr # buildkit

RUN apt upgrade -y vim

RUN apt install -y neovim # buildkit

WORKDIR /root/ctfs


