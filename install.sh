#!/bin/bash

#  usage : installsh [nginx/apache]
WEB_SERVER="$1" 
WEB_ROOT="/var/www/html"
WEB_PAGE="${WEB_ROOT}/index.html"
OS_VERSION=$(uname -a)
PUBLIC_IP=$(curl ifconfig.me)

install_nginx() {
    echo "Installing Nginx..."
    sudo apt update
    sudo apt install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
}

install_apache() {
    echo "Installing Apache..."
    sudo apt update
    sudo apt install -y apache2
    sudo systemctl enable apache2
    sudo systemctl start apache2
}

create_web_page() {
    echo "Creating web page at ${WEB_PAGE}..."
    sudo mkdir -p "${WEB_ROOT}"
    sudo tee "${WEB_PAGE}" > /dev/null <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        h1 {
            font-size: 3.5em;
            margin-bottom: 0.3em;
            color: #2c3e50;
        }
        .os-container {
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
            max-width: 600px;
            text-align: center;
        }
        .os-container p {
            font-size: 1.1em;
            color: #555;
            word-break: break-word;
        }
        footer {
            margin-top: 20px;
            font-size: 0.9em;
            color: #888;
        }
        .highlight {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <h1>Hello World</h1>
    <div class="os-container">
        <p> current OS version is:</p>
        <p class="highlight">${OS_VERSION}</p>
    </div>
    <footer>
        Powered  Powered by ${$1} | AWS EC2 |Bash 
    </footer>
</body>
</html>
EOF
    echo "Web page created successfully."
}

configure_firewall() {
    echo "Configuring UFW firewall to allow HTTP traffic..."
    sudo ufw allow 80/tcp
    sudo ufw reload
    echo "Firewall configuration completed."
}

restart_web_server() {
    echo "Restarting ${WEB_SERVER} to apply changes..."
    sudo systemctl restart "${WEB_SERVER}"
}


echo "Starting the web server ..."
if [ "$WEB_SERVER" == "nginx" ]; then
    install_nginx
elif [ "$WEB_SERVER" == "apache2" ]; then
    install_apache
else
    echo "Unsupported web server: ${WEB_SERVER}. Exiting."
    exit 1
fi

create_web_page
configure_firewall
restart_web_server

echo "Web server setup complete. Access your web page at http://${${PUBLIC_IP}}"
