# 👁️ OmniRecon

**Automated Subdomain Enumeration & Visual Recon Pipeline**

[![Docker](https://img.shields.io/badge/Docker-Supported-blue.svg)](https://www.docker.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Language: Bash](https://img.shields.io/badge/Language-Bash-green.svg)](https://www.gnu.org/software/bash/)

OmniRecon is a streamlined, containerized Bash script that chains together industry-standard Go tools to perform comprehensive attack surface mapping. It handles subdomain discovery, live host verification, and visual reconnaissance automatically.

## 🛠️ Tools Integrated
* **[Subfinder](https://github.com/projectdiscovery/subfinder):** Rapid passive subdomain enumeration.
* **[httpx](https://github.com/projectdiscovery/httpx):** Fast and multi-purpose HTTP toolkit for probing live hosts.
* **[Gowitness](https://github.com/sensepost/gowitness):** Web screenshot utility using headless Chrome.

## 🚀 Quick Start (Docker - Recommended)

The "Pro Move" is running this via Docker to avoid dependency hell.

1. **Build the image:**
   ```bash
   docker build -t omnirecon .
