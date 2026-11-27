# Device: Samsung Galaxy Note 10 (SM-N970F/DS)

Source: user-provided screenshot and statement, 2026-11-27. Unverified items are marked.

## Specs

- Model: Samsung Galaxy Note 10, SM-N970F/DS (global dual-SIM variant)
- SoC: Samsung Exynos 9825 (S5E9825) — the SM-N970F global variant uses Exynos 9825 (GSMArena / Wikipedia / AndroidAuthority, read 2026-11-27)
- ABI: `arm64-v8a` — inferred from the ARMv8-A Exynos 9825; confirm via `adb shell getprop ro.product.cpu.abi` if ADB becomes available
- Android version: 12
- SDK level: 31 (build id `SP1A.210812.016`)
- One UI: 4.1
- Display: 1080 x 2280, ~401 ppi (GSMArena); Android density setting not provided
- Build number: `SP1A.210812.016.N970FXXS9HWG9`
- Baseband: `N970FXXS9HWG9`
- Kernel: `4.14.113-24230781` (built 2023-07-31)
- Security patch level: 2023-08-01; Google Play system update 2026-10-01
- Root status: **not rooted** (user stated)
- Security: SELinux Enforcing, Knox 3.8 (API level 35), Knox ML 1.2, DualDAR 1.4.0
- Shizuku / Sui: not stated — assume absent until confirmed

## Workflow constraints

- Installer method: standard APK only. No root mount, no Shizuku/Sui until confirmed.
- Desired delivery: a signed standalone `.apk` to send via WhatsApp to the phone.
- ADB is not installed on the host, so the device has not been queried; all device facts above come from the user.

## Notes

- WhatsApp attachment handling for `.apk` is uncertain (reports conflict). If it blocks the file, zip it and rename back on the phone — treat this as a fallback, not a verified fact.
- Because the device is unrooted, a patched app signed with a new key cannot replace the stock app without uninstalling it first. That is a separate approval gate; do not assume it is authorised.
