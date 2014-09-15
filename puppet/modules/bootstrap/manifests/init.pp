# == class: bootstrap
#
# Full description of class bootstrap here.
#
# === Parameters
#
# [*$message*]
#   Explanation of what this parameter affects.
#   Defaults to 'default message'.
#
# === Examples
#
#  class { 'ntp':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# John Doe <john.doe@domain.com>
#
# === Copyright
#
# Copyright 2014 John Doe, unless otherwise noted.
#
class bootstrap (
  $message = 'default message',
) {
  notify { ["environment ${::environment} active!", $message]: }
}
