#!/bin/bash

# ============================================
# Hospital Management System - Clean Script
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
echo "║   Cleaning up...                           ║"
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

echo -e "${YELLOW}⚠️  This will remove:${NC}"
echo "   - All containers"
echo "   - All volumes (database data)"
echo "   - All images built for this project"
echo ""

read -p "Are you sure you want to continue? (y/N) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}🛑 Stopping and removing containers...${NC}"
    $COMPOSE_CMD down -v --rmi local --remove-orphans

    echo -e "${YELLOW}🧹 Removing dangling images...${NC}"
    docker image prune -f 2>/dev/null || true

    echo -e "${GREEN}✅ Cleanup completed!${NC}"
else
    echo -e "${YELLOW}Cleanup cancelled.${NC}"
fi

