service 'lxc-net' do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end

cookbook_file '/etc/default/lxc-net' do
  source 'lxc-net'
  notifies :restart, 'service[lxc-net]'
end

cookbook_file '/etc/lxc/dnsmasq.conf' do
  source 'dnsmasq.conf'
  notifies :restart, 'service[lxc-net]'
end

directory '/var/lib/lxc/dnsmasq'

cookbook_file '/var/lib/lxc/dnsmasq/dhcp-hosts.conf' do
  source 'dhcp-hosts.conf'
  action :create_if_missing
  notifies :restart, 'service[lxc-net]'
end

cookbook_file '/var/lib/lxc/dnsmasq/addn-hosts.conf' do
  source 'addn-hosts.conf'
  action :create_if_missing
  notifies :restart, 'service[lxc-net]'
end

directory '/usr/local/share/lxc/hooks' do
  recursive true
end

cookbook_file '/usr/local/share/lxc/hooks/clone-etc-hosts' do
  source 'clone-etc-hosts'
  mode 00755
end

cookbook_file '/etc/lxc/default.conf' do
  source 'lxc-default.conf'
end

cookbook_file '/etc/profile.d/lxc-helpers.sh' do
  source 'lxc-helpers.sh'
end
