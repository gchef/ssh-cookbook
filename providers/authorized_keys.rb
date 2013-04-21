action :setup do
  directory "#{new_resource.home}/.ssh for authorized_keys" do
    path "#{new_resource.home}/.ssh"
    owner new_resource.username
    group new_resource.username
    mode  '0700'
  end

  file "#{new_resource.home}/.ssh/authorized_keys" do
    owner new_resource.username
    group new_resource.username
    mode   '0600'
    content new_resource.ssh_keys.join("\n")
    backup false
  end
end
