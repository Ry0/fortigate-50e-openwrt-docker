# 冒頭でデフォルトのバージョンとvermagicを指定
ARG OPENWRT_VERSION=25.12.0
ARG VERMAGIC=a1b7fd67aef9ff09b98d2d5a9698c83d

# --- ビルドステージ ---
FROM ubuntu:24.04 AS builder

# 必要なパッケージのインストール
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
    bison build-essential clang coreutils curl fakeroot file flex g++ g++-multilib gawk gcc-multilib gdb gettext libgl1 libglx-mesa0 \
    git git-core htop libdrm-amdgpu1 libev-dev libpam-dev libgl1-mesa-dev libgraphene-1.0-0 libgraphene-1.0-dev libncurses5-dev libncurses-dev \
    libpcre3 libpcre3-dev libreadline-dev libssl-dev libwayland-bin libwayland-dev libz-dev lzma man-db patch \
    python3 python3-pip rsync sharutils subversion sudo swig tzdata \
    unzip vim wayland-protocols wget wget2 xorg-dev xterm zip zlib1g-dev \
    qemu-system qemu-system-common qemu-utils \
    openssh-server nkf

# ARGを再定義してシェル内で利用可能にする
ARG OPENWRT_VERSION
ARG VERMAGIC

RUN useradd -m builduser
USER builduser
WORKDIR /home/builduser

# ソースコードの取得
RUN git clone https://github.com/openwrt/openwrt.git
WORKDIR /home/builduser/openwrt
RUN git checkout v${OPENWRT_VERSION}

# フィードの更新
RUN ./scripts/feeds update -a && ./scripts/feeds install -a

# configファイルの取得
RUN wget https://downloads.openwrt.org/releases/${OPENWRT_VERSION}/targets/mvebu/cortexa9/config.buildinfo -O .config

# dtsファイルの取得
RUN wget https://pastebin.com/raw/fGRaMBuS -O ./target/linux/mvebu/files/arch/arm/boot/dts/marvell/armada-385-fortinet-fg-50e.dts

# カーネル設定の追加とvermagicの書き込み
RUN echo "${VERMAGIC}" > ./vermagic

# Makefile類の修正 (vermagicの固定)
RUN sed -i 's@grep .* > $(LINUX_DIR)/.vermagic@cp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic@' include/kernel-defaults.mk && \
    sed -i 's@STAMP_BUILT:=$(STAMP_BUILT)_$(shell $(SCRIPT_DIR)/kconfig.pl $(LINUX_DIR)/.config | $(MKHASH) md5)@STAMP_BUILT:=$(STAMP_BUILT)_$(shell cat $(LINUX_DIR)/.vermagic)@' package/kernel/linux/Makefile