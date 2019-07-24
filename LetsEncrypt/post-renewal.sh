#!/bin/sh

# Post renewal hook for installing renewed let's encrypt certificates
# Original script from David Nahodyl contact@bluefeathergroup.com
# Edited by Goetch Stone gstone@saybrookhome.com
# https://certbot.eff.org/docs/using.html?highlight=renew#certbot-commands
# Tested only on FMS 18 as of 7-24-2019
# For RENEWALS only


# Set the Domain and the Server Path "Example.com" and "/Library/FileMaker Server/CStore/"

DOMAIN = ""
SERVER_PATH=""

# copy the let's encrypt certificates to the FileMaker CStore directory

cp "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" "${SERVER_PATH}fullchain.pem"
cp "/etc/letsencrypt/live/${DOMAIN}/privkey.pem" "${SERVER_PATH}privkey.pem"

chmod 640 "${SERVER_PATH}privkey.pem"

# Move Old Cert if there is one to prevent an error

mv "${SERVER_PATH}serverKey.pem" "${SERVER_PATH}serverKey-old.pem"

# Remove the old certificate

/usr/local/bin/fmsadmin certificate delete -y -u <fmsadmin> -p <fmsadminpassword>

# Install the new certificate 

/usr/local/bin/fmsadmin certificate import -y -u <fmsadmin> -p <fmsadminpassword> "${SERVER_PATH}fullchain.pem" --keyfile "${SERVER_PATH}privkey.pem"

# Stop FMS

launchctl stop com.filemaker.fms

# Wait 15 seconds for FMS to stop

sleep 15s

# Start FMS 

launchctl start com.filemaker.fms

exit 0
