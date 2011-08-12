define :authorized_keys do
  username = params[:name]
  ssh_keys = params[:ssh_keys]
  home     = username == 'root' ? '/root' : "/home/#{username}"

  directory "#{home}/.ssh" do
    owner username
    group username
    mode  '0700'
  end

  file "#{home}/.ssh/authorized_keys" do
    owner username
    group username
    mode   '0600'
    action :create_if_missing
    backup false
  end

  ruby_block 'add_ssh_keys' do
    block do
      file = "#{home}/.ssh/authorized_keys"
      File.open(file, 'w') { |f| f.puts ssh_keys }
    end
  end
end
