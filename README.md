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
2. Run the pipeline:
(Mounts your current directory to save the output results locally)
```bash
   docker run --rm -v $(pwd):/app/results omnirecon -d target.com
```
3. 💻 Manual Installation
If you prefer to run it bare-metal, ensure you have Go 1.21+ installed and the required tools in your $PATH.
```bash
   git clone https://github.com/JrBlackRose/OmniRecon.git
   cd OmniRecon
   chmod +x run_recon.sh
   ./run_recon.sh -d target.com -w wordlists/custom_subdomains.txt
```
4. 📂 Output Structure
Upon completion, OmniRecon generates a timestamped directory containing:

 - subdomains.txt - All discovered subdomains.

 - live_hosts.txt - Subdomains responding on ports 80/443 with status codes.

 - urls.txt - Cleaned list of live URLs.

 - /screenshots/ - PNG captures of every live web application.



⚠️ Disclaimer
This tool is for educational purposes and authorized security testing only. Do not use this against systems you do not own or have explicit permission to test.
### 5. Final Setup Steps

1.  Initialize a Git repository: `git init`
2.  Add an MIT `LICENSE` file (standard for open source).
3.  Commit these files and push to a clean GitHub repository.

By framing this project with clean code, modern containerization, and a highly polished README, you turn a simple Bash script into a compelling, professional engineering artifact.
