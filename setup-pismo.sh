#!/data/data/com.termux/files/usr/bin/bash
# Pismo CLI - One-command setup
# Run: curl -sL https://raw.githubusercontent.com/PismoAI/termux-app-cli/master/setup-pismo.sh | bash

set -e

# Colors for output
G='\033[0;32m'  # Green
B='\033[0;34m'  # Blue
C='\033[0;36m'  # Cyan
W='\033[1;37m'  # White
N='\033[0m'     # No color

clear
echo ""
echo -e "${C}╔══════════════════════════════════════════╗${N}"
echo -e "${C}║${W}          Welcome to Pismo CLI            ${C}║${N}"
echo -e "${C}║${N}      AI-Powered Terminal for Android     ${C}║${N}"
echo -e "${C}╚══════════════════════════════════════════╝${N}"
echo ""
echo -e "${B}Setting up your AI coding environment...${N}"
echo ""

# Grant storage permissions
echo -e "${G}[1/6]${N} Setting up storage access..."
termux-setup-storage 2>/dev/null || true
sleep 1

# Update packages
echo -e "${G}[2/6]${N} Updating system..."
pkg update -y -q 2>/dev/null
pkg upgrade -y -q 2>/dev/null

# Install essential packages
echo -e "${G}[3/6]${N} Installing dependencies..."
pkg install -y -q nodejs git openssh curl wget python proot 2>/dev/null

# Install Claude Code
echo -e "${G}[4/6]${N} Installing Claude Code AI..."
npm install -g @anthropic-ai/claude-code 2>/dev/null

# Apply theme
echo -e "${G}[5/6]${N} Applying Pismo theme..."
mkdir -p ~/.termux

# Download and apply dark theme (ChatGPT-like)
curl -sL https://raw.githubusercontent.com/PismoAI/termux-app-cli/master/pismo-theme/colors-dark.properties > ~/.termux/colors.properties
curl -sL https://raw.githubusercontent.com/PismoAI/termux-app-cli/master/pismo-theme/termux.properties > ~/.termux/termux.properties

# Reload settings
termux-reload-settings 2>/dev/null || true

# Setup shell for clean experience
echo -e "${G}[6/6]${N} Configuring environment..."

cat > ~/.bashrc << 'BASHRC'
# Pismo CLI Configuration

# Clean prompt
PS1='\[\e[0;36m\]pismo\[\e[0m\] \[\e[0;32m\]\w\[\e[0m\] → '

# Aliases
alias c='claude'
alias cls='clear'
alias ll='ls -la'

# Welcome function
pismo_welcome() {
    clear
    echo ""
    echo -e "\033[0;36m╭─────────────────────────────────────────╮\033[0m"
    echo -e "\033[0;36m│\033[1;37m            Pismo CLI Ready              \033[0;36m│\033[0m"
    echo -e "\033[0;36m╰─────────────────────────────────────────╯\033[0m"
    echo ""
    echo -e "  \033[0;32m→\033[0m Type \033[1;37mclaude\033[0m to start AI assistant"
    echo -e "  \033[0;32m→\033[0m Type \033[1;37mhelp\033[0m for commands"
    echo ""
}

# Help function
help() {
    echo ""
    echo -e "\033[1;37mPismo CLI Commands:\033[0m"
    echo ""
    echo -e "  \033[0;36mclaude\033[0m     Start Claude Code AI"
    echo -e "  \033[0;36mc\033[0m          Quick alias for claude"
    echo -e "  \033[0;36mcls\033[0m        Clear screen"
    echo -e "  \033[0;36mexit\033[0m       Close Pismo CLI"
    echo ""
}

# Auto-welcome on first terminal
if [ -z "$PISMO_WELCOMED" ]; then
    export PISMO_WELCOMED=1
    pismo_welcome
fi
BASHRC

# Create launcher script
cat > ~/claude << 'LAUNCHER'
#!/data/data/com.termux/files/usr/bin/bash
clear
echo ""
echo -e "\033[0;36m  Starting Claude Code...\033[0m"
echo -e "\033[0;90m  Tip: Type 'exit' or press Ctrl+C to quit\033[0m"
echo ""
sleep 0.5
/data/data/com.termux/files/usr/bin/claude "$@"
LAUNCHER
chmod +x ~/claude

clear
echo ""
echo -e "${C}╔══════════════════════════════════════════╗${N}"
echo -e "${C}║${W}         Setup Complete!                  ${C}║${N}"
echo -e "${C}╚══════════════════════════════════════════╝${N}"
echo ""
echo -e "  ${G}✓${N} Claude Code installed"
echo -e "  ${G}✓${N} Theme applied"
echo -e "  ${G}✓${N} Environment configured"
echo ""
echo -e "  ${W}To get started:${N}"
echo ""
echo -e "  ${C}1.${N} Close and reopen Pismo CLI"
echo -e "  ${C}2.${N} Type ${W}claude${N} and press Enter"
echo -e "  ${C}3.${N} Enter your API key from:"
echo -e "     ${B}console.anthropic.com${N}"
echo ""
echo -e "  ${W}Quick tip:${N} Just type ${C}c${N} as a shortcut!"
echo ""
