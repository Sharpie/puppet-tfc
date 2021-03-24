# Declare Terraform configuration
#
# The `tfc::config` type manages the top level declaration of Terraform
# configuration.
#
# @param path
#   A path to the storage location for the configuration. A directory
#   will be created at this location and used to hold Terraform
#   configuration and state files.
define tfc::config (
  Stdlib::Absolutepath $path = $title,
) {
  # TODO: Fail if fact('tfc.path') does not return a path to the
  #       terraform CLI.
  $_config_file = "${path}/puppet_tfc.tf.json"

  file { $path:
    ensure => directory,
  }

  concat { $title:
    ensure         => present,
    path           => $_config_file,
    format         => 'json-array-pretty',
    ensure_newline => true,
    warn           => false,
    require        => File[$path],
  }

  concat::fragment { "${title} header":
    target  => $title,
    content => '{"//": "This file is managed by Puppet. Changes will be overwritten."}',
    order   => '0',
  }

  exec { "${title} terraform init":
    command     => "${fact('tfc.path')} init",
    cwd         => $path,
    refreshonly => true,
    subscribe   => Concat[$title],
  }
}
