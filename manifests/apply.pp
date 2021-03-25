# Apply Terraform configuration
#
# Instances of this type manage the execution of `terraform apply`
# on a given configuration. The apply command is only executed if
# a `terraform plan` command indicates that the configuration is
# out of sync.
#
# @param target
#   The name of a {tfc::config} resource to apply.
define tfc::apply (
  String $target,
) {
  exec { "${title} terraform apply":
    command => "${fact('tfc.path')} apply puppet_tfc.plan",
    # TODO: Support Windows.
    # TODO: Handle errors from exit code 1.
    onlyif  => "/bin/bash -c '${fact('tfc.path')} plan -detailed-exitcode -out=puppet_tfc.plan; [[ \$? -eq 2 ]]'",
    cwd     => Tfc::Config[$target]['path'],
  }
}
