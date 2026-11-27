# Tools registry

Verified 2026-11-27 from official GitHub repos, release APIs, and official docs. "Installed" means the file is present in `tools/` on this host — currently none are downloaded. Re-verify before every fetch; versions move fast.

## Morphe Desktop (CLI + GUI patcher)

- Official: https://github.com/MorpheApp/morphe-desktop
- Docs: https://github.com/MorpheApp/morphe-desktop/blob/main/docs/documentation.md
- Latest stable: **v2.4.0**, published 2026-11-26 (source: `https://api.github.com/repos/MorpheApp/morphe-desktop/releases/latest`)
- Asset: `morphe-desktop-2.4.0-all.jar` — 48,905,913 bytes
- URL: https://github.com/MorpheApp/morphe-desktop/releases/download/v2.4.0/morphe-desktop-2.4.0-all.jar
- SHA-256: `d5f75c05e6c84731dc18faa658810a3ed49ab32d60b756da8503432e78cf1477`
- Installed / latest verified: **2.4.0 / 2.4.0** — downloaded to `tools/`, local SHA-256 matched upstream on 2026-11-27.
- Dependencies: JRE 21+; ADB optional for `-i`; GUI only downloads Skiko + JNA into `morphe-data/libs/` on first launch (CLI downloads nothing).
- License: GPL-3.0 with Section 7 conditions — preserve notices; do not use "Morphe" branding for derivative works.

Base command:

```
java -jar morphe-desktop-2.4.0-all.jar patch -p patches-2.4.0.mpp <app.apk>
```

Verified flags (from official CLI docs, 2026-11-27):

| Area | Flags |
| --- | --- |
| Input/source | positional APK (also `.apkm`/`.xapk`/`.apks`, auto-merged), `-p`/`--patches` (repeatable, file/dir/repo URL), `--prerelease` |
| Output | `-o`/`--out` (default `<app>/<app>-<version>-patches-<bundle>.apk`), `-r`/`--result-file` |
| Selection | `-e`/`--enable`, `--ei`, `-d`/`--disable`, `--di`, `--exclusive`, `-O key=value`, `--options-file`, `--options-update` |
| Compatibility | `-f`/`--force` (skip version check; incompatible patches are skipped by default), `--continue-on-error`, `--striplibs arm64-v8a,x86`, `--bytecode-mode STRIP_SAFE|STRIP_FAST`, `--verify-with-sdk`, `--validate` |
| Signing | `--keystore`, `--keystore-password`, `--keystore-entry-alias`, `--keystore-entry-password`, `--signer`, `--unsigned` |
| Install/device | `-i`/`--install [serial]`, `--mount` (root, requires original installed) |
| Scratch | `-t`/`--temporary-files-path`, `--disable-purge`, `--save-original COPY|MOVE|OFF` |

Other subcommands: `list-patches` (`--with-packages`, `--with-versions`, `--with-options`, `--filter-package-name`, `--include-experimental`, `--out`), `list-versions` (`--filter-package-names`, `--include-experimental`), `options-create`, `utility install|uninstall|clear-cache`. Use `--help` to confirm before relying on a flag.

Data root: `morphe-data/` next to the JAR, fallback `~/morphe/`, override with `MORPHE_DATA_DIR`. `--keystore` defaults to `morphe.keystore` in that root; public default alias/key password is `Morphe`, store password empty — generate and gitignore your own keystore.

## Morphe Patches (patch bundle)

- Official: https://github.com/MorpheApp/morphe-patches
- Latest stable: **v2.4.0**, published 2026-11-26 (source: `https://api.github.com/repos/MorpheApp/morphe-patches/releases/latest`)
- Asset: `patches-2.4.0.mpp` — 19,340,871 bytes; bundle contains 266 patches (129 YouTube, 63 YouTube Music, 69 Reddit, 5 universal)
- URL: https://github.com/MorpheApp/morphe-patches/releases/download/v2.4.0/patches-2.4.0.mpp
- SHA-256: `880d559a3a09846d729b6801638c84a7de446918198d590fa557b68c27a17cd2`
- Public key (from `patches-bundle.json`, 2026-11-27): `g8Ys9leTu2yeixojeR35HrNkK6eOSLpA6nNIizRutqI=`
- Installed / latest verified: **2.4.0 / 2.4.0** — downloaded to `tools/`, local SHA-256 matched upstream on 2026-11-27.
- License: GPL-3.0 with Section 7 conditions.

## Morphe Manager (on-device patcher, alternative to Desktop)

- Official: https://github.com/MorpheApp/morphe-manager
- Guides: https://github.com/MorpheApp/morphe-manager/blob/main/docs/README.md
- Latest stable: **v2.8.0**, published 2026-11-26 (source: `https://api.github.com/repos/MorpheApp/morphe-manager/releases/latest`)
- Asset: `morphe-manager-2.8.0.apk` — 51,500,004 bytes
- URL: https://github.com/MorpheApp/morphe-manager/releases/download/v2.8.0/morphe-manager-2.8.0.apk
- SHA-256: `719099ec2269d41289b24d3810501762d5e4a35a1d5a39e65da4b8fafb74220a`
- Detached signature also published: `morphe-manager-2.8.0.apk.asc`
- Installed / latest verified: **none / 2.8.0** (not installed; approval gate applies)
- Workflow: install manager, pick app, Simple mode (one tap) or Expert mode (select patches/options), provide original APK, patch on device, install result. Installers: standard, Shizuku/Sui, root mount, Play Store variants. Verification source: official README, 2026-11-27.

## MicroG-RE (Google services for patched apps on unrooted devices)

- Official: https://morphe.software/microg → https://github.com/MorpheApp/MicroG-RE
- Latest stable: **7.4.0**, published 2026-11-25 (source: `https://api.github.com/repos/MorpheApp/MicroG-RE/releases/latest`)
- Downloaded arm64-v8a variant: `microg-7.4.0-icon-arm64-v8a.apk` — 45,927,168 bytes
- URL: https://github.com/MorpheApp/MicroG-RE/releases/download/7.4.0/microg-7.4.0-icon-arm64-v8a.apk
- SHA-256: `5587ec2b2fe8738ea92bd04a9e54588059d6e3558add0fe7e0c7e1c7ac908cc9` — verified locally 2026-11-27
- Package: `app.revanced.android.gms`, version 7.4.0 (read with `scripts/apk_manifest.py`); v2/v3 signing cert SHA-256 `0b6c9515afb195fac59601696ba0a7907a0b217ccf720b43148427ccf64343e7`
- Authenticity check 2026-11-27: downloaded cert SHA-256 `0b6c9515…64343e7` exactly matches the fingerprint published in the official `MorpheApp/MicroG-RE` README (`0B:6C:95:15:...:43:E7` for `app.revanced.android.gms`), and matches official release 7.3.3 too (same key across versions).
- Local check 2026-11-27: Windows Defender (signatures same day) reported "found no threats"; ZIP integrity OK; 71 declared permissions, mostly typical of a GmsCore replacement. **This is not a multi-engine malware scan.**
- Not installed on the phone — installing an APK requires explicit approval.

## Host prerequisites (verified 2026-11-27)

- Present: git 2.55.0, OpenJDK 21 (`java`/`javac`/`keytool`), Python 3.14.5 — satisfies JRE 21+.
- Not on PATH: `adb`, `apksigner`, `zipalign`; no Morphe binaries. Do not assume them; install/update only with approval.
