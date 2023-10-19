#!/bin/bash
declare -A fp

# hello3
# To learn about cron jobs go here
# https://phoenixnap.com/kb/set-up-cron-job-linux

# fp["$HOME/projects"]="projects"
# fp["$HOME/Demos"]="demos"
# fp[$HOME]="usr_dir"
fp["$HOME/Downloads"]="downloads"
# fp["$HOME/Documents"]="documents"

for fp_to in "${!fp[@]}"; do
  sudo mkdir -p /var/local/${fp[$fp_to]}/backups
	sudo chmod +rwx /var/local/${fp[$fp_to]}/backups
	sudo rsync -aruv ${fp_to} /var/local/${fp[$fp_to]}/backups
done


