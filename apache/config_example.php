<?php
##############################################################
# those are additional settings to be appended to config.php #
##############################################################
$CONFIG = array (
  'trusted_domains' => 
  array (
    0 => 'localhost',
  ),
  'datadirectory' => '/custom/path',
  'version' => '22.1.1.2',
  'overwrite.cli.url' => 'https://localhost',
  'overwritehost' => 'localhost',
  'overwriteprotocol' => 'https',
  'overwritewebroot' => '/',

  'htaccess.RewriteBase' => '/',

  'default_phone_region' => 'PL',

  'dbtype' => 'mysql',
  'dbname' => 'dbname',
  'dbhost' => 'mysql:3306',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'mysql.utf8mb4' => true,
  'dbuser' => 'dbusername',

  'dbpassword' => 'putheresomepassword', 

  'memcache.local' => '\\OC\\Memcache\\Redis',
  'filelocking.enabled' => 'true',
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' =>
    array (
    'host' => 'redis',
    'port' => 6379,
    'timeout' => 0,
    'dbindex' => 0
    )
);
