#!/bin/bash

# ============================================
# Hospital Management System - Restart Script
# ============================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════╗"
echo "║   Hospital Management System               ║"
echo "║   Restarting all services...               ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Navigate to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Stop and start
./stop.sh
./start.sh

