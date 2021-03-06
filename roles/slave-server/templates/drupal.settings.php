<?php
# {{ansible_managed}}

$tsadm_homedir = '/home/tsadmdev';

if (! isset($tsadm_site_name))
{
    $tsadm_site_name = '__NO_SITE_NAME__';
}
$tsadm_site_env = '__NO_SITE_ENV__';
$tsadm_dbname = '__NO_DBNAME__';
$tsadm_dbuser = '__NO_DBUSER__';
$tsadm_dbpass = '__NO_DBPASS__';

if (isset($tsadm_referrer))
{
    if (! empty($tsadm_referrer))
    {
        $matches = array();
        if (preg_match("#^${tsadm_homedir}/sites/(\w+)/(\w+)/docroot/#", $tsadm_referrer, $matches))
        {
            # site name could have been hardcoded from settings.php
            # as when in multisite mode in example
            if ($tsadm_site_name == '__NO_SITE_NAME__')
            {
                $tsadm_site_name = $matches[1];
            }
            # site env should be always dynamic
            $tsadm_site_env = $matches[2];
        }
    }
    unset($tsadm_referrer);
}

if ($tsadm_site_name != '__NO_SITE_NAME__' &&
    $tsadm_site_env != '__NO_SITE_ENV__')
{
    // db settings
    $databases = array();
    $tsadm_db_settings = "${tsadm_homedir}/drupal-settings/${tsadm_site_name}.${tsadm_site_env}-db.php";

    if (is_readable($tsadm_db_settings))
    {
        include($tsadm_db_settings);
        $override_settings = "${tsadm_homedir}/drupal-settings/${tsadm_site_name}.${tsadm_site_env}-db-override.php";
        if (is_readable($override_settings))
        {
            include($override_settings);
        }
    }
    else
    {
        $tsadm_dbname = $tsadm_site_name.$tsadm_site_env.'db';
        $tsadm_my_cnf = "${tsadm_homedir}/sites/${tsadm_site_name}/.my.cnf";
        if (is_readable($tsadm_my_cnf))
        {
            $cnf = @parse_ini_file($tsadm_my_cnf, true);
            if ($cnf !== FALSE)
            {
                if (array_key_exists('client', $cnf))
                {
                    if (array_key_exists('user', $cnf['client']))
                    {
                        $tsadm_dbuser = $cnf['client']['user'];
                    }
                    if (array_key_exists('password', $cnf['client']))
                    {
                        $tsadm_dbpass = $cnf['client']['password'];
                    }
                }
            }
        }
        unset($tsadm_my_cnf);

        $databases = array (
          'default' => array (
            'default' => array (
              'database' => $tsadm_dbname,
              'username' => $tsadm_dbuser,
              'password' => $tsadm_dbpass,
              'host' => 'localhost',
              'port' => '',
              'driver' => 'mysql',
              'prefix' => '',
            ),
          ),
        );
    }

    // hash salt and tmp and private dirs path
    $drupal_hash_salt = md5('TSADM'.$tsadm_site_name.$tsadm_site_env.'TSADM');
    $conf['file_private_path'] = "${tsadm_homedir}/private/${tsadm_site_name}.${tsadm_site_env}";
    $conf['file_temporary_path'] = "${tsadm_homedir}/private/${tsadm_site_name}.${tsadm_site_env}/tmp";

    if (!is_dir($conf['file_private_path'])) {
      @mkdir($conf['file_private_path']);
    }
    if (!is_dir($conf['file_temporary_path'])) {
      @mkdir($conf['file_temporary_path']);
    }

    // setup memcache if backend was set
    if (isset($tsadm_memcache_backend))
    {
        if (! empty($tsadm_memcache_backend))
        {
            $conf['cache_backends'][] = "${tsadm_memcache_backend}";
            $conf['cache_default_class'] = 'MemCacheDrupal';
            $conf['cache_class_cache_form'] = 'DrupalDatabaseCache';
            $conf['memcache_key_prefix'] = "${tsadm_site_name}${tsadm_site_env}";
        }
    }

    // #38057: reverse_proxy setup
    $conf['reverse_proxy'] = TRUE;
    $conf['reverse_proxy_addresses'] = array('127.0.0.1');
}

unset($tsadm_site_name);
unset($tsadm_site_env);
unset($tsadm_dbname);
unset($tsadm_dbuser);
unset($tsadm_dbpass);
unset($tsadm_db_settings);

# {{ansible_managed}}
