# Pismo CLI

[![Build status](https://github.com/PismoAI/termux-app-cli/workflows/Build/badge.svg)](https://github.com/PismoAI/termux-app-cli/actions)

**Pismo CLI** is an Android terminal app with AI coding tools pre-configured. Built on [Termux](https://termux.com), it provides a Linux environment on your phone with easy access to Claude Code, Gemini CLI, and other AI assistants.

## Quick Start

### 1. Install the APK

Download the latest APK from [Releases](https://github.com/PismoAI/termux-app-cli/releases) or [Actions](https://github.com/PismoAI/termux-app-cli/actions) (look for artifacts).

- **Most phones**: Download `pismo-cli_*_arm64-v8a.apk`
- **Older phones**: Download `pismo-cli_*_armeabi-v7a.apk`
- **Unsure?**: Download `pismo-cli_*_universal.apk`

### 2. Run Setup

Open Pismo CLI and run:

```bash
curl -sL https://raw.githubusercontent.com/PismoAI/termux-app-cli/master/setup-pismo.sh | bash
```

This installs:
- Node.js & npm
- Claude Code CLI (`@anthropic-ai/claude-code`)
- Git, SSH, Python, and essential tools

### 3. Start Claude Code

```bash
claude
```

You'll need an API key from [console.anthropic.com](https://console.anthropic.com/).

## Important Notes

**Cannot coexist with Termux**: Pismo CLI uses the same internal package ID (`com.termux`) as Termux to maintain compatibility with bootstrap packages. You must uninstall Termux before installing Pismo CLI, or vice versa.

**Why?** Termux bootstrap binaries have `/data/data/com.termux` hardcoded. Changing the package ID breaks the entire system. A future version may include custom bootstrap packages to allow coexistence.

## Features

- Full Linux terminal on Android
- Pre-configured for AI coding assistants
- One-command setup for Claude Code
- Works on any Android 7+ device

## Building from Source

APKs are built automatically via GitHub Actions on every push to master.

To build locally:
```bash
./gradlew assembleDebug
# APK at: app/build/outputs/apk/debug/
```

## Support

- Issues: [GitHub Issues](https://github.com/PismoAI/termux-app-cli/issues)
- Donations: Coming soon

## Credits

Based on [Termux](https://github.com/termux/termux-app) - the amazing Android terminal emulator.

## License

[GPLv3](LICENSE.md) - Same as Termux
