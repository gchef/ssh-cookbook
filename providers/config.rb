action :add do
  bash "Adding #{new_resource.name} to sshd_config" do
    code %{
      set -x
      if [[ $(cat /etc/ssh/sshd_config) =~ "#{new_resource.match}" ]]; then
        sed -i "s/#*#{new_resource.match}.*/#{new_resource.string}/g" /etc/ssh/sshd_config
      else
        echo -en "#{new_resource.string}\n" >> /etc/ssh/sshd_config
      fi
    }
    not_if %{ egrep -c "^#{new_resource.string}$" /etc/ssh/sshd_config -q }
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end

action :add_multiline do
  bash "Adding #{new_resource.name} to sshd_config" do
    code %{
      set -x
      echo -en "#{new_resource.string}\n" >> /etc/ssh/sshd_config
    }
    not_if %{ [[ ! $(cat /etc/ssh/sshd_config) =~ "#{new_resource.match}" ]] }
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end

action :remove do
  bash "Removing #{new_resource.name} from sshd_config" do
    code %{
      set -x
      sed -i '/#{new_resource.match}.*/ d' /etc/ssh/sshd_config
    }
    only_if %{ egrep -c "^#{new_resource.string}$" /etc/ssh/sshd_config -q }
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end
