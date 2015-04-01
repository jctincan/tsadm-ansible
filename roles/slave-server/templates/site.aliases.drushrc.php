<?php
# {{ansible_managed}}

{% for tsadm_env in item.envs %}
$aliases['{{tsadm_env.name}}'] = array(
    'root' => '{{tsadm_homedir}}/sites/{{item.site_name}}/{{tsadm_env.name}}/docroot',
    'uri' => '{{item.site_name}}{{tsadm_env.name}}.tsadm.tincan.co.uk',
{% if tsadm_env.host_fqdn != inventory_hostname %}
    'remote-host' => '{{tsadm_env.host_fqdn}}',
    'remote-user' => 'tsadm',
    'path-aliases' => array(
        '%dump-dir' => '/var/tmp/',
    ),
{% endif %}
);

{% endfor %}
# {{ansible_managed}}
?>
