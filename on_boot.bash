#!/usr/bin/env bash
# DO NOT use sudo while running this script

# Fail script if any errors in script or any command failed
set -euo pipefail 

HOME_DIR=$(eval echo "~$USER")
REPO_DIR="$HOME_DIR/repos"
INITIAL_SETUP_REPO_DIR="$REPO_DIR/ai_pet_pi_initial"
ROS_REPO_DIR="$REPO_DIR/ai_pet_ros"
CORE_REPO_DIR="$REPO_DIR/ai_pet_core"

# Update Repos
echo "📥 Update repos..."
cd "$INITIAL_SETUP_REPO_DIR"
git pull
cd "$ROS_REPO_DIR"
git pull
cd "$CORE_REPO_DIR"
git pull

# Docker Compose
echo "🐳 Starting Docker stacks..."
cd "$ROS_REPO_DIR"
docker compose down
docker compose up -d </dev/null >/dev/null 2>&1
cd "$CORE_REPO_DIR"
docker compose down
docker compose up -d </dev/null >/dev/null 2>&1