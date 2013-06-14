include_attribute "apache2"

# uri for github download
default['gdash']['uri'] = "https://github.com/ripienaar/gdash/tarball/master"

# apache server settings
default['gdash']['server_hostname'] = "gdash"
default['gdash']['server_hostname_aliases'] = []
default['gdash']['url'] = "http://#{node['gdash']['server_hostname']}/"
default['gdash']['listen_port'] = "80"
default['gdash']['base_dir'] = "/opt/gdash"
default['gdash']['doc_root'] = "/opt/gdash/public"

# authentication
default['gdash']['http_auth_method'] = "digest"
default['gdash']['http_auth_realm'] = "#{node.chef_environment} gdash"
default['gdash']['http_auth_user'] = "admin"
default['gdash']['http_auth_password'] = "gdash"
default['gdash']['http_auth_file'] = "#{node['apache']['dir']}/auth_users"

# cas
default['gdash']['cas_login_url'] = "https://example.com/cas/login"
default['gdash']['cas_validate_url'] = "https://example.com/cas/serviceValidate"
default['gdash']['cas_root_proxy_url'] = nil
default['gdash']['cas_validate_server'] = "off"

# gdash settings
default['gdash']['enable_vhost'] = true
default['gdash']['rubybin'] = nil
default['gdash']['templatedir'] = "/opt/gdash/graph_templates"
default['gdash']['owner'] = "www-data"
default['gdash']['group'] = "www-data"
default['gdash']['basic_auth'] = false
default['gdash']['username'] = "gdash"
default['gdash']['password'] = "gdash"
default['gdash']['title'] = "Dashboard"
default['gdash']['prefix'] = nil
default['gdash']['refresh_rate'] = 60
default['gdash']['columns'] = 2
default['gdash']['graphite_whisperdb'] = "/var/storage/whisper"
