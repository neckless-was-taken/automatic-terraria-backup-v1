# Automatic Terraria Backup v1
Automatically backs up Terraria worlds and players
## Table of contents
* [General info](#general-info)
* [Features](#features)
* [Installation](#installation)

## General info
The script was written up in batch so the code should be relatively easily understandable, I have added comments where they made sense

* Requires 7zip and Backups and Sync by Google for the archiving feature

## Features:
* Backs up Terraria Worlds and Players (Players can be turned on/off) every 30 minutes
* Zips up and archives last backup made after closing Terraria (uses 7-zip)
* Deletes backups older than x days (determined by user settings)
* Self contained Initial Setup sequence which generates individual user settings (stored in usersettings.cmd)
* Launch Terraria through Steam or your usual shortcut and ATB opens automatically and closes when Terraria is closed
* Opens Backup and Sync by Google together with Terraria and closes when Terraria is closed
* Detects if Terraria.exe has been updated and re-sets it up so it works with ATB

## Installation:
1. Download and install 7-zip in its default location ([Download link](https://www.7-zip.org/ "https://www.7-zip.org/"))
2. Download and install Backup & Sync by Google ([Download link](https://www.google.com/drive/download/ "https://www.google.com/drive/download/"))
3. Download the latest release of ATB and extract the files in your Terraria install folder 
   * To find your Terraria install open up your Steam Library->right-click Terraria->Properties...->Local files->Browse local files...
4. Launch terrariabackup.bat and go through the initial setup
5. After that you can launch Terraria through Steam like normal and ATB will automatically open in the background
