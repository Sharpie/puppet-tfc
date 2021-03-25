# Declare a Terraform resource
#
# @param target
#   The name of a {tfc::config} resource to add the `resource` block to.
# @param resource_type
#   The name of the Terraform resource type to declare.
# @param resource_name
#   The name to assign to the terraform resource.
# @param args
#   The data to be used the body of the `resource` block.
define tfc::resource (
  String $target,
  String $resource_type,
  String $resource_name,
  Hash   $args = {},
) {
  # TODO: Terraform resources have specific patterns of allowed
  #       characters in names. Should type check that here.
  concat::fragment { $title:
    target  => $target,
    content => {
      resource => {
        $resource_type => {
          $resource_name => $args
        }
      }
    }.to_json,
  }
}
