#!/bin/bash

PAGES=(
Mario_return_to_dreamland
Tutorials/NSMBW
New_Super_Mario_Bros._Wii
Hacking_Resources
NSMB_Hacking_Resources
NSMBW_Custom_Tileset_XML
Patch_template
Smash_Mods
Wii_Optical_Disc
Dead_Space_Extraction_Spanish
Skins/SSBB
Riivolution_Schema
Brawl+_Server
Most_Popular_NSMB_Levels
RiiFS
Featured_NSMB_Levels
List_of_RiiFS_servers
Network
Riivolution
Hacks
List_of_hacks
Media
YouTube
Patch_Format
Patch_Templates
Ocarina_Codes
Frequently_Asked_Questions
Main_Page
)

mkdir -p export/
for page in "${PAGES[@]}"; do
	PAGE="$(echo "$page" | cut -d: -f1)"
	TITLE="$(echo "$page" | tr "_" " ")"
	FILENAME="export/$(echo "$PAGE" | tr "/" "_")"
	{
		cat <<EOF
---
title: $TITLE
permalink: wiki/$PAGE/
layout: wiki
---
EOF
		curl -vvv "http://rvlution.net/wiki/$PAGE?action=render"
	} > "$FILENAME.html"
	sed -i -e 's|http://rvlution.net/wiki/|../|g' -e 's|http://rvlution.net||g' -e 's|/riivolution/images/./../|../|g' "$FILENAME.html"
done
cat > wiki/FAQ.html <<EOF
---
title: FAQ
permalink: wiki/FAQ/
redirect_to:
- /wiki/Frequently_Asked_Questions/
---
EOF
cat > wiki/index.html <<EOF
---
title: Riivolution
permalink: wiki/
redirect_to:
- /wiki/Main_Page/
---
EOF
