<?php
if (!empty(getenv('DATABASE_URL'))) {
	$env = parse_url(getenv('DATABASE_URL'));
	putenv(sprintf('DB_HOST=%s', $env['host']));
	if (array_key_exists('port', $env)) {
        putenv(sprintf('DB_PORT=%s', $env['port']));
    }
    putenv(sprintf('DB_USER=%s', $env['user']));
    putenv(sprintf('DB_PASSWORD=%s', $env['pass']));
    putenv(sprintf('DB_NAME=%s', ltrim($env['path'], '/')));

    unset($env);
}
