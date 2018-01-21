FROM ubuntu:artful

RUN apt-get update && apt-get -y install curl gcc make xz-utils
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y -v --no-modify-path
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup toolchain install stable
RUN rustup component add rust-src
RUN cargo install xargo
RUN mkdir /root/toolchain
RUN curl https://orum.in/distfiles/x86_64-efi-pe-binutils.tar.xz | tar xfJ - -C /root/toolchain
ENV PATH="${PATH}:/root/toolchain/usr/bin/"

COPY . /root/asiago
RUN apt-get -y install qemu-system-x86 mtools
RUN cd /root/asiago/aura; make img