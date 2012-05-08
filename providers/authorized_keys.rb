action :setup do
  directory "#{new_resource.user_home}/.ssh" do
    owner new_resource.username
    group new_resource.username
    mode  '0700'
  end

  file "#{new_resource.user_home}/.ssh/authorized_keys" do
    owner new_resource.username
    group new_resource.username
    mode   '0600'
    content new_resource.ssh_keys.join("\n")
    backup false
  end
end
