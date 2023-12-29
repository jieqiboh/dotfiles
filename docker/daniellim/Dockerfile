# Use the official Ubuntu base image
FROM ubuntu:latest

CMD ["bash"]

ENV DEBIAN_FRONTEND=noninteractive

RUN /bin/sh -c apt update     && apt -y install locales # buildkit

RUN /bin/sh -c locale-gen en_US.UTF-8 # buildkit

ENV LANG=en_US.UTF-8

ENV LANGUAGE=en_US:en

ENV LC_ALL=en_US.UTF-8

RUN /bin/sh -c mkdir ~/tools # buildkit

# Update package list and install essential tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive

RUN apt-get -y install locales

RUN /bin/sh -c apt update && apt -y install vim patchelf netcat socat strace ltrace curl wget git gdb \
                          && apt -y install man sudo inetutils-ping libssl-dev \
                          && apt clean # buildkit

RUN /bin/sh -c apt update && apt -y install python3-dev python3-pip \
                          && apt clean \
                          && ln -s /usr/bin/python3 /usr/bin/python # buildkit

RUN /bin/sh -c python3 -m pip install --upgrade pip # buildkit

RUN /bin/sh -c apt update && apt -y install gcc-multilib g++-multilib \
                          && apt clean # buildkit

RUN /bin/sh -c dpkg --add-architecture i386 && apt update \
                                            && apt -y install libc6-dbg libc6-dbg:i386 glibc-source \
                                            && apt clean \
                                            && tar -C /usr/src/glibc/ -xvf /usr/src/glibc/glibc-*.tar.xz # buildkit

RUN /bin/sh -c apt -y install git cmake gcc g++ pkg-config libglib2.0-dev # buildkit

RUN /bin/sh -c cd ~/tools && wget https://raw.githubusercontent.com/hugsy/stuff/master/update-trinity.sh \
                          && bash ./update-trinity.sh # buildkit

RUN /bin/sh -c ldconfig # buildkit

RUN /bin/sh -c cd ~/tools && git clone --depth 1 https://github.com/Z3Prover/z3.git \
                          && cd z3 \
                          && python3 scripts/mk_make.py --python \
                          && cd build; make && make install # buildkit

RUN /bin/sh -c CRYPTOGRAPHY_DONT_BUILD_RUST=1 python3 -m pip install pwntools # buildkit

RUN /bin/sh -c apt update && apt install -y ruby-full \
                          && apt clean # buildkit

RUN /bin/sh -c gem install one_gadget # buildkit

RUN /bin/sh -c python3 -m pip install arm_now # buildkit

RUN /bin/sh -c apt update && apt install -y e2tools qemu \
                          && apt clean # buildkit

RUN /bin/sh -c apt update && apt -y install libevent-dev libncurses-dev \
                          && apt clean # buildkit

RUN /bin/sh -c TMUX_VERSION=$(curl -s https://api.github.com/repos/tmux/tmux/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")') \
    && wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz \
    && tar zxvf tmux-$TMUX_VERSION.tar.gz \
    && cd tmux-$TMUX_VERSION \
    && ./configure && make && make install \
    && cd ..     && rm -rf tmux-$TMUX_VERSION* \
    && echo "tmux hold" | dpkg --set-selections # disable tmux update from apt # buildkit

RUN /bin/sh -c curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.9.0/ripgrep_0.9.0_amd64.deb && dpkg -i ripgrep_0.9.0_amd64.deb     && rm ripgrep_0.9.0_amd64.deb # buildkit

RUN /bin/sh -c cd ~/tools && git clone --depth 1 https://github.com/hugsy/gef.git \
                          && echo "source ~/tools/gef/gef.py" > ~/.gdbinit # buildkit

RUN /bin/sh -c python3 -m pip install ropper # buildkit

RUN /bin/sh -c cd ~/tools && git clone --depth 1 https://github.com/devttys0/binwalk \
                          && cd binwalk \
                          && python3 setup.py install # buildkit

RUN /bin/sh -c cd ~/tools && git clone --depth 1 https://github.com/radare/radare2 \
                          && cd radare2 \
                          && ./sys/install.sh # buildkit

RUN /bin/sh -c apt update && apt install -y zsh \
                          && apt clean \
                          && chsh -s $(which zsh) # buildkit

RUN /bin/sh -c /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true \
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="clean"/g' /root/.zshrc # buildkit

RUN /bin/sh -c cd ~/tools && curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
                          | grep "browser_download_url.*deb" \
                          | cut -d : -f 2,3 \
                          | grep -v musl \
                          | grep amd64 \
                          | tr -d '"\"' \
                          | wget -qi - -O bat.deb \
                          && sudo dpkg -i bat.deb # buildkit

RUN /bin/sh -c cd ~/tools \
    && rm -rf fzf \
    && git clone --depth 1 https://github.com/junegunn/fzf.git fzf \
    && fzf/install # buildkit

RUN /bin/sh -c echo "\n# fzf aliases" >> /root/.zshrc \
    && echo "alias preview=\"fzf --preview 'bat --color \\\"always\\\" {}'\"" >> /root/.zshrc \
    && echo "export FZF_DEFAULT_OPTS=\"--bind='ctrl-o:execute(vim {})+abort'\"" >> /root/.zshrc # buildkit

RUN /bin/sh -c pip install virtualenvwrapper # buildkit

RUN /bin/sh -c echo "\n # virtualenvwrapper" >> /root/.zshrc \
    && echo "export WORKON_HOME=$HOME/.virtualenvs" >> /root/.zshrc \
    && echo "export PROJECT_HOME=$HOME/Devel" >> /root/.zshrc \
    && echo "source /usr/local/bin/virtualenvwrapper.sh" >> /root/.zshrc # buildkit

RUN /bin/sh -c cd ~/tools \
    && /bin/bash -c "source /root/.zshrc && source /usr/local/bin/virtualenvwrapper.sh && mkvirtualenv angr && pip install angr" # buildkit

RUN /bin/sh -c pip install tldr # buildkit

RUN /bin/sh -c apt upgrade -y vim \
    && git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && /bin/sh ~/.vim_runtime/install_awesome_vimrc.sh \
    && /bin/bash -c "echo inoremap jk \<ESC\> >> ~/.vimrc" # buildkit

RUN /bin/sh -c apt install -y neovim # buildkit

WORKDIR /root/ctfs