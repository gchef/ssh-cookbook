service "ssh"

ssh_config "Port" do
  string "Port #{node[:ssh][:port]}"
end

ssh_config "PermitRootLogin" do
  string "PermitRootLogin #{node[:ssh][:permit_root_login]}"
end

ssh_config "PasswordAuthentication" do
  string "PasswordAuthentication #{node[:ssh][:password_authentication]}"
end

ssh_config "PermitEmptyPasswords" do
  string "PermitEmptyPasswords #{node[:ssh][:permit_empty_passwords]}"
end

ssh_config "ChallengeResponseAuthentication" do
  string "ChallengeResponseAuthentication #{node[:ssh][:challenge_response_authentication]}"
end

ssh_config "UsePAM" do
  string "UsePAM #{node[:ssh][:use_pam]}"
end

ssh_config "UseDNS" do
  string "UseDNS #{node[:ssh][:use_dns]}"
end

ssh_config "AllowGroups" do
  string "AllowGroups #{node[:ssh][:allowed_groups].join(' ')}"
  only_if { node[:ssh][:allowed_groups].any? }
end

ssh_config "AllowUsers" do
  string "AllowUsers #{node[:ssh][:allowed_users].join(' ')}"
  only_if { node[:ssh][:allowed_users].any? }
end

ssh_config "DenyGroups" do
  string "DenyGroups #{node[:ssh][:denied_groups].join(' ')}"
  only_if { node[:ssh][:denied_groups].any? }
end

ssh_config "DenyUsers" do
  string "DenyUsers #{node[:ssh][:denied_users].join(' ')}"
  only_if { node[:ssh][:denied_users].any? }
end

ssh_authorized_keys "root" do
  home "/root"
  ssh_keys node[:ssh][:root_authorized_keys]
end
