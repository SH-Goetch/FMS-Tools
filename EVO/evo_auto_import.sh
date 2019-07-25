#!/bin/bash

# Calls POSIM EVO's Unattended Import Feature

# Set the Path for the Import 

IMPORT_PATH="/Library/FileMaker Server/Data/Documents/Evo/"

cd "/Applications/POSIM EVO.app/Contents/Java/" && ./java -jar Juniper.jar --import $IMPORT_PATH
