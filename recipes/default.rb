sshd_config do
  parameter "Port"
  value node[:ssh][:port]
  notifies :reload, "service[sshd]"
end

sshd_config do
  parameter "PermitRootLogin"
  value node[:ssh][:permit_root_login]
  notifies :reload, "service[sshd]"
end

sshd_config do
  parameter "PasswordAuthentication"
  value node[:ssh][:password_authentication]
  notifies :reload, "service[sshd]"
end

service "sshd" do
  supports :reload => true
end
