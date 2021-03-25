# Declare Terraform settings
#
# @param target
#   The name of a {tfc::config} resource to add a `terraform` block to.
# @param args
#   The data to be used the body of the `terraform` block.
define tfc::terraform (
  String $target,
  Hash   $args = {},
) {
  concat::fragment { $title:
    target  => $target,
    content => {'terraform' => $args}.to_json,
  }
}
