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
- `Singularity-kona-<commit>.zip` — AnyKernel3 刷机包（CI 自动打包）

## 实际改动

- 启用 USB gadget 网络函数（CDC-ECM / RNDIS / EEM），USB 共享网络免驱直连
- 修复 display sde / coresight 的 uninitialized 警告（借自 dreamworld）

## 刷入

下载 [Releases](https://github.com/SQL0106/kernel-kona-kernelsu/releases) 中的 `Singularity-kona-*.zip`（AnyKernel3 刷机包），在 recovery（TWRP / OrangeFox 等）中刷入，或解包后提取 `Image` 用 `fastboot flash boot` 写入。

## CI 产物

每次 push 到 `Evolved` 分支会自动触发构建：`Singularity-kona-<commit>.zip`（可刷机）+ `kernel-image-dtbo`（原始产物）上传至 Actions artifact；每日自动同步上游 Singularity；失败时保留完整 `build.log`。

## 源码提供

- [The-Anomalist/Singularity](https://github.com/The-Anomalist/Singularity)
- [JackA1ltman/dreamworld_oneplus_sm8250](https://github.com/JackA1ltman/dreamworld_oneplus_sm8250)（借用的修复）
- [KernelSU-Next/KernelSU-Next](https://github.com/KernelSU-Next/KernelSU-Next)
- LineageOS oneplus sm8250 内核树（配置参考）
-
[Google clang-r416183b](https://android.googlesource.com/platform//prebuilts/clang/host/linux-x86/+/b669748458572622ed716407611633c5415da25c/clang-r416183b)
- Google Clang

## Build

- DeepSeek V4 Flash&Pro · OpenCode · $0.70

## 许可证

- 内核树：GPL-2.0（见 `LICENSE` / `COPYING`）
- KernelSU-Next：GPL-3.0
