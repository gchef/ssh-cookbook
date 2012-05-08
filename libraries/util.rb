module SSH
  module Util
    def authenticate_with_remote_host
      ssh_key "local" do
        action :create
      end

      ssh_key new_resource.remote_ssh_host do
        port    new_resource.remote_ssh_port
        action  :allow
      end

      ssh_key new_resource.remote_ssh_ip do
        port    new_resource.remote_ssh_port
        action  :allow
      end

      ssh_key new_resource.remote_ssh_host do
        port      new_resource.remote_ssh_port
        username  new_resource.remote_ssh_username
        password  new_resource.remote_ssh_password
        action    :copy
      end
    end
  end
end
