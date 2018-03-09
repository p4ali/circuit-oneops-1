#
# openstack::status - gets quota info
# 

require 'fog'

token = node[:workorder][:ci][:ciAttributes]

begin
  domain = token.key?('domain') ? token[:domain] : 'default'

  conn = Fog::Compute.new({
    :provider => 'OpenStack',
    :openstack_api_key => token[:password],
    :openstack_username => token[:username],
    :openstack_tenant => token[:tenant],
    :openstack_auth_url => token[:endpoint],
    :openstack_project_name => token[:tenant],
    :openstack_domain_name => domain
  })  

  Chef::Log.info("credentials ok")

rescue Exception => e
  Chef::Log.error("credentials bad: #{e.inspect}")
  e = Exception.new("no backtrace")
  e.set_backtrace("")
  raise e
end

