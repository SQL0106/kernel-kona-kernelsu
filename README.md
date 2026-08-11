# kernel-kona-kernelsu

[Singularity](https://github.com/The-Anomalist/Singularity) 内核的 OnePlus 8 构建仓库，集成 [KernelSU-Next](https://github.com/KernelSU-Next/KernelSU-Next) 与 SUSFS。

## 支持的设备

- OnePlus 8 (instantnoodle) — IN2010 / IN2011 / IN2013
- SoC：Qualcomm Snapdragon 865 (kona / SM8250)

## 构建

通过 GitHub Actions 自动构建，也可本地构建：

```bash
# 安装 clang (Google clang-r416183b)，然后：
export LLVM=1 ARCH=arm64
make vendor/kona-perf_defconfig
cat arch/arm64/configs/vendor/oplus.config >> .config
make olddefconfig
make -j$(nproc)
```

配置由两部分组成：

- `arch/arm64/configs/vendor/kona-perf_defconfig` — Singularity 基础配置
- `arch/arm64/configs/vendor/oplus.config` — 上游官方 OPLUS 片段（指纹 / 触摸 / 充电 / 屏幕通知等）

构建产物：

- `Image` — 内核镜像
- `dtbo.img` — 设备树 overlay（instantnoodle）

## CI 产物

每次 push 到 `Evolved` 分支会自动触发构建，产物上传至 Actions artifact，失败时保留完整 `build.log`。

## 致谢

- [The-Anomalist/Singularity](https://github.com/The-Anomalist/Singularity)
- [KernelSU-Next/KernelSU-Next](https://github.com/KernelSU-Next/KernelSU-Next)
- LineageOS oneplus sm8250 内核树（配置参考）

## Build

- DeepSeek V4 Flash · DeepSeek · $0.63
