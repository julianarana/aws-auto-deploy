# aws-auto-deploy

Intended to be a configuration to deploy easily from github into AWS EC2 instances

## AWS Preconditions and configurations

### AWS Configuration

#### Create an EC2 Instance.

1. Create a AWS EC2 Instance. For the purpose of running the project it can be a `t1.micro` instance running `ubuntu`
2. Create the SSH keys and store them in a secure please
3. Depending on the project the Ports allowed should be properly configured in the Security Groups sections. In the case of this project we're enabling ports 80 (HTTP) and 443 (HTTPS)..
4. Configure an Elastic IP Address.

#### Install ngnix

1. Access the Created instance through SSH using the keys created in the previous section.
    1. Open the SSH Client
    2. Make sure to `chmod 400 key.pem`
    3. Connect to the instance running `ssh -i "key.pem" ubuntu@<host>.compute.amazonaws.com`
2. Install Ngnin
    1. Once on the server type 
    ```
        sudo apt update
        sudo apt install nginx
    ```
    2. Allow incoming http and https connections
        `sudo ufw allow 'Nginx Full`
    3. Check the status of the server
         `systemctl status nginx`
3. Configure ngnix to forward the connections from port 80 to port 3000
    1. Create a new configuration file for ngnix using `sudo nano /etc/nginx/sites-available/my-app`
    2. Paste the configuration file content of this project called  `nginx.config`
    3. Create a symlink  into sites-enabled directory `sudo ln -s /etc/nginx/sites-available/my-app /etc/nginx/sites-enabled`
    4. Restart nginx `sudo systemctl restart nginx`
4. Setup project in ngnix server
    1. `sudo mkdir /var/www/my-app` and give permissions `sudo chown www-data:www-data /var/www/my-app` `sudo chmod -R 775 /var/www` and add to the correct group `sudo usermod -a -G www-data [my username]`
5. Install Node and pm2
    1. `Download nvm curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bashnv`
    2. `source ~/.profile`
    3. Install proper version `nvm install 14`
    4. Install `pm2 globally npm install pm2 -g`
6. Deploy github actions.
    1. Add the SSH private key into the Github secrets. This file will be used in the following steps to open the connection from Github to AWS.
    2. Add the deploy.yml file the proper configurations. The file should be located at `.github/workflows`
7. Run pm2 in watch mode in the server `pm2 start /var/www/my-app/dist/index.js start --watch`

## References
* [Node.js app continuous deployment with AWS, PM2, and Github Actions.](https://itnext.io/node-js-app-continuous-deployment-with-aws-pm2-and-github-actions-69a30ca29e9e)

* [Deploy your Node App to EC2 with Github Actions](https://dev.to/stretch0/deploy-your-node-app-to-ec2-with-github-actions-h9a)
* [Deploy your (Node.JS) app to AWS EC2 with GitHub Actions](https://blog.devops.dev/deploy-your-node-js-app-to-aws-ec2-with-github-actions-edec5ef1e694)


## Running the project

### Install dependencies
The prefered package manager is yarn. Install it  `npm i -g yarn`

### Install dependencies

Run  `yarn install`

### Run the project

In the command line type `yarn start`



