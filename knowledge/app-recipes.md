# App recipes

No recipe has been executed or verified in this repo — no APK was modified during initialization. The facts below are verified from official sources on 2026-11-27; everything else must be validated against the exact `.mpp` bundle you plan to use.

## Verified targets (source: Morphe patches `patches-list.json` + README, 2026-11-27)

| App | Package | Required input format | Notes |
| --- | --- | --- | --- |
| YouTube | `com.google.android.youtube` | plain `.apk` (`APK_REQUIRED`) | 129 patches in bundle 2.4.0 |
| YouTube Music | `com.google.android.apps.youtube.music` | plain `.apk` (`APK_REQUIRED`) | 63 patches |
| Reddit | `com.reddit.frontpage` | split bundle (`.apkm`) | 69 patches; several patches require 2026.24.0+ |
| Universal | n/a | any compatible app | 5 patches |

Morphe Desktop also accepts `.apkm`, `.xapk`, and `.apks` positional inputs and merges splits into a single APK before patching (official docs, 2026-11-27). For Reddit, keep the original split bundle intact in `workspace/input/`.

## Version selection (verified workflow, not a tested recipe)

Compatible app versions change with every patch bundle. Do not hard-code or guess them.

1. Download the exact bundle into `tools/` and verify SHA-256 (see `tools-registry.md`).
2. `java -jar tools/morphe-desktop-*-all.jar list-versions --patches tools/patches-*.mpp -f <package>` — gives the versions to fetch.
3. `java -jar tools/morphe-desktop-*-all.jar list-patches --patches tools/patches-*.mpp --with-packages --with-versions --filter-package-name <package>` — gives patch names, indices, and per-patch compatibility.
4. Fetch the clean base from a trusted source (official docs point to APKMirror), record version name + version code in the app profile, then patch.

Base versions from older tutorials are stale. If a version differs from the recommended one, Morphe skips incompatible patches by default; `--force` applies them anyway and is not evidence of a working mod.

## Verified query results (2026-11-27, bundle 2.4.0)

Command: `java -jar tools/morphe-desktop-2.4.0-all.jar list-versions --patches tools/patches-2.4.0.mpp -f com.google.android.youtube`

Most common compatible YouTube versions (128 patches each): **21.30.216, 21.28.208, 21.23.492, 20.51.39, 20.26.46**. 21.30.216 is the newest listed and the best first choice.

Full patch list with names, indices, defaults and compatible versions was written to `workspace/temp/youtube-patches.txt` (gitignored, regenerate with `list-patches --with-packages --with-versions --filter-package-name com.google.android.youtube --out <path>`). Universal patches (indices 0–4) apply across apps and are not shown by that filter.

## Verified install behaviour (official FAQ + bundle patch description, 2026-11-27)

