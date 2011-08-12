action :create do
  execute "Create a passphraseless SSH key if missing" do
    command "ssh-keygen -t rsa -q -f #{new_resource.local_ssh_key} -P ''"
    not_if "test -f #{new_resource.local_ssh_key}"
  end
end

action :allow do
  execute "Make remote host known" do
    command "ssh-keyscan -p #{new_resource.port} #{new_resource.host} >> #{new_resource.local_known_hosts}"
    not_if "ssh-keygen -F #{new_resource.host}"
  end
end

action :copy do
  # http://serverfault.com/questions/252300/copying-local-ssh-key-to-remote-host-if-it-doesnt-exist-already
  # KEY=$(cat ~/.ssh/id_rsa.pub) ssh -p <port> <user>@<hostname> "if [ -z \"\$(grep \"$KEY\" ~/.ssh/authorized_keys )\" ]; then echo $KEY >> ~/.ssh/authorized_keys; echo key added.; fi;"
  # now to figure the expect on the same 1-liner...
  ruby_block "Copy local SSH key to remote host" do
    block do
      require 'net/ssh'
      Net::SSH.start(new_resource.host, new_resource.username, :password => new_resource.password, :port => new_resource.port) do |ssh|
        local_public_key = `cat #{new_resource.local_ssh_key}.pub`.chomp
        ssh.exec! %{
          if ( ! grep -q '#{local_public_key}' #{new_resource.remote_authorized_keys} ); then echo '#{local_public_key}' >> #{new_resource.remote_authorized_keys}; fi
        }
      end
    end
  end
end
