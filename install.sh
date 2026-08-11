#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="/etc/resellnom"
CONFIG_FILE="$CONFIG_DIR/config"
WELCOME_FILE="/etc/profile.d/resellnom-welcome.sh"

if [[ $EUID -ne 0 ]]; then
  echo "Please run this installer as root."
  exit 1
fi

echo
echo "============================================================"
echo "              ResellNom SSH Welcome Installer"
echo "============================================================"
echo

mkdir -p "$CONFIG_DIR"

# Defaults
COMPANY_NAME="ResellNom"
COMPANY_SINCE="2021"
SUPPORT="01336126969"
SUPPORT_TYPE="TEXT ONLY"
WEBSITE="resellnom.com"
FOOTER="RESELLNOM • SINCE 2021"

read -r -p "Company name [${COMPANY_NAME}]: " v; COMPANY_NAME="${v:-$COMPANY_NAME}"
read -r -p "Company since [${COMPANY_SINCE}]: " v; COMPANY_SINCE="${v:-$COMPANY_SINCE}"
read -r -p "Support / WhatsApp [${SUPPORT}]: " v; SUPPORT="${v:-$SUPPORT}"
read -r -p "Support type [${SUPPORT_TYPE}]: " v; SUPPORT_TYPE="${v:-$SUPPORT_TYPE}"
read -r -p "Website [${WEBSITE}]: " v; WEBSITE="${v:-$WEBSITE}"
read -r -p "Footer [${FOOTER}]: " v; FOOTER="${v:-$FOOTER}"

cat > "$CONFIG_FILE" <<EOF
COMPANY_NAME=$(printf '%q' "$COMPANY_NAME")
COMPANY_SINCE=$(printf '%q' "$COMPANY_SINCE")
SUPPORT=$(printf '%q' "$SUPPORT")
SUPPORT_TYPE=$(printf '%q' "$SUPPORT_TYPE")
WEBSITE=$(printf '%q' "$WEBSITE")
FOOTER=$(printf '%q' "$FOOTER")
EOF

chmod 644 "$CONFIG_FILE"

cat > "$WELCOME_FILE" <<'EOF'
#!/usr/bin/env bash

CONFIG_FILE="/etc/resellnom/config"

[[ -r "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

: "${COMPANY_NAME:=ResellNom}"
: "${COMPANY_SINCE:=2021}"
: "${SUPPORT:=01336126969}"
: "${SUPPORT_TYPE:=TEXT ONLY}"
: "${WEBSITE:=resellnom.com}"
: "${FOOTER:=RESELLNOM • SINCE 2021}"

# Only show in interactive terminals.
[[ $- == *i* ]] || return 0 2>/dev/null || exit 0

CURRENT_YEAR="$(date +%Y)"
if [[ "$COMPANY_SINCE" =~ ^[0-9]{4}$ ]] && (( CURRENT_YEAR >= COMPANY_SINCE )); then
    COMPANY_AGE=$((CURRENT_YEAR - COMPANY_SINCE))
else
    COMPANY_AGE="N/A"
fi

HOSTNAME_VALUE="$(hostname 2>/dev/null || echo "server")"

if [[ -r /etc/os-release ]]; then
    source /etc/os-release
    OS_NAME="${PRETTY_NAME:-${NAME:-Linux}}"
else
    OS_NAME="$(uname -s)"
fi

# Avoid duplicate banner if the profile is sourced more than once.
if [[ "${RESELLNOM_WELCOME_SHOWN:-0}" == "1" ]]; then
    return 0 2>/dev/null || exit 0
fi
export RESELLNOM_WELCOME_SHOWN=1

BOLD=""
RESET=""
if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
    BOLD="$(tput bold 2>/dev/null || true)"
    RESET="$(tput sgr0 2>/dev/null || true)"
fi

printf '\n'
printf '%s============================================================%s\n' "$BOLD" "$RESET"
printf '%s                    %s%s\n' "$BOLD" "$COMPANY_NAME" "$RESET"
printf '%s============================================================%s\n' "$BOLD" "$RESET"
printf '\n'
printf '   Welcome to %s\n' "$COMPANY_NAME"
printf '\n'
printf '   COMPANY SINCE     : %s\n' "$COMPANY_SINCE"
printf '   COMPANY AGE       : %s YEARS\n' "$COMPANY_AGE"
printf '   CURRENT DATE      : %s\n' "$(date '+%d %B %Y')"
printf '   CURRENT TIME      : %s\n' "$(date '+%I:%M:%S %p %Z')"
printf '\n'
printf '   SUPPORT           : %s\n' "$SUPPORT"
printf '   SUPPORT TYPE      : %s\n' "$SUPPORT_TYPE"
printf '   WEBSITE           : %s\n' "$WEBSITE"
printf '\n'
printf '%s------------------------------------------------------------%s\n' "$BOLD" "$RESET"
printf '   SERVER            : %s\n' "$HOSTNAME_VALUE"
printf '   OS                : %s\n' "$OS_NAME"
printf '%s------------------------------------------------------------%s\n' "$BOLD" "$RESET"
printf '\n'
printf '              %s\n' "$FOOTER"
printf '%s============================================================%s\n' "$BOLD" "$RESET"
printf '\n'
EOF

chmod 755 "$WELCOME_FILE"

echo
echo "Installation completed."
echo "Configuration: $CONFIG_FILE"
echo "Welcome script: $WELCOME_FILE"
echo
echo "Test now with:"
echo "  bash -l"
echo
