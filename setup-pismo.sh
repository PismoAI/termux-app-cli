#!/data/data/com.termux/files/usr/bin/bash
# Pismo CLI Setup Script
# Run with: curl -sL https://raw.githubusercontent.com/PismoAI/termux-app-cli/master/setup-pismo.sh | bash

set -e

echo "======================================"
echo "  Pismo CLI - AI Terminal Setup"
echo "======================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() { echo -e "${GREEN}[+]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[-]${NC} $1"; }

# Check if running in Termux
if [ ! -d "/data/data/com.termux" ]; then
    print_error "This script must be run in Termux/Pismo CLI!"
    exit 1
fi

# Grant storage permissions
print_status "Setting up storage access..."
termux-setup-storage 2>/dev/null || true

# Update packages
print_status "Updating package repositories..."
pkg update -y

print_status "Upgrading installed packages..."
pkg upgrade -y

# Install essential packages
print_status "Installing essential packages..."
pkg install -y \
    nodejs \
    git \
    openssh \
    curl \
    wget \
    vim \
    nano \
    python \
    which \
    proot

# Install Claude Code CLI
print_status "Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code

# Install other AI CLI tools (optional, uncomment as needed)
# print_status "Installing Gemini CLI..."
# npm install -g @anthropic-ai/claude-code

# Create helpful aliases
print_status "Setting up shell configuration..."
cat >> ~/.bashrc << 'EOF'

# Pismo CLI Aliases
alias ll='ls -la'
alias cls='clear'
alias update='pkg update && pkg upgrade -y'
alias claude='claude'

# Welcome message
if [ -z "$PISMO_WELCOMED" ]; then
    export PISMO_WELCOMED=1
    echo ""
    echo "  Welcome to Pismo CLI!"
    echo "  Type 'claude' to start Claude Code"
    echo ""
fi
EOF

# Create a quick-start script
cat > ~/start-claude.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "Starting Claude Code..."
echo "Tip: Use 'exit' to quit Claude Code"
echo ""
claude
EOF
chmod +x ~/start-claude.sh

echo ""
echo "======================================"
print_status "Pismo CLI setup complete!"
echo "======================================"
echo ""
echo "Quick start commands:"
echo "  claude          - Start Claude Code AI"
echo "  ./start-claude.sh - Alternative way to start Claude"
echo ""
echo "To use Claude Code, you'll need an API key from:"
echo "  https://console.anthropic.com/"
echo ""
echo "Restart your terminal or run: source ~/.bashrc"
echo ""
