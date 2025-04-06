#!/bin/bash

# Signature
echo "--------------------------------------------------"
echo "This script was created by Crypton."
echo "Please follow me on Twitter: https://x.com/0xCrypton_"
echo "--------------------------------------------------"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed."
    read -p "Press Enter to install Docker..."
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    echo "Docker installed successfully."
else
    echo "Docker is already installed."
fi

# Function to install Chromium
install_chromium() {
    if docker ps -a | grep -q chromium; then
        echo "Chromium is already installed."
    else
        read -p "Enter username for Chromium: " USERNAME
        read -sp "Enter password for Chromium: " PASSWORD
        echo

        # Proxy configuration (optional)
        read -p "Do you want to configure an HTTP proxy? (y/n): " HTTP_PROXY_CHOICE
        HTTP_PROXY=""
        if [[ "$HTTP_PROXY_CHOICE" =~ ^[Yy]$ ]]; then
            read -p "Enter HTTP proxy (e.g., http://proxy.example.com:1080): " HTTP_PROXY
        fi

        read -p "Do you want to configure a SOCKS5 proxy? (y/n): " SOCKS5_PROXY_CHOICE
        SOCKS5_PROXY=""
        if [[ "$SOCKS5_PROXY_CHOICE" =~ ^[Yy]$ ]]; then
            read -p "Enter SOCKS5 proxy (e.g., socks5://proxy.example.com:1080): " SOCKS5_PROXY
        fi

        # Build CHROME_CLI based on proxy input
        CHROME_CLI="https://google.com"  # Default URL
        if [[ -n "$HTTP_PROXY" && -n "$SOCKS5_PROXY" ]]; then
            echo "Warning: Both HTTP and SOCKS5 proxies provided. Using HTTP proxy only."
            CHROME_CLI="--proxy-server=$HTTP_PROXY https://google.com"
        elif [[ -n "$HTTP_PROXY" ]]; then
            CHROME_CLI="--proxy-server=$HTTP_PROXY https://google.com"
        elif [[ -n "$SOCKS5_PROXY" ]]; then
            CHROME_CLI="--proxy-server=$SOCKS5_PROXY https://google.com"
        fi

        echo "Installing Chromium..."
        docker run -d \
            --name=chromium \
            --security-opt seccomp=unconfined `#optional` \
            -e PUID=1000 \
            -e PGID=1000 \
            -e TZ=Europe/Berlin \
            -e CUSTOM_USER="$USERNAME" \
            -e PASSWORD="$PASSWORD" \
            -e CHROME_CLI="$CHROME_CLI" \
            -p 3010:3000 \
            -p 3011:3001 \
            -v /root/chromium/config:/config \
            --shm-size="1gb" \
            --restart unless-stopped \
            lscr.io/linuxserver/chromium:latest
        echo "------------------------------------------------------------------------------------------------"
        echo "Chromium installed successfully."
        IP=$(hostname -I | awk '{print $1}')
        echo " "
        echo "Use browser with http://$IP:3010"
    fi
}

# Function to uninstall Chromium
uninstall_chromium() {
    if docker ps -a | grep -q chromium; then
        echo "Uninstalling Chromium..."
        docker stop chromium
        docker rm chromium
        echo "Chromium uninstalled."
    else
        echo "Chromium is not installed."
    fi
}

# Function to install Firefox
install_firefox() {
    if docker ps -a | grep -q firefox; then
        echo "Firefox is already installed."
    else
        read -p "Enter username for Firefox: " USERNAME
        read -sp "Enter password for Firefox: " PASSWORD
        echo
        echo "Installing Firefox..."
        docker run -d \
            --name=firefox \
            --security-opt seccomp=unconfined `#optional` \
            -e PUID=1000 \
            -e PGID=1000 \
            -e TZ=Etc/UTC \
            -e CUSTOM_USER="$USERNAME" \
            -e PASSWORD="$PASSWORD" \
            -p 4010:3000 \
            -p 4011:3001 \
            -v /root/firefox/config:/config \
            --shm-size="1gb" \
            --restart unless-stopped \
            lscr.io/linuxserver/firefox:latest
        echo "------------------------------------------------------------------------------------------------"
        echo "Firefox installed successfully."
        IP=$(hostname -I | awk '{print $1}')
        echo " "
        echo "Use browser with http://$IP:4010"
    fi
}

# Function to uninstall Firefox
uninstall_firefox() {
    if docker ps -a | grep -q firefox; then
        echo "Uninstalling Firefox..."
        docker stop firefox
        docker rm firefox
        echo "Firefox uninstalled."
    else
        echo "Firefox is not installed."
    fi
}

# Display the menu
echo "Select an option:"
echo "1) Install Chromium"
echo "2) Uninstall Chromium"
echo "3) Install Firefox"
echo "4) Uninstall Firefox"
echo "5) Exit"
read -p "Please choose: " choice

case $choice in
    1) install_chromium ;;
    2) uninstall_chromium ;;
    3) install_firefox ;;
    4) uninstall_firefox ;;
    5) exit ;;
    *) echo "Invalid choice. Please select a valid option." ;;
esac
