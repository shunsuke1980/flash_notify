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
brew tap shunsuke1980/flash_notify

# Install flash_notify
brew install flash_notify
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/shunsuke1980/flash_notify.git
cd flash_notify

# Install using make
make install

# Or manually copy to your PATH
cp flash_notify /usr/local/bin/
chmod +x /usr/local/bin/flash_notify
```

## Usage

### Basic Usage

Wrap any command with `flash_notify` to get notified when it completes:

```bash
# Long-running commands
flash_notify sleep 10
flash_notify make build
flash_notify npm install
flash_notify "git clone https://github.com/large-repo.git"

# Multiple commands
flash_notify "npm install && npm test"
```

### One-liner Usage

Perfect for adding to existing commands:

```bash
# Add fl after any command
make; flash_notify
curl api.example.com; flash_notify
python train_model.py; flash_notify
```

### Manual Flash

Trigger a flash manually:

```bash
# Default flash (2 times, 0.15s interval)
flash_notify flash

# Custom flash pattern
flash_notify flash 3 0.2    # 3 flashes with 0.2s intervals
flash_notify flash 5 0.1    # 5 rapid flashes
```

### Options

```bash
flash_notify --help        # Show help message
flash_notify --version     # Show version information
flash_notify --debug       # Enable debug output
```

## Examples

### Development Workflows

```bash
# Build notifications
flash_notify cargo build --release
flash_notify go build ./...
flash_notify gradle build

# Test notifications
flash_notify pytest
flash_notify npm test
flash_notify make test

# Deployment notifications
flash_notify docker build -t myapp .
flash_notify kubectl apply -f deployment.yaml
```

### Data Processing

```bash
# Long computations
flash_notify python process_data.py
flash_notify jupyter nbconvert notebook.ipynb
flash_notify ffmpeg -i input.mp4 output.mp4
```

### System Tasks

```bash
# Backups
flash_notify rsync -av /source/ /backup/
flash_notify tar -czf backup.tar.gz /important/

# Downloads
flash_notify wget https://large-file.zip
flash_notify brew upgrade
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

## Troubleshooting

### "Failed to get current dark mode state"

This error indicates permission issues. Make sure your terminal has accessibility permissions (see above).

### Flash doesn't work but no error appears

1. Test AppleScript directly:
   ```bash
   osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode'
   ```

2. If that fails, grant permissions and restart your terminal.

### Command not found: flash_notify

Ensure `/usr/local/bin` is in your PATH:
```bash
echo $PATH
# If not present, add to your shell profile:
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## How It Works

`flash_notify` uses AppleScript to rapidly toggle the macOS dark mode setting, creating a visual "flash" effect in the menu bar. The original dark mode state is preserved and restored after flashing.

The tool:
1. Captures the exit code of wrapped commands
2. Determines flash pattern based on success/failure
3. Toggles dark mode rapidly using AppleScript
4. Restores original settings
5. Preserves and returns the original exit code

## Performance

- **Flash initiation**: < 100ms
- **Single flash duration**: ~150-200ms
- **Memory usage**: Minimal (shell script)
- **CPU usage**: Negligible

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

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