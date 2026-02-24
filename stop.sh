#!/bin/bash

# ============================================
# Hospital Management System - Stop Script
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
echo "║   Stopping all services...                 ║"
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

# Stop containers
echo -e "${YELLOW}🛑 Stopping containers...${NC}"
$COMPOSE_CMD down

echo -e "${GREEN}✅ All services stopped successfully!${NC}"
echo ""
echo -e "${YELLOW}💡 To remove volumes (database data), run:${NC}"
echo "   $COMPOSE_CMD down -v"
echo ""

