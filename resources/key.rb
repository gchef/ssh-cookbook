actions :create, :allow, :copy

attribute :host, 										:kind_of => String, :name_attribute => true
attribute :username, 								:kind_of => String
attribute :home, 								    :kind_of => String
attribute :password, 								:kind_of => String
attribute :port, 										:kind_of => Integer, :default => 22
attribute :private_key, 						:kind_of => String
attribute :public_key, 							:kind_of => String
attribute :local_ssh_key, 					:kind_of => String, :default => "~/.ssh/id_rsa"
attribute :local_known_hosts, 			:kind_of => String, :default => "~/.ssh/known_hosts"
attribute :remote_authorized_keys, 	:kind_of => String, :default => "~/.ssh/authorized_keys"
