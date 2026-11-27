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
