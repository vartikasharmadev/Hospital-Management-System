#!/bin/bash

# ============================================
# Hospital Management System - Logs Script
# ============================================

# Colors for output
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════╗"
echo "║   Hospital Management System               ║"
echo "║   Viewing logs...                          ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if Docker Compose is available
if ! docker compose version &> /dev/null; then
    if ! command -v docker-compose &> /dev/null; then
        echo "Error: Docker Compose is not installed."
        exit 1
    fi
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

# Navigate to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check for service argument
SERVICE=${1:-""}

if [ -z "$SERVICE" ]; then
    echo -e "${YELLOW}📋 Showing logs for all services (Ctrl+C to exit)${NC}"
    echo ""
    $COMPOSE_CMD logs -f
else
    echo -e "${YELLOW}📋 Showing logs for: $SERVICE (Ctrl+C to exit)${NC}"
    echo ""
    $COMPOSE_CMD logs -f "$SERVICE"
fi

