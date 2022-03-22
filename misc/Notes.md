Try to get vimspector JSON to be globally accessable

Make list of folders to backup
- Projects
- Demos
- Documents
- Downloads

To backup
rsync -aruv ~/projects /var/local/projects/backups > /var/local/Projects/backups/backup.log


To restore
rsync -aruv var/local/Projects/backups/* ~/projects 

