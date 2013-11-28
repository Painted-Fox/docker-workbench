# My Docker Workbench.
# The workbench is for linking to a running docker container that exposes ssh.
# Workbench containers are meant to be disposable and not long lived.

FROM ubuntu
MAINTAINER Ryan Seto <ryanseto@yak.net>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get upgrade

# Ensure UTF-8
RUN apt-get update
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install all the tools that I need.
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y python-software-properties && \
    add-apt-repository -y ppa:keithw/mosh && \
    apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    curl wget aria2 rsync \
    git bzr mercurial \
    zip p7zip-full bzip2 \
    ssh mosh \
    tcl python python-setuptools \
    tmux vim-nox diffutils patch

RUN adduser --gecos "Primary User" --disabled-password fox && \
    usermod -a -G adm,sudo fox

ENV HOME /home/fox

RUN sudo -u fox -- git clone https://github.com/Painted-Fox/dotfiles $HOME/dotfiles
RUN sudo -u fox -- tclsh $HOME/dotfiles/update.tcl
RUN cd $HOME/dotfiles && sudo -u fox -- $HOME/dotfiles/setup-linux.sh

ENTRYPOINT ["sudo", "-i", "-u", "fox", "--", "bash", "-il"]
