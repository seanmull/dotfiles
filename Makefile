backup:
	sudo mkdir -p /var/local/projects/backups
	sudo chmod +rwx /var/local/projects/backups
	sudo rsync -aruv ~/projects /var/local/projects/backups


restore:
	rsync -aruv var/local/Projects/backups/* ~/projects 
