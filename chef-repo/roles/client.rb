name "client"
description "Tests for Redis Client"

run_list(
  "recipe[users::sysadmins]",
  "recipe[apps]",
  "recipe[apps-redis::yaml]",
)

default_attributes({
  "framework_environment" => "production",
  "minitest" => {
    "tests" => "apps-redis/yaml_test.rb",
  },
})
