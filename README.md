# Automatic Terraria Backup v1
Automatically backs up Terraria worlds and characters

## Table of contents
* [General info](#general-info)
* [Features](#features)
* [Setup & Uninstalling](#setup-and-uninstalling)
* [Google Drive setup](#google-drive-setup)

## General info
As most of us know, Terraria can sometimes crash or be closed in the wrong moments, which leads to corrupted save files.  
Obviously backing up your save files is a good idea and would somewhat negate a corrupted save file, but sometimes you can forget or just might be feeling lazy.  
This happened to me and my friend on our multiplayer world, so I decided to write up this script that does the backing up automatically (hence the name) and have now made it easy to set up so, I have decided to upload it here.  

The script is in batch so the source code should be relatively easy to understand, I have added comments where they made sense  
**Note** that one of the files (minstart) has to be an exe for the script to function properly as it replaces Terraria.exe. Anyway, the source code is also available here, just thought it's worth mentioning specifically.

## Features:
* Backs up Terraria Worlds and Players (backup for Players can be turned on/off) every 30 minutes
* Zips up and archives last backup made after closing Terraria
  * **Requires 7zip and Backup and Sync by Google for the archiving feature**
* Deletes backups older than x days (determined by user settings)
* Initial Setup sequence which generates individual user settings (stored in usersettings.cmd)
* Launch Terraria through Steam or your usual shortcut and ATB opens automatically and closes when Terraria is closed
* Opens Backup and Sync by Google together with Terraria and closes when Terraria is closed

## Setup and Uninstalling:
1. Download and install 7-zip in its default location ([Download link](https://www.7-zip.org/ "https://www.7-zip.org/"))
2. Download and install Backup & Sync by Google ([Download link](https://www.google.com/drive/download/ "https://www.google.com/drive/download/"))
3. Download the [latest release](https://github.com/neckless-was-taken/automatic-terraria-backup-v1/releases/latest) of ATB and extract the files in your Terraria install folder 
   * To find your Terraria install open up your Steam Library->right-click Terraria->Properties...->Local files->Browse local files...
4. Launch terrariabackup.bat and go through the initial setup
5. After that you can launch Terraria through Steam like you normally would and ATB will automatically launch in the background
6. To **uninstall** ATB navigate to your Terraria install directory and launch atbunins.bat

## Google Drive setup:
To set up your Backup & Sync by Google so it uploads your archived backups to your Google Drive all you need to do is:
1. Install it & Login
2. Left-click the System Tray icon, click on the three dots and click on Preferences...
3. Under "My Computer" click on "CHOOSE FOLDER" and select the folder where your archived backups are
4. Then you'll find your backups in your Google Drive->Computers->My Computer->Archived ([Screenshot](https://i.imgur.com/Exl4sTk.png))
