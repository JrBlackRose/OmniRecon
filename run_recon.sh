#!/bin/bash
# OmniRecon - Automated Subdomain Enumeration & Visual Recon Pipeline
# Requires: subfinder, httpx, gowitness

set -e # Exit immediately if a command exits with a non-zero status

# --- Color Definitions ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Usage Function ---
usage() {
    echo -e "${YELLOW}Usage: $0 -d <domain> [-w <wordlist>]${NC}"
    echo "  -d    Target domain (e.g., example.com)"
    echo "  -w    Optional: Custom wordlist for brute-forcing (Path)"
    exit 1
}

# --- Parse Arguments ---
while getopts "d:w:" opt; do
  case ${opt} in
    d ) TARGET=$OPTARG ;;
    w ) WORDLIST=$OPTARG ;;
    \? ) usage ;;
  esac
done

if [ -z "$TARGET" ]; then
    echo -e "${RED}[!] Target domain is required.${NC}"
    usage
fi

# --- Setup Output Directories ---
OUT_DIR="results_${TARGET}_$(date +%F)"
mkdir -p "$OUT_DIR/screenshots"

echo -e "${GREEN}[*] Starting OmniRecon pipeline for: $TARGET${NC}"
echo -e "${GREEN}[*] Results will be saved in: $OUT_DIR${NC}"

# --- Step 1: Subdomain Enumeration ---
echo -e "${YELLOW}[+] Step 1: Discovering Subdomains (Subfinder)...${NC}"
subfinder -d "$TARGET" -silent > "$OUT_DIR/subdomains.txt"

# Optional: Add custom wordlist brute-forcing if provided
if [ -n "$WORDLIST" ] && [ -f "$WORDLIST" ]; then
    echo -e "${YELLOW}[+] Appending custom wordlist results...${NC}"
    # (Assuming a tool like puredns or custom bash logic here. For simplicity, we just echo)
    echo -e "${GREEN}[*] Note: Custom wordlist brute-forcing logic would execute here using $WORDLIST${NC}"
fi

DOMAIN_COUNT=$(wc -l < "$OUT_DIR/subdomains.txt")
echo -e "${GREEN}[+] Found $DOMAIN_COUNT unique subdomains.${NC}"

# --- Step 2: Live Host Probing ---
echo -e "${YELLOW}[+] Step 2: Probing for live web servers (httpx)...${NC}"
cat "$OUT_DIR/subdomains.txt" | httpx -silent -ports 80,443 -title -status-code > "$OUT_DIR/live_hosts.txt"

# Extract just the URLs for the next step
cat "$OUT_DIR/live_hosts.txt" | awk '{print $1}' > "$OUT_DIR/urls.txt"

LIVE_COUNT=$(wc -l < "$OUT_DIR/urls.txt")
echo -e "${GREEN}[+] Found $LIVE_COUNT live web servers.${NC}"

# --- Step 3: Visual Reconnaissance ---
echo -e "${YELLOW}[+] Step 3: Capturing Screenshots (Gowitness)...${NC}"
gowitness file -f "$OUT_DIR/urls.txt" -d "$OUT_DIR/screenshots"

echo -e "${GREEN}[*] OmniRecon pipeline completed successfully! Check the $OUT_DIR directory.${NC}"
