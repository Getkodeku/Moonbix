#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.
cat <<'EOF'

  ____           _   _              __  __
 |  _ \    ___  | | | |_    __ _    \ \/ /
 | | | |  / _ \ | | | __|  / _` |    \  / 
 | |_| | |  __/ | | | |_  | (_| |    /  \ 
 |____/   \___| |_|  \__|  \____|   /_/\_\
 
 
EOF
# Check if python3 and pip3 are installed
if ! command -v python3 &> /dev/null; then
    echo "python3 is not installed. Please install it and try again."
    exit 1
fi

if ! command -v pip3 &> /dev/null; then
    echo "pip3 is not installed. Please install it and try again."
    exit 1
fi

# Check for virtual environment folder
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate

# Check if dependencies are already installed
if [ ! -f "venv/installed" ]; then
    if [ -f "requirements.txt" ]; then
        echo "Installing wheel for faster installations..."
        pip install wheel

        echo "Installing dependencies..."
        pip install -r requirements.txt

        touch venv/installed  # Mark dependencies as installed
    else
        echo "requirements.txt not found, skipping dependency installation."
    fi
else
    echo "Dependencies already installed, skipping installation."
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "Copying configuration file..."
    cp .env-example .env
else
    echo "Skipping .env copying"
fi

echo "Starting the bot..."
python main.py  # Fix the typo here

echo "done"
echo "PLEASE EDIT .ENV FILE IF NECESSARY"
