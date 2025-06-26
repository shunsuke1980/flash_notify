# flash_notify - Flash macOS Menu Bar Notification Tool

A lightweight command-line tool that provides instant visual feedback by flashing the macOS menu bar when commands complete. Perfect for long-running tasks where you want to be notified without intrusive sounds or pop-ups.

![flash_notify demo](https://user-images.githubusercontent.com/demo/flash_notify-demo.gif)

## Features

- **Visual Notifications**: Flashes the menu bar by toggling dark mode rapidly
- **Exit Code Awareness**: Different flash patterns for success (2 flashes) and failure (3 rapid flashes)
- **Zero Dependencies**: Pure bash and AppleScript - no external dependencies
- **Minimal Footprint**: Simple command-line tool
- **Fast Response**: Sub-100ms flash initiation
- **Preserves Settings**: Automatically restores your original dark mode preference

## Installation

### Homebrew (Recommended)

```bash
# Add the tap
brew tap shunsuke1980/tap

# Install flash_notify
brew install flash_notify
```

## Usage

### Quick Setup

For convenience, add this alias to your shell configuration:

```bash
alias fl='flash_notify'
```

### Basic Usage

```bash
sleep 5; fl
fl sleep 5
```

### Options

```bash
flash_notify --help        # Show help message
flash_notify --version     # Show version information
flash_notify --debug       # Enable debug output
```

## Requirements

- macOS (Monterey or later recommended)
- Terminal with accessibility permissions
- System Events permission for AppleScript

## Permissions

On first run, macOS may prompt you to grant accessibility permissions.

To manually grant permissions:
1. Open System Preferences → Security & Privacy → Privacy → Accessibility
2. Add your terminal application (Terminal.app, iTerm2, etc.)
3. Ensure the checkbox is enabled

## How It Works

`flash_notify` uses AppleScript to rapidly toggle the macOS dark mode setting, creating a visual "flash" effect in the menu bar. The original dark mode state is preserved and restored after flashing.

The tool:
1. Captures the exit code of wrapped commands
2. Determines flash pattern based on success/failure
3. Toggles dark mode rapidly using AppleScript
4. Restores original settings
5. Preserves and returns the original exit code

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Alternatives

- **terminal-notifier**: macOS notification center integration
- **noti**: Cross-platform command notifications
- **ntfy**: HTTP-based notification system

What makes `flash_notify` unique:
- Visual menu bar feedback (no other tool does this)
- Zero dependencies
- Perfect for one-liner usage
- Simple and descriptive command name

## Acknowledgments

- Inspired by the need for non-intrusive visual notifications
- Built for developers who want quick feedback without disruption
- Thanks to the macOS AppleScript community

## ☕ Support

If you find this project helpful and would like to support its continued development:

[<img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="BuyMeACoffee" width="100">](https://www.buymeacoffee.com/shunsuke1980)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/shunsuke1980?style=social)](https://github.com/sponsors/shunsuke1980)