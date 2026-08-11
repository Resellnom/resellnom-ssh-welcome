# Installation Guide

## 1. Clone the repository

```bash
git clone https://github.com/Resellnom/resellnom-ssh-welcome.git
cd resellnom-ssh-welcome
```

## 2. Make installer executable

```bash
chmod +x install.sh
```

## 3. Run installer

```bash
sudo ./install.sh
```

If you are already logged in as root:

```bash
./install.sh
```

## 4. Enter your branding

Example:

```text
Company name [ResellNom]: My Hosting
Company since [2021]: 2020
Support / WhatsApp [01336126969]: +8801XXXXXXXXX
Support type [TEXT ONLY]: WhatsApp
Website [resellnom.com]: myhosting.com
Footer [RESELLNOM • SINCE 2021]: MY HOSTING • SINCE 2020
```

## 5. Test

```bash
bash -l
```

Or disconnect and reconnect using SSH.

## Direct Install From Your Own Fork

After forking the repository:

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR-USERNAME/YOUR-REPOSITORY/main/install.sh | sudo bash
```

Replace the GitHub username and repository name.

## Uninstall

```bash
sudo rm -f /etc/profile.d/resellnom-welcome.sh
sudo rm -rf /etc/resellnom
```
