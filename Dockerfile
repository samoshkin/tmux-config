FROM debian:stretch-slim

RUN apt-get update  \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    fontconfig \
    git \
    gcc \
    iputils-ping \
    libevent-dev \
    libncurses-dev \
    locales \
    make \
    procps \
    wget \
  && wget -O - https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz | tar xzf - \
  && cd tmux-2.6 \
  && LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local \
  && make \
  && make install \
  && cd .. \
  && rm -rf tmux-2.6 \
  && apt-get purge -y gcc make \
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

RUN git clone https://github.com/samoshkin/tmux-config \
  && ./tmux-config/install.sh \
  && rm -rf ./tmux-config

ENV TERM=xterm-256color


