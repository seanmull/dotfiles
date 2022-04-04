#!/bin/bash
declare -A fp

# Recovery does not flatten file
# fp["$HOME"]="projects"
# fp["$HOME"]="demos"
# fp["$HOME"]="usr_dir"
fp["$HOME"]="downloads"
# fp[$HOME]


for fp_to in "${!fp[@]}"; do
	rsync -aruv /var/local/${fp[$fp_to]}/backups/* ${fp_to}
done
