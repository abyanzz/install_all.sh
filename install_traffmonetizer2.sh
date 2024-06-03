#!/bin/bash

# Function to install Docker if not already installed
install_docker() {
  if ! [ -x "$(command -v docker)" ]; then
    echo "Docker not found, installing..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
  else
    echo "Docker is already installed."
  fi
}

# Install Docker
install_docker

# Pull the Traffmonetizer CLI image
docker pull traffmonetizer/cli_v2

# Your token
TOKEN="kKo6rC6UDnE3thQMxCZ3lL6/XojlIRIcXyG15TjeVd0="

# Function to run Traffmonetizer CLI without proxy
run_without_proxy() {
  docker run -d --restart unless-stopped traffmonetizer/cli_v2 start accept --token "$TOKEN"
}

# Function to run Traffmonetizer CLI with HTTP proxy
run_with_http_proxy() {
  local proxy=$1
  docker run -d --restart unless-stopped -e HTTP_PROXY="http://$proxy" traffmonetizer/cli_v2 start accept --token "$TOKEN"
}

# Function to run Traffmonetizer CLI with SOCKS5 proxy
run_with_socks5_proxy() {
  local proxy=$1
  docker run -d --restart unless-stopped -e ALL_PROXY="socks5://$proxy" traffmonetizer/cli_v2 start accept --token "$TOKEN"
}

# Example HTTP proxies (add more if needed)
HTTP_PROXIES=(
  "45.195.80.59:5432;dmqkq;tjwpatm9"
  "another_http_proxy:port;user;password"
  "yet_another_http_proxy:port;user;password"
)

# Example SOCKS5 proxies (add more if needed)
SOCKS5_PROXIES=(
  "51.68.164.77:19159"
  "148.113.1.131:1080"
  "23.19.244.109:1080"
  "220.90.95.129:56452"
  "211.223.89.176:51147"
)

# Run without proxy (adjust as needed)
# run_without_proxy

# Combine all proxies into one array
ALL_PROXIES=("${HTTP_PROXIES[@]}" "${SOCKS5_PROXIES[@]}")

# Run with each proxy
for proxy in "${ALL_PROXIES[@]}"; do
  if [[ "$proxy" == *";"* ]]; then
    # Split the proxy string into components
    IFS=';' read -r -a proxy_parts <<< "$proxy"
    proxy_url="${proxy_parts[0]}"
    proxy_user="${proxy_parts[1]}"
    proxy_pass="${proxy_parts[2]}"
    
    # Construct proxy string
    if [ -n "$proxy_user" ] && [ -n "$proxy_pass" ]; then
      full_proxy="${proxy_user}:${proxy_pass}@${proxy_url}"
    else
      full_proxy="$proxy_url"
    fi
    
    run_with_http_proxy "$full_proxy"
  else
    run_with_socks5_proxy "$proxy"
  fi
done

echo "Traffmonetizer CLI setup complete."
