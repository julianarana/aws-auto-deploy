echo "Kill all the running PM2 actions"
pm2 -h

echo "Run new PM2 action"
pm2 start /var/www/my-app/index.js