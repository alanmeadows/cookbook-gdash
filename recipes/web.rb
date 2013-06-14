basedir = node['gdash']['base_dir']

#--------------------------
# configure passenger
#--------------------------

include_recipe "passenger_apache2"

#-------------------------
# auth
#-------------------------

case node['gdash']['http_auth_method']
  when "digest"
    include_recipe "apache2::mod_auth_digest"
    execute "install digest auth_users" do
      command "(echo -n \"#{node['gdash']['http_auth_user']}:#{node['gdash']['http_auth_realm']}:\" && echo -n \"#{node['gdash']['http_auth_user']}:#{node['gdash']['http_auth_realm']}:#{node['gdash']['http_auth_password']}\" | md5sum - | cut -d' ' -f1) > #{node['gdash']['http_auth_file']}"
      creates node['gdash']['http_auth_file']
    end

  when "basic"
    execute "install basic auth_users" do
      command "/usr/bin/htpasswd -c -b #{node['gdash']['http_auth_file']} #{node['gdash']['http_auth_user']} #{node['gdash']['http_auth_password']}"
      creates node['gdash']['http_auth_file']
    end

  when "cas"
    include_recipe "apache2::mod_auth_cas"
end


#------------------------
# gdash apache
#------------------------

if node['gdash']['enable_vhost'] 
  template "/etc/apache2/sites-available/gdash" do
    source "gdash-vhost.conf.erb"
    notifies :restart, "service[apache2]"
    owner node["gdash"]["owner"]
    group node["gdash"]["group"]
  end
  apache_site "gdash" do
    notifies :restart, "service[apache2]"
  end
end
