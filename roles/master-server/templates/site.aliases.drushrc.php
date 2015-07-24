<?php
# {{ansible_managed}}

{% for senv in tsadmdb_siteenv.values() %}
{% if senv.site_id == tsadmdb_site[item].id %}
$aliases['{{senv.name}}'] = array(
    'root' => '{{tsadm_homedir}}/sites/{{tsadmdb_site[item].name}}/{{senv.name}}/docroot',
    'uri' => '{{tsadmdb_site[item].name}}{{senv.name}}.{{siteenv_domain_suffix}}',
    'remote-host' => '{{tsadmdb_host[senv.host_id].fqdn}}',
    'remote-user' => '{{tsadmdb_site[item].slug}}'
);

{% endif %}
{% endfor %}
# {{ansible_managed}}
?>
