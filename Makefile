.PHONY: all install uninstall test clean release help

# Installation directories
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
INSTALL = install

# Version
VERSION = 1.0.0

# Default target
all: help

# Install flash_notify to system
install:
	@echo "Installing flash_notify to $(BINDIR)..."
	@mkdir -p $(BINDIR)
	@$(INSTALL) -m 755 flash_notify $(BINDIR)/flash_notify
	@echo "Installation complete!"
	@echo ""
	@echo "flash_notify has been installed to $(BINDIR)/flash_notify"
	@echo "Make sure $(BINDIR) is in your PATH."
	@echo ""
	@echo "Run 'flash_notify --help' to get started."

# Uninstall flash_notify from system
uninstall:
	@echo "Uninstalling flash_notify..."
	@rm -f $(BINDIR)/flash_notify
	@echo "Uninstall complete!"

# Run tests
test:
	@echo "Running flash_notify tests..."
	@echo ""
	@echo "Testing version output..."
	@./flash_notify --version | grep -q "$(VERSION)" && echo "✓ Version test passed" || echo "✗ Version test failed"
	@echo ""
	@echo "Testing help output..."
	@./flash_notify --help | grep -q "Flash macOS menu bar" && echo "✓ Help test passed" || echo "✗ Help test failed"
	@echo ""
	@echo "Testing command execution..."
	@./flash_notify true && echo "✓ Command execution test passed" || echo "✗ Command execution test failed"
	@echo ""
	@echo "Testing exit code preservation..."
	@./flash_notify false; test $$? -eq 1 && echo "✓ Exit code test passed" || echo "✗ Exit code test failed"
	@echo ""
	@echo "Testing debug mode..."
	@./flash_notify --debug true 2>&1 | grep -q "\[DEBUG\]" && echo "✓ Debug mode test passed" || echo "✗ Debug mode test failed"
	@echo ""
	@echo "All tests complete!"

# Create a release tarball
release: clean
	@echo "Creating release tarball for v$(VERSION)..."
	@mkdir -p ../flash_notify-$(VERSION)
	@cp -r flash_notify README.md LICENSE Makefile homebrew ../flash_notify-$(VERSION)/
	@cd .. && tar -czf flash_notify-$(VERSION).tar.gz flash_notify-$(VERSION)
	@rm -rf ../flash_notify-$(VERSION)
	@echo "Release tarball created: ../flash_notify-$(VERSION).tar.gz"
	@echo ""
	@echo "SHA256 checksum:"
	@shasum -a 256 ../flash_notify-$(VERSION).tar.gz

# Clean up
clean:
	@echo "Cleaning up..."
	@rm -f ../flash_notify-*.tar.gz
	@echo "Clean complete!"

# Development install (symlink)
dev-install:
	@echo "Creating development symlink..."
	@ln -sf $(PWD)/flash_notify $(BINDIR)/flash_notify
	@echo "Development install complete!"

# Development uninstall
dev-uninstall:
	@echo "Removing development symlink..."
	@rm -f $(BINDIR)/flash_notify
	@echo "Development uninstall complete!"

# Check prerequisites
check:
	@echo "Checking flash_notify prerequisites..."
	@echo ""
	@echo -n "macOS: "
	@if [[ "$$(uname)" == "Darwin" ]]; then echo "✓"; else echo "✗ (flash_notify requires macOS)"; fi
	@echo -n "bash: "
	@if command -v bash >/dev/null 2>&1; then echo "✓"; else echo "✗"; fi
	@echo -n "osascript: "
	@if command -v osascript >/dev/null 2>&1; then echo "✓"; else echo "✗"; fi
	@echo ""
	@echo "Checking permissions..."
	@echo "Testing AppleScript access..."
	@if osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode' >/dev/null 2>&1; then \
		echo "✓ AppleScript permissions OK"; \
	else \
		echo "✗ AppleScript permissions missing"; \
		echo "  Please grant Terminal accessibility permissions in:"; \
		echo "  System Preferences → Security & Privacy → Privacy → Accessibility"; \
	fi

# Help message
help:
	@echo "flash_notify - Flash macOS Menu Bar Notification Tool"
	@echo ""
	@echo "Available targets:"
	@echo "  make install      Install flash_notify to $(PREFIX)/bin"
	@echo "  make uninstall    Remove flash_notify from system"
	@echo "  make test         Run basic tests"
	@echo "  make check        Check prerequisites and permissions"
	@echo "  make release      Create release tarball"
	@echo "  make clean        Clean up generated files"
	@echo "  make dev-install  Create development symlink"
	@echo "  make dev-uninstall Remove development symlink"
	@echo "  make help         Show this help message"
	@echo ""
	@echo "Variables:"
	@echo "  PREFIX            Installation prefix (default: /usr/local)"
	@echo "                    Use: make install PREFIX=/opt/local"