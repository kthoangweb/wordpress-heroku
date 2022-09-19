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
	git clone https://github.com/kevinoid/postgresql-for-wordpress.git /tmp/
	mv /tmp/postgresql-for-wordpress/pg4wp $HOME/web/wp/wp-content/
	cp $HOME/web/wp/wp-content/pg4wp/db.php $HOME/web/wp/wp-content/db.php

	# wordpress: install
	vendor/bin/wp core install --url="$wp_url" --title="$wp_title" --admin_user="$wp_user" --admin_password="$wp_password" --admin_email="$wp_email"
fi
