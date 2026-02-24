#!/bin/bash

# ============================================
# Hospital Management System - Local Start (No Docker)
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
echo "║   Starting LOCAL mode (no Docker)...       ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

# Navigate to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed.${NC}"
    exit 1
fi

# Check if MongoDB is running
echo -e "${YELLOW}🔍 Checking MongoDB connection...${NC}"
if ! command -v mongosh &> /dev/null; then
    echo -e "${YELLOW}⚠️  mongosh not found. Make sure MongoDB is running on localhost:27017${NC}"
else
    if mongosh --eval "db.runCommand('ping').ok" --quiet mongodb://localhost:27017 &>/dev/null; then
        echo -e "${GREEN}   MongoDB is running ✓${NC}"
    else
        echo -e "${RED}   MongoDB is not running. Please start MongoDB first.${NC}"
        echo -e "${YELLOW}   You can start MongoDB with Docker:${NC}"
        echo "   docker run -d -p 27017:27017 --name mongodb mongo:6.0"
        exit 1
    fi
fi

# Install backend dependencies
echo -e "${YELLOW}📦 Installing backend dependencies...${NC}"
cd "$SCRIPT_DIR/Backend"
npm install

# Install frontend dependencies
echo -e "${YELLOW}📦 Installing frontend dependencies...${NC}"
cd "$SCRIPT_DIR/FrontEnd"
npm install

# Create backend .env file if it doesn't exist
if [ ! -f "$SCRIPT_DIR/Backend/.env" ]; then
    echo -e "${YELLOW}📝 Creating backend .env file...${NC}"
    cat > "$SCRIPT_DIR/Backend/.env" << EOF
port=8080
dbURL=mongodb://localhost:27017/hms
key=hms_jwt_secret_key_2024
EOF
fi

# Seed the database
echo -e "${YELLOW}🌱 Seeding database...${NC}"
cd "$SCRIPT_DIR/Backend"
node seed.js || true

# Start backend in background
echo -e "${YELLOW}🚀 Starting backend server...${NC}"
cd "$SCRIPT_DIR/Backend"
npm run dev &
BACKEND_PID=$!

# Wait for backend to be ready
echo -n "   Waiting for backend"
for i in {1..30}; do
    if curl -s http://localhost:8080/ &>/dev/null; then
        echo -e " ${GREEN}Ready ✓${NC}"
        break
    fi
    echo -n "."
    sleep 1
done

# Start frontend
echo -e "${YELLOW}🚀 Starting frontend server...${NC}"
cd "$SCRIPT_DIR/FrontEnd"
REACT_APP_API_URL=http://localhost:8080 npm start &
FRONTEND_PID=$!

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗"
echo "║   🎉 All services are starting!            ║"
echo "╠════════════════════════════════════════════╣"
echo "║                                            ║"
echo "║   🌐 Frontend:  http://localhost:3000      ║"
echo "║   🔧 Backend:   http://localhost:8080      ║"
echo "║                                            ║"
echo "╠════════════════════════════════════════════╣"
echo "║   📋 Login Credentials:                    ║"
echo "║                                            ║"
echo "║   Admin  → ID: 100, Password: masai       ║"
echo "║   Doctor → ID: 101, Password: masai       ║"
echo "║   Nurse  → ID: 102, Password: masai       ║"
echo "║                                            ║"
echo "╠════════════════════════════════════════════╣"
echo "║   Press Ctrl+C to stop all services       ║"
echo -e "╚════════════════════════════════════════════╝${NC}"

# Trap Ctrl+C
trap "echo -e '\n${YELLOW}Stopping services...${NC}'; kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit 0" INT

# Wait for processes
wait

