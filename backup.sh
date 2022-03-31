#!/bin/bash
declare -A fp

# map from current filepath to backup filepath
# fp["$HOME/projects"]="projects"
# fp["$HOME/Demos"]="demos"
# fp[$HOME]="usr_dir"
fp["$HOME/Downloads"]="downloads"
# fp["$HOME/Documents"]="documents"

# for fp_to in "${!fp[@]}"; do
#   sudo mkdir -p /var/local/${fp[$fp_to]}/backups
# 	sudo chmod +rwx /var/local/${fp[$fp_to]}/backups
# 	sudo rsync -aruv ${fp_to} /var/local/${fp[$fp_to]}/backups
# done


#TODO testout the sync backup
# fp["$HOME"]="projects"
# fp["$HOME"]="demos"
# fp[$HOME]="usr_dir"
fp["$HOME/Downloads"]="downloads"
# fp[$HOME]


for fp_to in "${!fp[@]}"; do
	rsync -aruv /var/local/${fp[$fp_to]}/backups/* ${fp_to}
done
