service "ssh"

ssh_config "Subsystem sftp" do
  string "Subsystem sftp internal-sftp"
end

ssh_config "Match group sftp" do
  string "Match group sftp\\n  X11Forwarding no\\n  ChrootDirectory %h\\n  AllowTcpForwarding no\\n  ForceCommand internal-sftp\\n"
  action :add_multiline
end
