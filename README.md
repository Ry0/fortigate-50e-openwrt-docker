# FortiGate 50E overlay領域の拡張
overlay領域の拡張を行うためのDocker環境

## Dockerインストール
起動しているPCがWindowsなら  
https://docs.docker.jp/docker-for-windows/install.html

起動しているPCがUbuntuなら  
https://docs.docker.com/engine/install/ubuntu/

## OpenWrtのインストール
以下を参考に導入する。

> ネットワーク初心者がFortinet Fortigate 50eにOpenWrtを導入してみた
>  
> [![img](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-user-contents.imgix.net%2Fhttps%253A%252F%252Fcdn.qiita.com%252Fassets%252Fpublic%252Farticle-ogp-background-afbab5eb44e0b055cce1258705637a91.png%3Fixlib%3Drb-4.0.0%26w%3D1200%26blend64%3DaHR0cHM6Ly9xaWl0YS11c2VyLXByb2ZpbGUtaW1hZ2VzLmltZ2l4Lm5ldC9odHRwcyUzQSUyRiUyRnFpaXRhLWltYWdlLXN0b3JlLnMzLmFwLW5vcnRoZWFzdC0xLmFtYXpvbmF3cy5jb20lMkYwJTJGNDAzNjc0NSUyRnByb2ZpbGUtaW1hZ2VzJTJGMTc0MjE2Mjc2OD9peGxpYj1yYi00LjAuMCZhcj0xJTNBMSZmaXQ9Y3JvcCZtYXNrPWVsbGlwc2UmYmc9RkZGRkZGJmZtPXBuZzMyJnM9OGJjMGYxZGRmNjA0OWJmMjM5YTc5MjUzYzVmZmU1OTI%26blend-x%3D120%26blend-y%3D467%26blend-w%3D82%26blend-h%3D82%26blend-mode%3Dnormal%26s%3D281f206985ae270b14e0ed5f1c87b8a4?ixlib=rb-4.0.0&w=1200&fm=jpg&mark64=aHR0cHM6Ly9xaWl0YS11c2VyLWNvbnRlbnRzLmltZ2l4Lm5ldC9-dGV4dD9peGxpYj1yYi00LjAuMCZ3PTk2MCZoPTMyNCZ0eHQ9JUUzJTgzJThEJUUzJTgzJTgzJUUzJTgzJTg4JUUzJTgzJUFGJUUzJTgzJUJDJUUzJTgyJUFGJUU1JTg4JTlEJUU1JUJGJTgzJUU4JTgwJTg1JUUzJTgxJThDRm9ydGluZXQlMjBGb3J0aWdhdGUlMjA1MGUlRTMlODElQUJPcGVuV3J0JUUzJTgyJTkyJUU1JUIwJThFJUU1JTg1JUE1JUUzJTgxJTk3JUUzJTgxJUE2JUUzJTgxJUJGJUUzJTgxJTlGJnR4dC1hbGlnbj1sZWZ0JTJDdG9wJnR4dC1jb2xvcj0lMjMxRTIxMjEmdHh0LWZvbnQ9SGlyYWdpbm8lMjBTYW5zJTIwVzYmdHh0LXNpemU9NTYmdHh0LXBhZD0wJnM9MTE3YWM3MDIwNWU0OWUzOTQ0ODVmOGE1Yjk3YWNjNTI&mark-x=120&mark-y=112&blend64=aHR0cHM6Ly9xaWl0YS11c2VyLWNvbnRlbnRzLmltZ2l4Lm5ldC9-dGV4dD9peGxpYj1yYi00LjAuMCZ3PTgzOCZoPTU4JnR4dD0lNDBtb3lhNG1vbmphJnR4dC1jb2xvcj0lMjMxRTIxMjEmdHh0LWZvbnQ9SGlyYWdpbm8lMjBTYW5zJTIwVzYmdHh0LXNpemU9MzYmdHh0LXBhZD0wJnM9NTdhMGI0ZDhhODRjZjNmMDc0Y2MyODlkMTFiNjU2MTc&blend-x=242&blend-y=480&blend-w=838&blend-h=46&blend-fit=crop&blend-crop=left%2Cbottom&blend-mode=normal&s=8d093318c15dfbcfc0ff7be65f8bfd28)](https://qiita.com/moya4monja/items/a8527473e14b470aceea)

## 自前ビルド
### Docker実行
ビルド環境を用意するのが面倒なので、Dockerで用意した。
以下を実行する。devcontainerを使っている人はそのままGUI操作で開いてよい。

```bash
docker image build -t fortigate-50e-openwrt-docker .
docker run --name fortigate-50e-openwrt-docker-container -it fortigate-50e-openwrt-docker /bin/bash
```

基本的には、以下に参考にDockerコンテナで実行できるようにした。

> OpenWrt Fortinet FortiGate 50E /overlay 領域の拡張 
>  
> [![img](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-user-contents.imgix.net%2Fhttps%253A%252F%252Fcdn.qiita.com%252Fassets%252Fpublic%252Farticle-ogp-background-afbab5eb44e0b055cce1258705637a91.png%3Fixlib%3Drb-4.0.0%26w%3D1200%26blend64%3DaHR0cHM6Ly9xaWl0YS11c2VyLXByb2ZpbGUtaW1hZ2VzLmltZ2l4Lm5ldC9odHRwcyUzQSUyRiUyRnMzLWFwLW5vcnRoZWFzdC0xLmFtYXpvbmF3cy5jb20lMkZxaWl0YS1pbWFnZS1zdG9yZSUyRjAlMkYxMjM2MjU4JTJGOGFjYTU0NjhkN2U5NTU3OTk3YTc0MjIzODNiZDc2YTA4MmE2ZmRmYyUyRmxhcmdlLnBuZyUzRjE3NDYzNjUzMjQ_aXhsaWI9cmItNC4wLjAmYXI9MSUzQTEmZml0PWNyb3AmbWFzaz1lbGxpcHNlJmJnPUZGRkZGRiZmbT1wbmczMiZzPThiN2VkZDNkYzE2YjA0YzI4YmRjNTE5OTExM2U1MmRj%26blend-x%3D120%26blend-y%3D467%26blend-w%3D82%26blend-h%3D82%26blend-mode%3Dnormal%26s%3D242869a08ae2981fa18f477f258c908e?ixlib=rb-4.0.0&w=1200&fm=jpg&mark64=aHR0cHM6Ly9xaWl0YS11c2VyLWNvbnRlbnRzLmltZ2l4Lm5ldC9-dGV4dD9peGxpYj1yYi00LjAuMCZ3PTk2MCZoPTMyNCZ0eHQ9T3BlbldydCUyMEZvcnRpbmV0JTIwRm9ydGlHYXRlJTIwNTBFJTIwJTJGb3ZlcmxheSUyMCVFOSVBMCU5OCVFNSU5RiU5RiVFMyU4MSVBRSVFNiU4QiVBMSVFNSVCQyVCNSZ0eHQtYWxpZ249bGVmdCUyQ3RvcCZ0eHQtY29sb3I9JTIzMUUyMTIxJnR4dC1mb250PUhpcmFnaW5vJTIwU2FucyUyMFc2JnR4dC1zaXplPTU2JnR4dC1wYWQ9MCZzPTJkMjk0MDFjM2VlN2QxODQwYWE1M2VjZmFhZjYwNmI4&mark-x=120&mark-y=112&blend64=aHR0cHM6Ly9xaWl0YS11c2VyLWNvbnRlbnRzLmltZ2l4Lm5ldC9-dGV4dD9peGxpYj1yYi00LjAuMCZ3PTgzOCZoPTU4JnR4dD0lNDB5b3NzaDEmdHh0LWNvbG9yPSUyMzFFMjEyMSZ0eHQtZm9udD1IaXJhZ2lubyUyMFNhbnMlMjBXNiZ0eHQtc2l6ZT0zNiZ0eHQtcGFkPTAmcz0zYzVlMmI4MmU1ODU2NGU4MzdhYjhkMjZkNmQyYzc0MQ&blend-x=242&blend-y=480&blend-w=838&blend-h=46&blend-fit=crop&blend-crop=left%2Cbottom&blend-mode=normal&s=1bfd1353879f8138bcb6285c3d08bf94)](https://qiita.com/yossh1/items/ebd30d6af9c95545ad04)

### ビルド実行
Target Profile (Multiple devices) でFortinet FortiGate 50Eを選択。saveしてexit。

```bash
make menuconfig
```

今回は、`25.12.0`を対象としたので、以下のURLでvermagicを確認。

https://downloads.openwrt.org/releases/25.12.0/targets/mvebu/cortexa9/kmods/

File Nameに`6.12.71-1-a1b7fd67aef9ff09b98d2d5a9698c83d/`とあるので、`a1b7fd67aef9ff09b98d2d5a9698c83d`がvermagicの値。

バージョン情報とvermagicの値は、Dockerfileの先頭で宣言する。

```bash
make -j$(nproc)
```

と出力されたら終わり。
 
```bash
 make[3] -C package/kernel/ath10k-ct clean-build
 make[3] -C package/kernel/ath10k-ct compile
 make[2] package/install
 make[2] target/install
 make[3] -C target/toolchain install
 make[3] -C target/linux install
 make[3] -C target/llvm-bpf install
 make[3] -C target/sdk install
 make[3] -C target/imagebuilder install
 make[2] package/index
 make[2] json_overview_image_info
 make[2] checksum
```

`bin/targets/mvebu/cortexa9/`に必要なファイルが出力されていることを確認。
* `openwrt-25.12.0-mvebu-cortexa9-fortinet_fg-50e-initramfs-kernel.bin`
* `openwrt-25.12.0-mvebu-cortexa9-fortinet_fg-50e-squashfs-sysupgrade.bin`

## その他
### Mac、Linuxでのシリアル通信コマンド

```bash
screen /dev/tty.usbserial-XXXX 9600
```

### ipアドレスの設定

```bash
uci set network.lan.ipaddr='192.168.1.1'
uci set network.lan.netmask='255.255.255.0'
uci commit network
/etc/init.d/network restart
```

