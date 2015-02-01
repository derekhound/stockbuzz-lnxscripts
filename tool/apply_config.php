#!/usr/bin/php
<?php

define('ROOT', dirname(__FILE__).'/..');

// nginx
define('NGINX_REL_HOSTNAME',	'stockbuzz.cc');
define('NGINX_DEV_HOSTNAME',	'stockbuzz.no-ip.info');


function usage()
{
   $doc = <<<EOF
    ./apply_config --type rel
    ./apply_config --type dev

EOF;

   echo $doc;
}

function get_opts()
{
	// short
	$shortopts  = '';

	// long
	$longopts  = array(
		'help',
		'type:'
	);

	// getopt
	$opts = getopt($shortopts, $longopts);

	return $opts;
}

function escape($str)
{
	$str = preg_replace('@/@u', '\/', $str);
	return $str;
}

function nginx_config($type)
{
	$path 	= escapeshellarg(ROOT.'/dist/etc/nginx/sites-available/stockbuzz');

	// nginx hostname
	$url	= ($type == 'rel') ? escape(NGINX_REL_HOSTNAME) : escape(NGINX_DEV_HOSTNAME);
	$cmd 	= "sed -i 's/NGINX_HOSTNAME/{$url}/g' $path";
	exec($cmd, $output, $ret);
	$status = ($ret == 0) ? 'OK' : 'Not OK';
	echo "[NGINX_HOSTNAME] apply config...[{$status}]\n";
}

function main()
{
	// get opts
	$opts = get_opts();

	// usage
	if (empty($opts) || isset($opts['help'])) {
		usage();
		exit(0);
	}

	// type
	$type = $opts['type'];

	// nginx config
	nginx_config($type);
}

main();
