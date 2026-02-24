#!/bin/bash

# ============================================
# Hospital Management System - Development Start
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
echo "║   Starting DEVELOPMENT mode...             ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if Docker Compose is available
if ! docker compose version &> /dev/null; then
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${RED}Error: Docker Compose is not installed.${NC}"
        exit 1
    fi
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

# Navigate to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${YELLOW}📦 Starting development containers with hot reload...${NC}"

# Stop any existing containers
$COMPOSE_CMD -f docker-compose.dev.yml down --remove-orphans 2>/dev/null || true

# Start development containers
$COMPOSE_CMD -f docker-compose.dev.yml up --build

echo ""
echo -e "${GREEN}Development servers stopped.${NC}"

