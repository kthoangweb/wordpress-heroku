#!/usr/bin/env bash
cd $HOME

# only for auto deployments or as soon as labs / heroku env becomes available in app.json
if [ ! -z "$HEROKU_APP_NAME" ]; then

	# wordpress: values
	wp_url="$(echo $HEROKU_APP_NAME).herokuapp.com"
	wp_title="WordPress Heroku"
	wp_user="admin"
	wp_password=$(dd if=/dev/urandom bs=1 count=16 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev)
	wp_email="github@philippheuer.me"

	# install pg4wp
	git clone https://github.com/kevinoid/postgresql-for-wordpress.git /tmp/postgresql-for-wordpress
	mv /tmp/postgresql-for-wordpress/pg4wp $HOME/web/wp/wp-content/
	cp $HOME/web/wp/wp-content/pg4wp/db.php $HOME/web/wp/wp-content/db.php
	
	echo -e "> install my plugins"
	cd $HOME/web/app/plugins/
	wget -O bck.zip https://downloads.wordpress.org/plugin/bck-tu-dong-xac-nhan-thanh-toan-chuyen-khoan-ngan-hang.2.0.1.zip;
	wget -O qh-testpay.zip https://downloads.wordpress.org/plugin/qh-testpay.1.0.2.zip;
	wget -O thanh-toan-chuyen-khoan.zip https://downloads.wordpress.org/plugin/thanh-toan-chuyen-khoan.1.0.0.zip
	wget -O thanh-toan-qrcode.zip https://downloads.wordpress.org/plugin/thanh-toan-qrcode.1.2.1.zip
	wget -O wp2speed.zip https://downloads.wordpress.org/plugin/wp2speed.1.0.1.zip
	
	LANG=en_US.utf8 unzip -O UTF-8 -qo \*.zip
	rm *.zip

	# wordpress: install
	vendor/bin/wp core install --url="$wp_url" --title="$wp_title" --admin_user="$wp_user" --admin_password="$wp_password" --admin_email="$wp_email"
fi
