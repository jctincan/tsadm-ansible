<?php
# {{ansible_managed}}

{% for senv in tsadmdb_siteenv.values() %}
{% if senv.site_id == item.0.site_id %}
$aliases['{{senv.name}}'] = array(
    'root' => '{{tsadm_homedir}}/sites/{{tsadmdb_site[item.0.site_id].name}}/{{senv.name}}/docroot',
    'uri' => '{{tsadmdb_site[item.0.site_id].name}}{{senv.name}}.tsadm.tincan.co.uk',
    'remote-host' => '{{tsadmdb_host[senv.host_id].fqdn}}',
    'remote-user' => '{{tsadmdb_site[item.0.site_id].name}}'
);

{% endif %}
{% endfor %}
# {{ansible_managed}}
?>
