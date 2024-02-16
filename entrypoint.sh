#!/bin/bash

#modify to env var -> dockerfile
WORKDIR=/RWTServer

start() {
    CURRENTVERSION=$(cat $WORKDIR/rwtversion)
    echo "Starting Rimworld Together game server v."$CURRENTVERSION"..."
# CHANGER ÇA POUR EXPECT et permettre des auto-interractions ?
    exec ./GameServer
}

cleanup(){
    echo "Exiting..."
# Add logic to catch server exit and offer either to start, update, delete save or exit.
}

update() {

# Fetch local and source versions
    CURRENTVERSION=$(cat rwtversion)
    LATESTVERSION=$(curl --silent "https://api.github.com/repos/Byte-Nova/Rimworld-Together/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Skip if up to date
    if [ "$CURRENTVERSION" == "$LATESTVERSION" ]; then
        echo "Server is already running the latest version. (v."$CURRENTVERSION")"
    else
        echo "Server is currently running v.$CURRENTVERSION./n    Starting update to $LATESTVERSION..."

# Backup current installation
        if [ "$CURRENTVERSION" != "null" ]; then tar --exclude=Backups -czf Backups/$LATESTVERSION$( date '+_%F_%H:%M' ).tar.gz .; fi

#Download, extract, install and note Latest Version
        curl -LJO "https://github.com/Byte-Nova/Rimworld-Together/releases/download/$LATESTVERSION/Linux-x64.zip"
        wait
        unzip -o Linux-x64.zip
        chmod +x GameServer
        echo $LATESTVERSION > rwtversion
        rm Linux-x64.zip
        echo "    Update to v.$LATESTVERSION completed!"
    fi
}

trap 'cleanup' EXIT

cd $WORKDIR

if [ ! -e rwtversion ]; then
    touch rwtversion && echo null > rwtversion
    mkdir Backups
    update

# Could be reworked as an expect script
    start & sleep 3
    echo "quit" > /proc/$$/fd/0
    wait
#Include required Core and DLC files
    curl -LJO "https://github.com/Byte-Nova/Rimworld-Together/raw/development/Extras.zip"
    unzip -o Extras.zip -d ./Mods/Required
    mv ./Mods/Required/DLCs/Ideology ./Mods/Required/DLCs/Biotech ./Mods/Required/DLCs/Royalty ./Mods/Required/
    rm -r Extras.zip ./Mods/Required/DLCs

    start
else
    start
fi
