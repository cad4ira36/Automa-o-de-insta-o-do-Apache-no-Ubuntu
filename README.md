# 1) Primeiramente é necessário dar criar um arquivo, nomea-lo e logo após dar permissão para que ele possa ser ativido.

#! /bin/bash 
# 2) A principío o script precisa saber que o Apache já está instalado na máquina, portanto deve ser criada uma "pergunta" para saber se é necessário ou não a instalação do Apache na máquina.
if [ ! -x /etc/init.d/apache2 ]; then 
echo “Apache não encontrado, iniciando a instalação…”
sudo apt-get update
sudo apt-get install apache2 -y

else 
echo “Você já possui o apache instalado”
fi
# 3) Caso seja necesário a instalação do Apache na máquina, deve ser criado um arquivo onde vai estar inserido o instalador do Apache na máquina e onde ele será instalado.

sudo mkdir -p /var/www/ifrn/public_html
cd /var/www/ifrn/public_html 
sudo git clone https://github.com/matheusmanuel/site-simples-com-html-e-css-.git
sudo cp -r site-simples-com-html-e-css-/* .
sudo rm -rf site-simples-com-html-e-css- /
cd /etc/apache2/sites-available/
sudo tee ifrn.conf<<EOF
# 4) Agora vamos escrever os script propriamente dito logo abaixo.
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

# 5) Aqui finalizamos toda a parte do script.
# 6) Em seguida executamos o script e é finalizado o processo.
sudo chmod +x script.sh 
./script.sh


