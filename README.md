# Nextcloud stack in docker (example setup)
## This stack requires manual configuration (config.php, passwords, ssl, volume paths, etc...) 
If you want to test it quickly: run `prepare.sh` as root (after you check what it does), generate ssl keys and put them to /custom/path/web/ssl in your host system, with names fullchain.pem and privkey.pem
### Features:
- Custom image for nextcloud, based on debian slim
- Flexible and easy to deploy and manage bind-type volumes for persistent data
- Apache in mpm_event mode
- Safe, read only containers with services run as non root user
- Redis and MariaDB
- Easy controll over PHP version
- cron for nextclouds `cron.php` enabled by default
