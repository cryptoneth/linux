# Docker Browser Installer

![Banner](https://img.shields.io/badge/Made%20by-Crypton-blue.svg)  
**A simple Bash script to install Chromium and Firefox in Docker containers with customizable options.**

---

## 📖 About

This script automates the installation of **Chromium** and **Firefox** browsers inside Docker containers. It allows you to set custom usernames, passwords, proxy settings (HTTP/SOCKS5), and RAM limits, making it perfect for lightweight, isolated browser environments.

**Created by:** Crypton  
**Follow me on Twitter:** [@0xCrypton_](https://x.com/0xCrypton_)

---

## ✨ Features

- Installs **Chromium** and **Firefox** with a single command.
- Optional **HTTP** and **SOCKS5** proxy configuration for Chromium.
- Customizable **RAM limits** for each container.
- User-friendly prompts for usernames and passwords.
- Automatically installs Docker if it’s not present.
- Easy uninstallation option.

---

## 🛠️ Prerequisites

- A Linux-based system (e.g., Ubuntu, Debian).
- `curl` installed (for Docker installation).
- Root or sudo privileges (to run Docker commands).

---

## 🚀 Installation

1. **Run the Script**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/cryptoneth/linux/main/browser.sh)
``` 

 Usage
When you run the script, you’ll see this menu:

Select an option:
1) Install Chromium
2) Uninstall Chromium
3) Install Firefox
4) Uninstall Firefox
5) Exit

=================

✨ Option 1: Install Chromium
Steps:

- Enter a username.

- Enter a password (hidden input).

- Choose to configure an HTTP proxy (optional):
Example: http://user:pass@proxy.example.com:8080

- Choose to configure a SOCKS5 proxy (optional):
Example: socks5://user:pass@proxy.example.com:1080

- Set a RAM limit (e.g., 512m, 1g, 2g) or press Enter for default (1g).

Result: Chromium runs on http://<your-ip>:3010.

=================

✨ Option 2: Uninstall Chromium

Stops and removes the Chromium container.

=================

Option 3: Install Firefox
Steps:

-Enter a username.

- Enter a password (hidden input).

- Set a RAM limit (e.g., 512m, 1g, 2g) or press Enter for default (1g).

- Result: Firefox runs on http://<your-ip>:4010.

=================

✨Option 4: Uninstall Firefox
Stops and removes the Firefox container.

=================

✨Option 5: Exit
Closes the script.

=================

!!! Notes
 
Ensure your system has enough RAM if you set high limits.


Proxy URLs must be valid; the script doesn’t validate them.


Run as root or with sudo if Docker requires it.

🚀🚀🚀🚀

Made with  by ***Crypton***
Follow me on Twitter: @0xCrypton_
