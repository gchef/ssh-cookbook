# Port on which openssh listens on
default[:ssh][:port] = "22"
#
# Change to yes to enable tunnelled clear text passwords
# Be very sure about your reasons before enabling this
default[:ssh][:password_authentication] = "no"
#
# This is already the default on most good distros
default[:ssh][:permit_empty_passwords] = "no"
#
# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
default[:ssh][:challenge_response_authentication] = "no"
#
# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication no
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin no
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication no
# and ChallengeResponseAuthentication to 'no'.
default[:ssh][:use_pam] = "yes"
#
# SSH logins should be fast. Why would you slow them down by resolving IPs on
# every login?
default[:ssh][:use_dns] = "no"
#
# Disabling password logins, challenger response authentication and root logins
# is a great step towards a secure system, but there are usually several
# administrative accounts which need to exist for UNIX reasons, but which don't
# actually need to log in. Both those options ensure that SSH logins are
# restricted to specific groups or users (or both).
#
# I personally prefer the groups approach as it's more flexible. These are the
# 4 more common groups which you might end up adding to node[:ssh][:allowed_groups]:
# * vagrant (you're doing all your staging on local VMs, controlled by vagrant, right?)
# * ubuntu (if you're running on AWS, you definitely want this group added)
# * deploy (all apps get their own system user, and belong to the deploy group)
# * admin (system users with admin privileges. Pretty much everyone that is
#   expected to be in charge of your infrastructure).
default[:ssh][:allowed_groups] = []
default[:ssh][:allowed_users] = []
#
# This is useful when you want to disable users.  The bootstrap cookbook adds
# all disabled system users to the nologin group.  This here adds the nologin
# group to the DenyGroups. You can have finer control by using :denied_users.
default[:ssh][:denied_groups] = ["nologin"]
default[:ssh][:denied_users] = []
#
# Needs no introduction
default[:ssh][:permit_root_login] = "no"
#
# If root login is enabled, define which keys are authorized for root login You
# shouldn't really enable root login, but if you really must, DO NOT enable
# password authentication. With both options enabled, your server will become
# very vulnerable.
default[:ssh][:root_authorized_keys] = []
