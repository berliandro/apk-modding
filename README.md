# apk-modding

Self-improving APK-modding automation workspace. Remote: https://github.com/berliandro/apk-modding.git

Start with [AGENTS.md](AGENTS.md) — it is the operating contract for every session. Verified tool facts are in `knowledge/tools-registry.md`; app workflows in `knowledge/app-recipes.md`; confirmed fixes in `knowledge/troubleshooting.md`.

Layout: `private/` (gitignored device/personal profiles), `profiles/` (app profiles), `knowledge/`, `scripts/`, `tools/` (local binaries; only `manifest.json` is tracked), `workspace/` (gitignored `input/`, `temp/`, `output/`).

Fresh clone: run `powershell -File scripts/init-workspace.ps1` to recreate the ignored directories. Never push to the remote without explicit approval.
