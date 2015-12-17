<?php
# {{ansible_managed}}

$databases = array (
  'default' => array (
    'default' => array (
      'database' => '{{tsadmdb_siteenv[item].site_slug}}{{tsadmdb_siteenv[item].name}}db',
      'username' => '{{tsadmdb_siteenv[item].site_slug}}',
      'password' => "{{ lookup('password', privdir+'/'+inventory_hostname+'.'+tsadmdb_siteenv[item].site_slug+'.my.passwd chars=ascii_letters,digits') }}",
      'host' => '{{mysql_login_host}}',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);

# {{ansible_managed}}
