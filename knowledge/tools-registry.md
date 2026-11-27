# Tools registry

Verified 2026-11-27 from official GitHub repos, release APIs, and official docs. "Installed" means the file is present in `tools/` on this host — currently none are downloaded. Re-verify before every fetch; versions move fast.

## Morphe Desktop (CLI + GUI patcher)

- Official: https://github.com/MorpheApp/morphe-desktop
- Docs: https://github.com/MorpheApp/morphe-desktop/blob/main/docs/documentation.md
- Latest stable: **v2.4.0**, published 2026-11-26 (source: `https://api.github.com/repos/MorpheApp/morphe-desktop/releases/latest`)
- Asset: `morphe-desktop-2.4.0-all.jar` — 48,905,913 bytes
- URL: https://github.com/MorpheApp/morphe-desktop/releases/download/v2.4.0/morphe-desktop-2.4.0-all.jar
- SHA-256: `d5f75c05e6c84731dc18faa658810a3ed49ab32d60b756da8503432e78cf1477`
- Installed / latest verified: **none / 2.4.0**
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
- Installed / latest verified: **none / 2.4.0**
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

## Host prerequisites (verified 2026-11-27)

- Present: git 2.55.0, OpenJDK 21 (`java`/`javac`/`keytool`), Python 3.14.5 — satisfies JRE 21+.
- Not on PATH: `adb`, `apksigner`, `zipalign`; no Morphe binaries. Do not assume them; install/update only with approval.
