#! /bin/bash 
if [ ! -x /etc/init.d/apache2 ]; then 
echo “Apache não encontrado, iniciando a instalação…”
sudo apt-get update
sudo apt-get install apache2 -y

else 
echo “Você já possui o apache instalado”
fi

sudo mkdir -p /var/www/ifrn/public_html
cd /var/www/ifrn/public_html 
sudo git clone https://github.com/matheusmanuel/site-simples-com-html-e-css-.git
sudo cp -r site-simples-com-html-e-css-/* .
sudo rm -rf site-simples-com-html-e-css- /
cd /etc/apache2/sites-available/
sudo tee ifrn.conf<<EOF

<Virtualhost *:80>
	ServerAdmin admim@ifrn

	ServerName ifrn
	ServerAlias www.ifrn
	DocumentRoot /var/www/ifrn/public_html
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite ifrn.conf

sudo echo “127.0.0.1		ifrn” | sudo tee -a /etc/hosts

sudo /etc/init.d/apache2 restart
sudo /etc/init.d/apache2 status



sudo chmod +x script.sh 
./script.sh

