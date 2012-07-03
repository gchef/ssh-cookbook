The main purpose of this cookbook is to make openssh more secure.

One of the first things to do on a production server is to:

* disable root logins
* disable password logins
* disable challenge response authentication
* disable dns lookups

All these are cookbook's defaults, fully configurable via attributes.
Before changing any of those defauls, make sure that you fully
understand the implication.

To further increase the security, you can define specific groups (via
`:allowed_groups`) and users (via `:allowed_users`) which are allowed to
login via SSH. Everyone outside those groups or users (or both) won't be
able to login.

I personally prefer the groups approach as it's more flexible. These are
the more common groups which you might want to define in your
`node[:ssh][:allowed_groups]`:

* vagrant (you're doing all your staging on local VMs, controlled by vagrant, right?)
* ubuntu (if you're running on AWS, you definitely want this group added)
* deploy (all apps get their own system user, and belong to the deploy group)
* admin (system users with admin privileges. Pretty much everyone that is
  expected to be in charge of the infrastructure).

## LWRP

### ssh\_authorized\_keys

Ensures `~/.ssh` & `~/.ssh/authorized_keys` are setup correctly
(mainly permissions). It also populates the authorized\_keys file with
specific keys:

```ruby
ssh_authorized_keys "root" do
  home "/root"
  ssh_keys node[:ssh][:root_authorized_keys]
end
```

### ssh\_config

Handles sshd\_config CRUD. This is how AllowGroups in
`/etc/ssh/sshd_config` gets managed:

```ruby
ssh_config "AllowGroups" do
  string "AllowGroups #{node[:ssh][:allowed_groups].join(' ')}"
  only_if { node[:ssh][:allowed_groups].any? }
end
```

### ssh\_key

Handles passphraseless key generation, makes remote hosts known
(eg. github.com) and copies SSH keys between hosts.
