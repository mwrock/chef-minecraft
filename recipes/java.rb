case node['platform_family']
when 'windows'
  include_recipe 'chocolatey'
  chocolatey 'javaruntime'
else
  include_recipe "java::#{node['java']['install_flavor']}"
end
