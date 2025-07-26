#!/usr/bin/env bash

set -e

KEY_TYPE="ed25519"
KEY_COMMENT="noraaztivom@gmail.com" # Replace with your GitHub email
KEY_PATH="$HOME/.ssh/id_${KEY_TYPE}"

echo "🔐 Setting up SSH key..."

# 1. Check if key already exists
if [ -f "$KEY_PATH" ]; then
    echo "✅ SSH key already exists at $KEY_PATH"
else
    echo "🚀 Generating new SSH key..."
    ssh-keygen -t "$KEY_TYPE" -C "$KEY_COMMENT" -f "$KEY_PATH" -N ""
fi

# 2. Start ssh-agent if not running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    echo "🔄 Starting ssh-agent..."
    eval "$(ssh-agent -s)"
fi

# 3. Add key to agent
echo "➕ Adding key to ssh-agent..."
ssh-add "$KEY_PATH"

# 4. Copy public key to clipboard (macOS or Linux with xclip/xsel)
if command -v pbcopy &>/dev/null; then
    cat "${KEY_PATH}.pub" | pbcopy
    echo "📋 Public key copied to clipboard!"
elif command -v xclip &>/dev/null; then
    cat "${KEY_PATH}.pub" | xclip -selection clipboard
    echo "📋 Public key copied to clipboard!"
else
    echo "📄 Here's your public key:"
    cat "${KEY_PATH}.pub"
fi

# 5. Optionally upload with GitHub CLI
if command -v gh &>/dev/null; then
    echo "🌐 Adding key to GitHub with gh..."
    gh ssh-key add "${KEY_PATH}.pub" --title "$(hostname) - $(date +%Y-%m-%d)"
else
    echo "⚠️ GitHub CLI (gh) not found. Please add the SSH key manually:"
    echo "🔗 https://github.com/settings/keys"
fi

echo "✅ SSH key setup complete."

