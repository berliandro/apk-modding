# App: YouTube

Source: user statement and official Morphe sources, 2026-11-27.

- Name: YouTube
- Package: `com.google.android.youtube`
- Target device: private profile in gitignored `private/`; patched for `arm64-v8a` on an unrooted device
- Installed version name / version code: **not provided**
- Base APK format: plain `.apk` (Morphe patch metadata marks YouTube as `APK_REQUIRED`; source: `patches-list.json`, 2026-11-27)
- Original APK in `workspace/input/`: no
- Desired mod: **not yet specified** — confirm before selecting patches
- Delivery preference: signed standalone `.apk` for WhatsApp transfer

## Verified from bundle 2.4.0 (2026-11-27)

- Most common compatible versions (128 patches each): 21.30.216, 21.28.208, 21.23.492, 20.51.39, 20.26.46
- Best first choice: **21.30.216**
- YouTube patches available: 134 (128 enabled by default, 6 disabled: indices 0–4 universal plus 246 `Network proxy`)
- Full list: `workspace/temp/youtube-patches.txt` (gitignored; regenerate with `list-patches --with-packages --with-versions --filter-package-name com.google.android.youtube --out <path>`)

## Verified base APK (2026-11-27)

- File: `workspace/input/youtube-21.30.216-nodpi.apk` (gitignored, immutable)
- Source: APKMirror, universal (nodpi) plain `.apk`, Android 10+ — https://www.apkmirror.com/apk/google-inc/youtube/youtube-21-30-216-release/youtube-21-30-216-2-android-apk-download/
- Version code: 1561187872; size 198,948,665 bytes; published signature ID 24bb (other valid: 3891, 4ba7)
- Local SHA-256: `3775a15129dcc4e5b80fc17b7e0841b7fdd1ca89a6e72baa798806f666c74d02`
- Signing certificate SHA-256 (v2/v3 signing block): `3d7a1223019aa39d9ea0e3436ab7c0896bfb4fb679f4de5fe7c23f326c8f994a` — matches an accepted signature in bundle 2.4.0. Verified locally with `apk_certs.py`.
- Bundle version + SHA-256: 2.4.0, `880d559a...17cd2`
- ABI kept (`--striplibs`): `arm64-v8a`
- Enabled/disabled patches and options: 128 bundle defaults; 6 left disabled (0,1,2,3,4,246)
- Output file + verification evidence: `workspace/output/youtube-21.30.216-morphe-2.4.0.apk`, 114,171,692 bytes, SHA-256 `2552604f...1cfe86`; package `app.morphe.android.youtube`, versionCode 1561187872, signing cert `d8d293fb...7533`; 128 applied / 0 failed
- Date verified: 2026-11-27