- The `GmsCore support` patch (index 238, enabled by default) uses "a different package name" — official Morphe FAQ command examples use `app.morphe.android.youtube` for patched YouTube. Expect the patched app to install **alongside** stock, not replace it, with default patches. Confirm the actual package name from the output APK before installing.
- On an unrooted device, Google sign-in/push in a patched app requires MicroG-RE (official FAQ: https://morphe.software/microg). Installing MicroG-RE is a separate APK install and needs explicit approval.
- To force a true same-package replacement, `GmsCore support` would need disabling and `Disable Play Store updates` (index 4) enabling; without root/signature spoofing, Google sign-in may then fail. Treat this as an unverified alternative until tested.

## Verified recipe: YouTube (2026-11-27)

1. Base: `workspace/input/youtube-21.30.216-nodpi.apk` (APKMirror universal nodpi plain APK, SHA-256 `3775a151...74d02`, cert `3d7a1223...994a` matches bundle).
2. Bundle: `tools/patches-2.4.0.mpp` (SHA-256 verified), with `tools/morphe-desktop-2.4.0-all.jar`.
3. Build: `powershell -File scripts/build-youtube.ps1` — applies the 128 default patches, `--striplibs arm64-v8a`, signs with the private keystore in `workspace/keystore/` (gitignored).
4. Output: `workspace/output/youtube-21.30.216-morphe-2.4.0.apk` — 114,171,692 bytes, SHA-256 `2552604f...1cfe86`.
5. Verification evidence: `scripts/apk_manifest.py` → package `app.morphe.android.youtube`, versionName 21.30.216, versionCode 1561187872; `scripts/apk_certs.py` → signing cert `d8d293fb...7533` matches the private keystore alias; patch result JSON → `success=true`, 128 applied, 0 failed, PATCHING/REBUILDING/SIGNING all true; zip integrity OK; original hash unchanged.
6. Install mode: alongside stock (different package name). MicroG-RE approval granted; downloaded and verified but not installed on the phone.
7. Published 2026-11-27 as GitHub Release `youtube-patched-21.30.216`: https://github.com/berliandro/apk-modding/releases/tag/youtube-patched-21.30.216 (both APKs uploaded as release assets; `*.apk` remains gitignored). Asset digests matched local SHA-256.

## Verified recipe: YouTube Music (2026-11-27)

1. Base: `workspace/input/youtube-music-9.30.53-arm64-nodpi.apk` (APKMirror arm64-v8a nodpi plain APK, SHA-256 `1fe8d535…e23ad334e`, cert `a2a1ad7b…897701ceb` accepted by bundle 2.4.0).
2. Build: `powershell -File scripts/build-app.ps1 -InputApk workspace/input/youtube-music-9.30.53-arm64-nodpi.apk -Out workspace/output/youtube-music-9.30.53-morphe-2.4.0.apk -ResultFile workspace/temp/youtube-music-patch-result.json` — 62 default patches, `--striplibs arm64-v8a`, private keystore.
3. Output: `workspace/output/youtube-music-9.30.53-morphe-2.4.0.apk` — 78,915,459 bytes, SHA-256 `b1aceb4e…b306f13a2`; package `app.morphe.android.apps.youtube.music`, version 9.30.53.
4. Verification: result JSON `success=true`, 62 applied / 0 failed, all steps true; output cert matches keystore; zip integrity OK; base unchanged.

## Verified recipe: Reddit (2026-11-27)

1. Base: `workspace/input/reddit-2026.40.0-arm64.apkm` (APKMirror arm64-v8a 480-640dpi split bundle, base + 26 splits, SHA-256 `2973c2f2…41744abce`, base cert `970b9114…869736f` accepted by bundle 2.4.0). Morphe auto-merges splits.
2. Build: `powershell -File scripts/build-app.ps1 -InputApk workspace/input/reddit-2026.40.0-arm64.apkm -Out workspace/output/reddit-2026.40.0-morphe-2.4.0.apk -ResultFile workspace/temp/reddit-patch-result.json` — 67 default patches, `--striplibs arm64-v8a`, private keystore.
3. Output: `workspace/output/reddit-2026.40.0-morphe-2.4.0.apk` — 92,882,937 bytes, SHA-256 `bd7fdbb9…bac7301691`; package `com.reddit.frontpage`, version 2026.40.0, versionCode 2147483647 (Play Store updates disabled).
4. Verification: result JSON `success=true`, 67 applied / 0 failed, all steps true; output cert matches keystore; zip integrity OK; base unchanged.
5. Published with YouTube Music in GitHub Release `patched-music-reddit-2026-11-27`: https://github.com/berliandro/apk-modding/releases/tag/patched-music-reddit-2026-11-27

## Recipe template (fill in only after a verified run)

```
App / package / version / version code:
Base file + source URL + SHA-256:
Bundle version + SHA-256:
ABI kept (--striplibs):
Enabled patches (-e / --ei):
Disabled patches (-d / --di):
Options (-O):
Signing keystore (private, gitignored):
Output file + verification evidence:
Date verified:
```
