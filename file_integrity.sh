#!/bin/bash

# Hash-Watch – File Integrity Checker
# Project Members: Mariama E. Darboe & Omar E. Touray

baseline="baseline.md5"
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"  # No Color

# Function to display usage instructions
show_help() {
    echo -e "${GREEN}Hash-Watch: File Integrity Checker${NC}"
    echo "Usage: $0 [--init|--check|--help] [directory]"
    echo ""
    echo "Options:"
    echo " --init ->  Initialize baseline hashes in specified directory (default: /etc)"
    echo " --check ->  Compare current hashes with baseline"
    echo " --help, -h ->  Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --init /etc"
    echo "  $0 --check /etc"
}

# Function to initialize baseline
init_mode() {
    local dir=$1
    echo -e "${GREEN}[*] Initializing baseline in $dir...${NC}"
    md5sum "$dir"/* > "$baseline" 2>/dev/null
    echo -e "${GREEN}[OK] Baseline stored in $baseline${NC}"
}

# Function to check integrity
check_mode() {
    local dir=$1
    if [[ ! -f $baseline ]]; then
        echo -e "${RED}[!] Baseline file $baseline not found. Run --init first.${NC}"
        exit 1
    fi
    echo -e "${GREEN}[*] Checking for file changes in $dir...${NC}"
    md5sum -c "$baseline" 2>/dev/null | grep -v ": OK" || echo -e "${GREEN}[OK] No changes detected.${NC}"
}


# Main Section

mode=$1
dir=${2:-/etc}

case $mode in
    --init)
        init_mode "$dir"
        ;;
    --check)
        check_mode "$dir"
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}[!] Invalid option: $mode${NC}"
        show_help
        exit 1
        ;;
esac
