#!/usr/bin/env bash

# Fail script if any errors in script or any command failed
set -euo pipefail 

# Load .env file
if [ -f .env ]; then
  source .env
else
  echo ".env file not found"
  exit 1
fi

# Guard
if [ -z "$SUDO_USER" ]; then
echo "❌ Run this script using: sudo bash setup.bash"
exit 1
fi

REAL_USER="$SUDO_USER"
HOME_DIR="$(eval echo "~$REAL_USER")"
REPO_DIR="$HOME_DIR/repos"
INITIAL_SETUP_REPO_DIR="$REPO_DIR/ai_pet_pi_initial"
ROS_REPO_DIR="$REPO_DIR/ai_pet_ros"
CORE_REPO_DIR="$REPO_DIR/ai_pet_core"

echo "👤 Running as user: $REAL_USER"
echo "🏠 Home directory: $HOME_DIR"

# Updates system, installs git
echo "📕 Updating system and installing git"
apt update
apt upgrade -y
apt install -y \
ca-certificates \
curl \
gnupg \
lsb-release \
apt-transport-https \
git

# Install docker
echo "🐳 Installing Docker..."
curl -fsSL https://get.docker.com | sh
apt install -y docker-compose-plugin
systemctl enable docker
systemctl start docker
usermod -aG docker "$REAL_USER"

# Clone repos
echo "📥 Clone repos..."
sudo -u "$REAL_USER" mkdir -p "$REPO_DIR"
cd "$REPO_DIR"
sudo -u "$REAL_USER" git clone https://${GITHUB_TOKEN}@github.com/sanidhya-saraswat/ai_pet_pi_initial.git "$INITIAL_SETUP_REPO_DIR"
sudo -u "$REAL_USER" git clone https://${GITHUB_TOKEN}@github.com/sanidhya-saraswat/ai_pet_ros.git "$ROS_REPO_DIR"
sudo -u "$REAL_USER" git clone https://${GITHUB_TOKEN}@github.com/sanidhya-saraswat/ai_pet_core.git "$CORE_REPO_DIR"

# Reboot
echo "🔁 Rebooting..."
sync
sleep 3
reboot