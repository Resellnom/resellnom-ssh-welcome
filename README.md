# ResellNom SSH Welcome

Free, lightweight and customizable SSH login branding for Linux servers.

**GitHub:** https://github.com/Resellnom/resellnom-ssh-welcome  
**Donation ** https://resellnom.com/pay

## Features

- Custom company name
- Company founding year
- Automatic company age
- Current date and time
- Server hostname
- Automatic OS detection
- Support / WhatsApp text
- Website
- No external API
- Lightweight
- Free and open source
- Easy to fork and rebrand

## Supported Linux

Designed for Linux distributions using `/etc/profile.d/`, including:

- CloudLinux
- AlmaLinux
- Rocky Linux
- RHEL
- CentOS / CentOS Stream
- Ubuntu
- Debian
- Fedora

## Quick Install

Clone your fork:

```bash
git clone https://github.com/Resellnom/resellnom-ssh-welcome.git
cd resellnom-ssh-welcome.git
chmod +x install.sh
sudo ./install.sh
```



The installer asks for:

- Company name
- Company since
- Support / WhatsApp
- Support type
- Website
- Footer text

After installation, reconnect to SSH or run:

```bash
bash -l
```

## Example

```text
============================================================
                    RESELLNOM
============================================================

   Welcome to ResellNom

   COMPANY SINCE     : 2021
   COMPANY AGE       : 5 YEARS
   CURRENT DATE      : 12 August 2026
   CURRENT TIME      : 12:05:00 AM

   SUPPORT           : 01336126969
   SUPPORT TYPE      : TEXT ONLY
   WEBSITE           : resellnom.com

------------------------------------------------------------
   SERVER            : server.example.com
   OS                : CloudLinux
------------------------------------------------------------

              RESELLNOM • SINCE 2021
============================================================
```

The company age is calculated automatically from the current year.

## Configuration

The installer stores branding settings in:

```text
/etc/resellnom/config
```

The SSH welcome script is installed at:

```text
/etc/profile.d/resellnom-welcome.sh
```

To change branding later:

```bash
nano /etc/resellnom/config
```

Then log out and log in again.

## Uninstall

```bash
sudo rm -f /etc/profile.d/resellnom-welcome.sh
sudo rm -rf /etc/resellnom
```

## Make Your Own Version

Fork this repository to your own GitHub account.

You can change the:

- Company name
- Company year
- Support number
- Support message
- Website
- Footer
- Terminal design

Then install from your own repository.

This project is intentionally designed so hosting companies and server administrators can create their own branded SSH login screen.

## License

MIT License.

Free to use, modify, fork, redistribute and use commercially.

## Support the Project

If this project is useful to you, you can support development with:

**Donation & Crypto:**  
https://resellnom.com/pay

⭐ Star the repository if you like it.

---

Made by **[@Resellnom](https://github.com/Resellnom)**  
ResellNom — Since 2021
