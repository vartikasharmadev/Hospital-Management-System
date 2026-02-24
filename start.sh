#!/bin/bash

# ============================================
# Hospital Management System - Start Script
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
echo "║   Starting all services...                 ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi

# Check if Docker Compose is available
if ! docker compose version &> /dev/null; then
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${RED}Error: Docker Compose is not installed. Please install Docker Compose first.${NC}"
        exit 1
    fi
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

echo -e "${YELLOW}📦 Using: ${COMPOSE_CMD}${NC}"

# Navigate to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${YELLOW}📁 Working directory: $(pwd)${NC}"

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo -e "${RED}Error: docker-compose.yml not found in $(pwd)${NC}"
    exit 1
fi

# Stop any existing containers
echo -e "${YELLOW}🛑 Stopping any existing containers...${NC}"
$COMPOSE_CMD down --remove-orphans 2>/dev/null || true

# Build and start containers
echo -e "${YELLOW}🔨 Building Docker images...${NC}"
$COMPOSE_CMD build --no-cache

echo -e "${YELLOW}🚀 Starting services...${NC}"
$COMPOSE_CMD up -d

# Wait for services to be healthy
echo -e "${YELLOW}⏳ Waiting for services to be ready...${NC}"

# Wait for MongoDB
echo -n "   MongoDB: "
for i in {1..30}; do
    if $COMPOSE_CMD exec -T mongodb mongosh --eval "db.runCommand('ping').ok" --quiet &>/dev/null; then
        echo -e "${GREEN}Ready ✓${NC}"
        break
    fi
    echo -n "."
    sleep 2
done

# Wait for Backend
echo -n "   Backend: "
for i in {1..30}; do
    if curl -s http://localhost:8080/ &>/dev/null; then
        echo -e "${GREEN}Ready ✓${NC}"
        break
    fi
    echo -n "."
    sleep 2
done

# Wait for Frontend
echo -n "   Frontend: "
for i in {1..30}; do
    if curl -s http://localhost:3000/ &>/dev/null; then
        echo -e "${GREEN}Ready ✓${NC}"
        break
    fi
    echo -n "."
    sleep 2
done

# Run seed script
echo -e "${YELLOW}🌱 Seeding database with default data...${NC}"
$COMPOSE_CMD run --rm seed 2>/dev/null || echo -e "${YELLOW}   (Seed may have already run)${NC}"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗"
echo "║   🎉 All services are running!             ║"
echo "╠════════════════════════════════════════════╣"
echo "║                                            ║"
echo "║   🌐 Frontend:  http://localhost:3000      ║"
echo "║   🔧 Backend:   http://localhost:8080      ║"
echo "║   🗄️  MongoDB:   mongodb://localhost:27017 ║"
echo "║                                            ║"
echo "╠════════════════════════════════════════════╣"
echo "║   📋 Login Credentials:                    ║"
echo "║                                            ║"
echo "║   Admin  → ID: 100, Password: masai       ║"
echo "║   Doctor → ID: 101, Password: masai       ║"
echo "║   Nurse  → ID: 102, Password: masai       ║"
echo "║                                            ║"
echo "╠════════════════════════════════════════════╣"
echo "║   📝 Useful Commands:                      ║"
echo "║                                            ║"
echo "║   View logs:    ./logs.sh                  ║"
echo "║   Stop:         ./stop.sh                  ║"
echo "║   Restart:      ./restart.sh               ║"
echo "║                                            ║"
echo -e "╚════════════════════════════════════════════╝${NC}"
echo ""

