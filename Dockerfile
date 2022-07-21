FROM ubuntu:22.04

RUN apt-get update  \
  && apt-get install -qy --no-install-recommends \
    ca-certificates \
    fontconfig \
    git \
    iputils-ping \
    libevent-dev \
    libncurses-dev \
    locales \
    procps \
    wget \
    curl \
    tmux \
    # added to test vim integration
    neovim \
    # needed for network addon
    gawk \ 
    net-tools \
    coreutils \
    # needed for weather adddon
    sed \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN mkdir -p $HOME/.fonts $HOME/.config/fontconfig/conf.d \
  && wget -P $HOME/.fonts https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf \
  && wget -P $HOME/.config/fontconfig/conf.d/ https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf \
  && fc-cache -vf $HOME/.fonts/

WORKDIR /root

RUN git clone https://github.com/frankperrakis/tmux-config.git \
  && ./tmux-config/install.sh \
  && rm -rf ./tmux-config

ENV TERM=xterm-256color
