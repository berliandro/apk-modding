# Troubleshooting

Only verified failure modes are recorded here. Add an entry only after diagnosing a real failure and confirming the fix. Source for all entries below: official Morphe Desktop docs, read 2026-11-27.

| Symptom | Root cause | Verified fix |
| --- | --- | --- |
| First GUI launch stalls or fails offline | GUI dependencies (Skiko renderer, JNA) are downloaded from Maven Central on first launch because the JAR is intentionally small | Allow network access once; later launches work offline. The CLI never downloads these — use CLI if network is unavailable. |
| Most patches skipped / no patches applied | APK version does not match the bundle's target versions | Use `list-versions` for the exact bundle, then fetch that base version. `--force` bypasses the check and applies patches anyway; it does not prove they work. |
| Patch source marked "Error / Incompatible" | Source failed to fetch, or it requires a different Patcher engine version | Check the source's required engine version against `tools-registry.md`; re-fetch with a compatible bundle. |
| Source shows "Key changed" or an unsigned bundle is refused | Signing key changed or bundle is unsigned/unknown (TOFU trust model) | Trust only after the developer officially announces a key rotation; otherwise discard the download. Official Morphe Patches are pinned automatically. |
| Device shows "Unauth" during ADB install | USB debugging prompt not accepted on the phone | Accept the prompt on the device, then retry. `adb shell exit` checks ADB health. |
| Patched app silently replaced by stock update | Installed via a Play Store installer variant, so Play Store can offer an overwrite | Prefer standard/Shizuku/root install; be aware of this trade-off before using a Play Store variant. |
| Config corrupted after concurrent runs | Concurrent writes to Morphe config | Run one patch process at a time. |
| "Installation blocked due to conflicting with an existing installation" | Same package already installed, including hidden installs (Samsung Secure Folder, Work Profile) | Unhide and uninstall the conflicting app, or use a different package name. Removing the original is an approval gate. (Source: official Morphe FAQ, 2026-11-27) |
| Patched YouTube cannot sign in or receive push on an unrooted device | Google Play Services rejects the app's new signature; MicroG-RE is required | Install official MicroG-RE from https://morphe.software/microg (needs approval); reinstall patched app if MicroG was reinstalled. (Source: official Morphe FAQ, 2026-11-27) |
| `keytool -printcert -jarfile` says "Not a signed jar file" | Modern APKs use only the v2/v3 APK Signature Scheme, not META-INF v1 certs | Use `scripts/apk_certs.py <apk>` to read the signing block certificate SHA-256; verified 2026-11-27. |
| Need to confirm the real package name of a patched APK | Patcher result JSON reports the input package name, not the renamed output | Use `scripts/apk_manifest.py <apk>` to read the binary manifest; output was `app.morphe.android.youtube`. Verified 2026-11-27. |
