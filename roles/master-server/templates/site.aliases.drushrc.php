<?php
{% for tsadm_env in item.envs %}
$aliases['{{tsadm_env.name}}'] = array(
    'root' => '{{tsadm_homedir}}/sites/{{item.site_name}}/{{tsadm_env.name}}/docroot',
    'uri' => '{{item.site_name}}{{tsadm_env.name}}.tsadm.tincan.co.uk',
    'remote-host' => '{{tsadm_env.host_fqdn}}',
    'remote-user' => '{{item.site_name}}'
);
{% endfor %}
# {{ansible_managed}}
?>
