<?php
# {{ansible_managed}}
{% for tsadm_env in tsadmdb_siteenv.values() %}
{% if tsadm_env.site_id == item %}
# *** {{tsadmdb_site[item].name}}.{{tsadm_env.name}}
$aliases['{{tsadm_env.name}}'] = array(
    'root' => '{{tsadm_homedir}}/sites/{{tsadmdb_site[item].name}}/{{tsadm_env.name}}/docroot',
    'uri' => '{{tsadmdb_site[item].name}}{{tsadm_env.name}}.{{tsadm_master_domain}}',
{% if tsadmdb_host[tsadm_env.host_id].fqdn != inventory_hostname %}
    'remote-host' => '{{tsadmdb_host[tsadm_env.host_id].fqdn}}',
    'remote-user' => '{{tsadm_user}}',
    'path-aliases' => array(
        '%dump-dir' => '/var/tmp/',
    ),
{% endif %}
);
{% endif %}
{% endfor %}
# {{ansible_managed}}
?>
