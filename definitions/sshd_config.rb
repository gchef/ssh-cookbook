define :sshd_config, :parameter => nil, :value => nil do
  if params[:parameter]
    sshd_config = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    search = eval("/^.*#{params[:parameter]}.*$/")
    replace = "#{params[:parameter]} #{params[:value]}"

    sshd_config.search_file_replace_line(search, replace)
    sshd_config.write_file
  end
end
